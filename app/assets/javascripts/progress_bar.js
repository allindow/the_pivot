$(document).ready(function(){

  function move(progress_amount) {

    var elem = document.getElementById("myBar");
    var width = (progress_amount / 500) * 100;
    var id = setInterval(frame, 10);
    function frame() {
      if (width >= 500) {
        clearInterval(id);
      } else {
        elem.style.width = width + '%';
      }
    }
  }
  var divId = getId();
  $.ajax(
    {url: "/api/v1/progress",
    method: "GET", data: {id: divId}, success: function(data) {
      move(data);
    }
    // $("#div1").html(result);
  });

  function getId() {
    var progressDiv = $("#myProgress");
    return progressDiv.data("id");
  }
});
