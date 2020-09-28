var url ='https://www.iucnredlist.org/species/1301/511335';
var page = new WebPage() 
var fs = require('fs'); 

page.open(url, function (status) { 
  just_wait(); 
}); 

function just_wait() { 
  setTimeout(function() { 
    fs.write('species.html', page.content, 'w'); 
    phantom.exit(); 
  }, 2500); 
}