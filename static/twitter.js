jQuery('.twitter-feed').delegate('#twitter-widget-0','DOMSubtreeModified propertychange', function() {
customizeTweetMedia();
});

var customizeTweetMedia = function() {
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('img.Avatar').css('display', 'none');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('span.TweetAuthor-avatar.Identity-avatar').remove();
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('a.PrettyLink').css('color','rgb(222,122,0)')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('font-size', '16px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Header').css('display', 'none');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-LoadMore').css('display','none')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-media').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-author').css('padding-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('margin-bottom', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('white-space', 'normal');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-inReplyTo').css('padding-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-retweetCredit').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-actions').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-TweetList-tweet').css('border-top','1px solid rgb(222,122,0)')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-TweetList-tweet:first-of-type').css('border-top','none')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Body').css('border','1px solid rgb(222,122,0)')
}
