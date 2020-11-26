jQuery('.twitter-feed').delegate('#twitter-widget-0','DOMSubtreeModified propertychange', function() {
//function call to override the base twitter styles
customizeTweetMedia();
});

var customizeTweetMedia = function() {

//overrides font styles and removes the profile picture and media from twitter feed
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-media').css('display', 'none');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('img.Avatar').css('display', 'none');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('span.TweetAuthor-avatar.Identity-avatar').remove();
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('span.TweetAuthor-screenName').css('font-size', '16px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-author').css('padding-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('margin-bottom', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-text').css('white-space', 'normal');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-inReplyTo').css('padding-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-retweetCredit').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Tweet-actions').css('margin-left', '1px');
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-TweetList-tweet').css('border-top','1px solid rgb(222,122,0)')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-TweetList-tweet:first-of-type').css('border-top','none')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Body').css('border-top','1px solid rgb(222,122,0)')
jQuery('.twitter-feed').find('.twitter-timeline').contents().find('.timeline-Body').css('border-bottom','none')
  //also call the function on dynamic updates in addition to page load
  jQuery('.twitter-block').find('.twitter-timeline').contents().find('.timeline-TweetList').bind('DOMSubtreeModified propertychange', function() {
   customizeTweetMedia(this);
});
}
