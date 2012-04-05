document.observe("dom:loaded", function() {
  if ( check_box = $("book_published") ) {
    check_box.observe("change", function() {
      if (check_box.checked)
        $("password_toggle").hide()
      else
      {
        $("password_toggle").show()
        $("book_password").focus()
      }
    })
  }
  
  attach_book_form_events()
})

function attach_book_form_events() {
  $$(".price").each(function(price) {
    var default_quantity = price.select(".quantity_default").first()
    var default_check_box = default_quantity.select("input[type=checkbox]").first()
    var quantity = price.select(".quantity").first()
    var quantity_input = quantity.select("input").first()
    
    default_check_box.observe("change", function() {
      if (default_check_box.checked)
        quantity.hide()
      else {
        quantity.show()
        quantity_input.focus()
      }
    })
    
    quantity_input.observe("keyup", function() {
      console.log(quantity_input.value)
      if (quantity_input.value == "")
        default_quantity.show()
      else
        default_quantity.hide()
    })
  })
}

function remove_fields(link) {  
  $(link).up().previous("input[type=hidden]").value = "1";  
  $(link).up(".price").hide();  
}

function add_fields(link, association, content) {  
  var new_id = new Date().getTime();  
  var regexp = new RegExp("new_" + association, "g");  
  $(link).up().insert({  
    after: content.replace(regexp, new_id)  
  });
  
  attach_book_form_events();
}