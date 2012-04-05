module AuthHelper
  def user_section(kind = "current_user", klass = nil, &block)
    classes = ["user", kind]
    classes += klass if klass
    if send("#{kind}?")
      concat content_tag(:div, capture(&block), :class => classes.join(" "))    
    end
  end
  
  def admin_section(klass = nil, &block)
    user_section("admin", nil, &block)
  end
  
  def reviewer_section(klass=nil, &block)
    user_section("reviewer", nil, &block)
  end

  def editor_section(resource = nil, &block)
    if resource 
      user_section("editor", nil, &block) if can_edit?(resource)
    else
      user_section("editor", nil, &block)
    end
  end

  def designer_section(klass=nil, &block)
    user_section("designer", nil, &block)
  end
  
end