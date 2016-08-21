$(document).ready(function(){
  
  var $organizations = $('.home-organization-wrapper');
  
  $('#organization_filter_name').on("keyup", function(){
    var $currentName = this.value;
        
    $organizations.each(function(index, organization){
      if ($(organization).data("name").toLowerCase().indexOf($currentName) !== -1 ){
        $(organization).show();
      } else {
        $(organization).hide();
      }
    });
  });
});