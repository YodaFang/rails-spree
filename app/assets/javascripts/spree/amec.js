Spree.ready(function($) {
  Spree.addToCartFormSubmissionOptions = function() {
    var stockId = $('#stock_location_id').val();
    if(stockId){
      return { stock_location_id: parseInt(stockId) };
    } else {
      return {};
    }
  }
})