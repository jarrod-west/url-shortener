//= require clipboard
//= require jquery


// Create the clipboard object after the page has loaded
$(document).ready(function(){
  let clipboard = new Clipboard('.copy-button');

  // Don't highlight the text
  clipboard.on('success', function(event) {
    event.clearSelection();
  });
});

function copyClicked(event) {
  // Change the text to indicate the value was copied
  event.value = "Copied!";
}