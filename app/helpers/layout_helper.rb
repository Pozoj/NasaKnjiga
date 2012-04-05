module LayoutHelper
  def javascripts(*args)
    content_for(:head) do
     javascript_include_tag(*args)
    end
  end

  def menu_item(text, path)
    klass = (path == request.request_uri) ? "active" : ""
    content_tag :li, link_to(text, path), :class => klass
  end
  
  def title(_title, heading = true)
    default = "Naša knjiga"
    title = (_title) ? "#{_title} (#{default})" : default
    content_for(:title) { title }
    
    unless not heading
      return content_tag(:a, "", :name => "top") + content_tag(:h1, _title)
    end
  end
end