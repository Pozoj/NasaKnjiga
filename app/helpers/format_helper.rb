module FormatHelper
  def field(resource, field)
    if resource.send("#{field}?") and value = resource.send(field)
      haml_tag :div, :class => "field" do
        haml_tag :div, resource.class.human_attribute_name(field), :class => "description"
        haml_tag :div, value, :class => "value"
      end
    end
  end
  
  def format_boolean(value)
    if value
      "DA"
    else
      "NE"
    end
  end
end