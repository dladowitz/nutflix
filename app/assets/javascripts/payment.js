//Sends credit card info to stripe for a token
jQuery(function($) {
  $('#payment-form').submit(function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken({
      number:    $("#card-number").val(),
      cvc:       $("#security-code").val(),
      exp_month: $("#expiry-month").val(),
      exp_year:  $("#expiry-year").val()
    }, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });
});

//Gets either a token or error message back from stripe
function stripeResponseHandler(status, response) {
  var $form = $('#payment-form');

  if (response.error) {
    // Show the errors on the form
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    // response contains id and card, which contains additional card details
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    // and submit
    $form.get(0).submit();
  }
};
