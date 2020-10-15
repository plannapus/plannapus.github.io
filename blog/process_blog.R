library(XML)
setwd("/Users/johan.renaudie/Documents/Programming/#GitHub/plannapus.github.io/blog")
entries <- dir(pattern="[0-9].html")
process <- function(html_file){
  h <-htmlParse(html_file,encoding="utf-8")
  tit <- xpathSApply(h,"//p[@class='blog-title']",xmlValue)
  dat <- xpathSApply(h,"//p[@class='blog-date']",xmlValue)
  desc <- xpathSApply(h,"//p[@class='blog-content']",xmlValue)
  data.frame(url=html_file,title=tit,date=as.Date(dat),content=desc)
}
code <- function(html_file){
  h <-htmlParse(html_file,encoding="utf-8")
  x <- xpathSApply(h,"//pre/code",xmlAttrs)[['class']]
  ifelse(is.null(x),NA,x)
}
lang <- sapply(entries,code)
all <- do.call(rbind,lapply(entries,process))
lang <- lang[order(all$date,decreasing=TRUE)]
all <- all[order(all$date,decreasing=TRUE),]
index <- readLines("index.html",encoding="utf-8")
j <- sprintf("\t\t\t<tr><td class=\"date\">%s</td><td class=\"title\"><a href=\"%s\">%s</a></td></tr>",all$date, all$url, all$title)
index <- c(index[1:grep("<table",index)],j,index[grep("</table",index):length(index)])
cat(index,file="index.html",sep="\n")

rss_header <- "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<rss version=\"2.0\">\n<channel><title>Johan Renaudie - Blog</title><link>https://plannapus.github.io/blog/index.html</link><description>A little bit of science, a little bit of programming, a little bit of cooking...</description>"
rss_footer <- "</channel>\n</rss>"
k <- sprintf("<item><title>%s</title><link>%s</link><pubDate>%s</pubDate><description>%s</description>%s</item>",
             all$title,
             paste0("http://plannapus.github.io/blog/",all$url),
             all$date,
             gsub("^[[:space:]]*([^\n]+)\n.+$","\\1",all$content), #Regex to isolate first sentence
             ifelse(is.na(lang),"",sprintf("<category>%s</category>",lang)))
cat(rss_header,k,rss_footer,file="rss.xml",sep="\n")

template <- readLines("template.html")
template <- gsub(as.character(all$date[2]),as.character(all$date[1]),template)
cat(template,file="template.html",sep="\n")

last_html <- entries[grepl(as.character(all$date[2]),entries)]
last <- readLines(last_html)
w <- grep("Back to Index",last)
last[w] <- gsub("<!--\\| <a href=\"\">Next entry &gt;</a>-->",
                sprintf("| <a href=\"%s.html\">Next entry &gt;</a>",all$date[1]),
                last[w])
cat(last,sep="\n",file=last_html)
