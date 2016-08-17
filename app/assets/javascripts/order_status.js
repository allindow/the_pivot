$(document).ready(function () {

  var $fundings = $('.funding')

  $('#funding_filter_status').on('change', function() {
    var currentStatus = this.value;
    $fundings.each(function (index, funding) {
      $funding = $(funding);
        if ($funding.data('status') === currentStatus) {
          $funding.show();
        } else {
          $funding.hide();
      }
    });
  });

  $("#admin-fundings").click(function () {
    $("#admin-fundings-target").slideToggle(400)
  });

  $("#admin-account").click( function () {
    $("#admin-account-target").slideToggle(400)
  });
});
