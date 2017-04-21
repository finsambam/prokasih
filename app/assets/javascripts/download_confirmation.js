$("body").on('blur', 'input#email', function(){
  var email = $("#email").val();
  var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;  
  if (email != null) {
    if (testEmail.test(email)) {
      $('#submit-btn').removeClass('disabled');
      $('#submit-btn').prop('disabled', false);
      return true;
    };
  };
  $('#submit-btn').addClass('disabled');
  $('#submit-btn').prop('disabled', true);
  return false;
})