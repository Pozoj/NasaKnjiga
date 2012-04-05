var BookPreview = {
  timeout: 0,
  input: null,
  old_value: "",
  
  handleTyping: function(callback) {
    if ( BookPreview.old_value != BookPreview.input.value )
    {
      BookPreview.old_value = BookPreview.input.value;
      if (BookPreview.input.value != "")
      {
        if ( BookPreview.timeout ) {
          clearTimeout(BookPreview.timeout)
          BookPreview.timeout = null
        }
        BookPreview.timeout = setTimeout(callback, 100)
      }
    }
  },
  
  handleTitle: function(input) {
    BookPreview.input = input
    BookPreview.handleTyping(BookPreview.changeTitle)
  },

  handleBody: function(input) {
    BookPreview.input = input
    BookPreview.handleTyping(BookPreview.changeBody)
  },
  
  changeTitle: function() {
    $$(".display_title").each(function(title) {
      title.innerHTML = BookPreview.input.value
    })
  },
  
  changeBody: function() {
    $("display_body").innerHTML = BookPreview.input.value
  },
  
  handlePhotoChange: function(radio) {
    BookPreview.input = radio
    url = BookPreview.input.up().select(".book_sized_url").first().innerHTML
    
    $$(".visual").each(function(image_container) {
      if ( image_container.down("img") ) {
        var image = image_container.down()
      }
      else {
        var image = document.createElement("img")
        image_container.appendChild(image)
      }

      if ( image.src.indexOf(url) < 0 )
      {    
        new Effect.Opacity(image, {from: 1.0, to: 0.0, duration: 0.25, afterFinish: function() {
          $("spinner").show()
          image.src = url
          $(image).observe("load", function() { 
            $("spinner").hide()
            new Effect.Opacity(image, {from: 0.0, to: 1.0, duration: 0.25})
          })
        }})
      }
    })
  }
}

Event.addBehavior({
  ".photo_list input[type='radio']:change" : function() {
    BookPreview.handlePhotoChange(this)
  },
  
  ".photo img:mouseover" : function() {
    BookPreview.handlePhotoChange(this)
  },
  
  "#page_title:keyup" : function() {
    BookPreview.handleTitle(this)
  },
  
  "#page_body:keyup" : function() {
    BookPreview.handleBody(this)
  },
  
  "#order_book_title:keyup" : function() {
    BookPreview.handleTitle(this)
  },
  
  "#preview_switcher a:click" : function() {
    $("preview_switcher").down(".inside").toggleClassName("active")
    if ( this.up().hasClassName("cover") ) {
      $("preview_switcher").down(".cover").addClassName("active")
      $("preview_switcher").down(".inside").removeClassName("active")
      transitionOpacity("inside", "cover", 0.25)  
    }
    else {
      $("preview_switcher").down(".cover").removeClassName("active")
      $("preview_switcher").down(".inside").addClassName("active")
      transitionOpacity("cover", "inside", 0.25)
    }
    
    return false
  }
})

function handleScroll() {
  // Get the offset of preview container.
  var offset = $("preview").viewportOffset()
  // Get viewport dimensions.
  var vd = document.viewport.getDimensions()
  // Get content dimensions.
  var cd = $("content").getDimensions()
  // Some math to calculate the exact absolute pixels from the left.
  var apply_offset = Math.round((vd.width-1000)/2) + offset[0]
  
  Event.observe(window, "scroll", function() {
    e = $("preview")
  	s = document.documentElement.scrollTop;
  	x = self.pageYOffset; 
	
  	if (cd.height - vd.height > 300) 
  	{
    	if (s > 380 || x > 380)
    	{
    		e.style.position = 'fixed'; 
    		e.style.top = '0px';
    		e.style.left = apply_offset + "px";
    	}
    	else
    	{
    		e.style.position = 'relative'; 
    		e.style.top = '0px';
    		e.style.left = '0px';
    	}
  	}
  })
}

document.observe("dom:loaded", function() {
  $("inside").hide()
  $("preview_switcher").down(".cover").toggleClassName("active")
  handleScroll();
})