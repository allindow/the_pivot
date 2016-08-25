$(document).ready(function(){
  var $recipients = $('.recipient');

  $('#recipient_filter_all').on("keyup", function(){
    var currentData = this.value;

    $recipients.each(function(index, recipient){
      $recipient = $(recipient);
      if ($(recipient).data("all").toLowerCase().indexOf(currentData.toLowerCase()) !== -1 ){
        $(recipient).show();
      } else {
        $(recipient).hide();
      }
    });
  });
});
