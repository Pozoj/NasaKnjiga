PricePreview = {
  timeout: 0,
  input: null,
  old_value: {order_discount: 0, order_quantity: 0},
  
  handleTyping: function(e) {
    PricePreview.input = Event.element(e);

    if ( PricePreview.old_value[PricePreview.input.id] != PricePreview.input.value )
    {
      PricePreview.old_value[PricePreview.input.id] = PricePreview.input.value;
      // We enter here if the input value is not blank. Or if we're at discount, because it CAN be blank.
      if ((PricePreview.input.value != "") || (PricePreview.input.id == "order_discount"))
      {
        if ( PricePreview.timeout ) {
          clearTimeout(PricePreview.timeout)
          PricePreview.timeout = null
        }
        PricePreview.timeout = setTimeout(PricePreview.update, 250)
      }
    }
  },
  
  update: function() {
    if ( ($("order_quantity").value < 0) || ($("order_discount").value < 0) || ($("order_discount").value == "") || ($("order_discount").value == "") ) return
    
    var url = ""
    if (document.location.href.indexOf("edit") > -1) {
      url = document.location.href.replace("edit", "calculation")
    }
    else if (document.location.href.indexOf("new") > -1) {
      url = document.location.href.replace("new", "calculation")
    }
    new Ajax.Updater('calculation', url, {
      method: "get",
      parameters: {quantity: $("order_quantity").value, discount: $("order_discount").value},
      onComplete: function() { new Effect.Highlight('calculation_small') }
    })
  }
}

document.observe("dom:loaded", function() {
  if ( $("order_photos_attributes_0_photo") ) {
    $("order_photos_attributes_0_photo").observe("change", function(e) {
      if ( $("order_photos_attributes_0_photo").value != "" ) $("page_photos").hide()
    })
  }
  
  if ( $("calculation") && $("order_quantity") && $("order_discount") ) {
    PricePreview.old_value["order_discount"] = $("order_discount").value
    PricePreview.old_value["order_quantity"] = $("order_quantity").value
    
    $("order_discount").observe("keyup", PricePreview.handleTyping)
    $("order_quantity").observe("keyup", PricePreview.handleTyping)
  }
    
})