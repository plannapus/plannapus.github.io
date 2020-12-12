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
categories <- function(html_file){
  h <-htmlParse(html_file,encoding="utf-8")
  x <- as.data.frame(do.call(rbind,xpathApply(h,"//meta[@name='category']",xmlAttrs)))[['content']]
  `if`(length(x),x,NA)
}

catg <- sapply(entries,categories)
all <- do.call(rbind,lapply(entries,process))
catg <- catg[order(all$date,decreasing=TRUE)]
all <- all[order(all$date,decreasing=TRUE),]
cats <- names(sort(table(unlist(catg)),decreasing=TRUE))

index <- readLines("index.html",encoding="utf-8")
j <- sprintf("\t\t\t<tr><td class=\"date\">%s</td><td class=\"title\"><a href=\"%s\">%s</a></td></tr>",all$date, all$url, all$title)
index <- c(index[1:grep("<table",index)],j,index[grep("</table",index):length(index)])
index[grep(">Categories:",index)] <- sprintf("\t\t\t<div class=\"footer\">Categories: %s<br/>",paste(sprintf("<a href=\"categories/%1$s.html\">%1$s</a>",cats),collapse=" - "))
cat(index,file="index.html",sep="\n")

for(i in seq_along(cats)){
  index <- readLines("categories/template.html",encoding="utf-8")
  w <-sapply(catg,function(x)cats[i]%in%x)
  sub <- all[w,]
  j <- sprintf("\t\t\t<tr><td class=\"date\">%s</td><td class=\"title\"><a href=\"../%s\">%s</a></td></tr>",sub$date, sub$url, sub$title)
  index <- c(index[1:grep("<table",index)],j,index[grep("</table",index):length(index)])
  index[grep("<h3>",index)] <- sprintf("<div class=\"footer\"><h3>Category: %s</h3></div>",cats[i])
  cat(index,file=sprintf("categories/%s.html",cats[i]),sep="\n")
}

rss_header <- "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<rss version=\"2.0\">\n<channel><title>Johan Renaudie - Blog</title><link>https://plannapus.github.io/blog/index.html</link><description>A little bit of science, a little bit of programming, a little bit of cooking...</description>"
rss_footer <- "</channel>\n</rss>"
k <- c()
for(i in 1:nrow(all)){
  k[i]<-sprintf("<item><title>%s</title><link>%s</link><pubDate>%s</pubDate><description>%s</description>%s</item>",
          all$title[i],
          paste0("http://plannapus.github.io/blog/",all$url[i]),
          all$date[i],
          gsub("^[[:space:]]*([^\n]+)\n.+$","\\1",all$content[i]), #Regex to isolate first sentence
          #ifelse(is.na(lang),"",sprintf("<category>%s</category>",lang)))
          ifelse(all(is.na(catg[[i]])),"",paste(sprintf("<category>%s</category>",catg[[i]]),collapse="")))
}
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

