function decrease_and_publish() {
  cur = parseInt($("seconds").innerHTML)
  if ( cur > 0 )
  {    
    $("seconds").innerHTML = parseInt($("seconds").innerHTML)-1
    setTimeout(decrease_and_publish, 1000)
  }
  else
  {
    $("timer").hide()
    $("success").show()
  }
}
document.observe("dom:loaded", function() {
  $("success").hide()
  setTimeout(decrease_and_publish, 1000)
})
