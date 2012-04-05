module LinkHelper
  def link_to_lightbox(string, image, album = 'album', title = '')
    ret = "<a href='#{image}' rel='lightbox[#{album}]'"
    ret += " title='#{title}'" unless title.blank?
    ret += "class='lightbox'>#{string}</a>"
  end

  # WillPaginate localization hax
  include WillPaginate::ViewHelpers 

  def will_paginate_with_i18n(collection, options = {})
    will_paginate_without_i18n(collection, options.merge(:previous_label => I18n.t(:previous), :next_label => I18n.t(:next))) 
  end 

  alias_method_chain :will_paginate, :i18n

  def destroy_confirmation(obj)
    if obj.respond_to? :title
     str = obj.title
    elsif obj.respond_to? :name
     str = obj.name
    else
     str = obj.id
    end

    "'#{str}' - Ste prepričani o izbrisu?"
  end

  def link_to_back(custom_path=nil)
    unless path = custom_path
      unless path = collection_path
        raise ArgumentError
      end
    end
    link_to("&larr; Nazaj", path, :class => 'to_back')
  end
  
  def link_to_self(url)
    link_to url, url    
  end

  def link_to_email(email)
    link_to email, "mailto:#{email}"
  end
  
  def link_to_collection(text="Nazaj")
    link_to text, collection_path
  end
  
  def link_to_anchor(caption, anchor, save_params=[], options={})
    save_params = [save_params] unless is_a?(save_params.class)
    save_params = save_params.inject({}) do |hash, param|
      hash.merge({param => params[param]}) if param and params[param]
    end
    link_to caption, {:anchor => anchor}.merge(save_params || {}), options
  end
  
  def link_to_top(save_params=[])
    link_to_anchor "↑ Na vrh", "top", save_params, :class => "to_top"
  end  
  
  def link_to_local(caption, anchor, save_params=[])
    link_to_anchor "#{caption} ↓", anchor, save_params
  end
end