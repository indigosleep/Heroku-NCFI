// {"discount": "PaySleepForward"}

( function() {

  console.log("Heroku loaded");

  if (document.getElementsByClassName('applied-reduction-code__information').length === 0) {

    document.getElementById('checkout_reduction_code').value="PaySleepForward";

    document.getElementsByClassName('edit_checkout')[0].submit();

  }


})();
