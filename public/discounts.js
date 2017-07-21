// {"discount": "PaySleepForward"}

( function() {

  console.log("Heroku loaded");

  document.getElementById('checkout_reduction_code').value="PaySleepForward";
  document.getElementsByClassName('edit_checkout animate-floating-labels')[0].submit();

})();
