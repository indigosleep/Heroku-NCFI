// {"discount": "PaySleepForward"}
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

(async function() {
  console.log("Patch");
  await sleep(500);
  var mattressDivs = document.getElementsByClassName('shogun-root');
  if (mattressDivs.length > 1) {
    mattressDivs[1].style.display = 'none';
    console.log("Extra shogun-root div suppressed");
  }
})();
