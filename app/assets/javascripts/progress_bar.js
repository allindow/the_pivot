$(document).ready(function(){

if(document.getElementById("myBar")) {
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
        document.getElementById("label").innerHTML = parseInt(progress) + '%';
      }
    }
  }
  var progress = getId();

  function getId() {
    var progressDiv = $("#myProgress");
    return parseInt(progressDiv.data("id"));
  }

  move(progress);
};
});
