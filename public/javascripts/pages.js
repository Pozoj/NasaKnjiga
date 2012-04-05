document.observe("dom:loaded", function() {
  $("page_kind_id").observe("change", function(e) {
    url = window.location.href
    if (url.indexOf("?") > 0)
      url = url.replace(url.substr(url.indexOf("?")), "?kind_id=" + $("page_kind_id").value)
    else
      url += "?kind_id=" + $("page_kind_id").value
      
    window.location.href = url
  })
})
