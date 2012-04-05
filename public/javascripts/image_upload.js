document.observe("dom:loaded", function() {
  $('image_upload_form').uploadProgress({
    start: function() { 
      $('image_upload_form').hide()
      $("new_image_link").hide()
      $("image_upload_progress").show()
      $("progress_bar_caption").update("Začenjam...")
    },
    complete: function() { $("progress_bar_caption").update("Obdelujem...") },
    success: function() 
    { 
      $("progress_bar_caption").update("Uspešno!")
      $('image_upload_progress').hide()
      $('new_image_link').show()
      $('image_upload_form').reset()
      eval(window.frames['progressFrame'].document.body.firstChild.firstChild.nodeValue)
    },
    error: function() { $("progress_bar_caption").update("Napaka!") }
  })
})

Event.addBehavior({
  "#new_image_link:click" : function() {
    $("image_upload_form").clonePosition(this, {
      setWidth: false,
      setHeight: false,
      offsetTop: 15
    })
    $("image_upload_form").show()
    return false
  },
  
  "#image_upload_form_close:click" : function() {
    $("image_upload_form").hide()
    return false
  },
})