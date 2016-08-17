$(document).ready(function(){
  
  var $recipients = $('.home-recipient-wrapper');
  
  $('#recipient_filter_name').on("keyup", function(){
    var $currentName = this.value;
        
    $recipients.each(function(index, recipient){
      if ($(recipient).data("name").toLowerCase().indexOf($currentName) !== -1 ){
        $(recipient).show();
      } else {
        $(recipient).hide();
      };
    });
  });
})