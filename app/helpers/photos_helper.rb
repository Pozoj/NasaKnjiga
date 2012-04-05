module PhotosHelper
  def photo_picker(photo, options = {})
    if photo and photo.photo.file?
      options[:type] = photo.photographable_type.downcase unless options[:type]
      options[:id] = "#{options[:type]}_photo_id_#{photo.id}"
      options[:checked] = if params[type]
        params[type][:photo_id].to_i == photo.id
      elsif options[:chosen_id]
        options[:chosen_id] == photo.id
      else
        request.format == :js
      end

      render :partial => "photos/photo_pick", :locals => {:photo => photo}.merge(options)
    end
  end
end
