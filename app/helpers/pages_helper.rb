module PagesHelper
  def field_wanted(field, type, page, builder)
    if page.field_wanted?(field)
      content = ""
      content += content_tag :div, builder.label(field, page.field(field)), :class => "question"
      content += content_tag :div, builder.send(type, field), :class => "answer"
      content
    end
  end
  
  def ordered_link(caption, field)
    order = klass = ""
    if field 
      order = field
      if params[:order]
        if params[:order] == field
          order += "_"
          klass = "ascending"
        elsif params[:order] == "#{field}_"
          klass = "descending"
        end
      end
    end
    
    link_to caption, {:order => order}, :class => klass
  end
  
  def inside_style
    {}
  end
end
