$(document).ready( function() {
  $.getScript("/parks/" + $("#park_slug").val() + ".js"); 
});
