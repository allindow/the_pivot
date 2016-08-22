$(document).ready(function(){

  function move(progress_amount) {
    var elem = document.getElementById("myBar");
    var progress = (progress_amount/1000) * 100
    var width = 1;
    var id = setInterval(frame, 20);
    function frame() {
      if (width >= progress) {
        clearInterval(id);
      } else {
        width++;
        elem.style.width = width + '%';
        document.getElementById("label").innerHTML = progress + '%';
      }
    }
  }
  var progress = getId();
  // $.ajax(
  //   {url: "/api/v1/progress",
  //   method: "GET", data: {id: divId}, success: function(data) {
  //     debugger
  //     move(data);
  //   }
  //   // $("#div1").html(result);
  // });

  function getId() {
    var progressDiv = $("#myProgress");
    return parseInt(progressDiv.data("id"));
  }

  move(progress);
});
