function transitionOpacity(hide, show, _duration)
{
  new Effect.Fade($(hide), {duration: _duration, afterFinish: function() {
    new Effect.Appear($(show), {duration: _duration})
  }})
}

Ajax.Responders.register({
  onCreate: function(){ Element.show('spinner')},
  onComplete: function(){Element.hide('spinner')}
});

Event.addBehavior({
  "#authentication .log_in:click" : function() {
    $("authentication").toggleClassName("active")
    $("user_email").focus()
    return false
  },
  
  "#menu a.search:click" : function() {
    $(this).up().toggleClassName("active")
    $("q").focus()
    return false
  }
})