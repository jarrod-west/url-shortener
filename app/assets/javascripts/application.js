//= require clipboard
//= require jquery


// Create the clipboard object after the page has loaded
$(document).ready(function(){
  let clipboard = new Clipboard('.clipboard-btn');

  // Don't highlight the text
  clipboard.on('success', function(event) {
    event.clearSelection();
  });
});
