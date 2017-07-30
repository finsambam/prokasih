window.setTimeout(function() {
  $(".alert:not(#alert-reply)").fadeTo(500, 0).slideUp(500, function(){
    $(this).remove(); 
  });
}, 4000);