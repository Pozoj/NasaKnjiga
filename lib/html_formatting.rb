module HtmlFormatting
  protected
  
  def format_attributes
    self.class.formatted_attributes.each do |attr|
      raw    = read_attribute attr
      # linked = auto_link(raw) { |text| truncate(text, 50) }
      textilized = RedCloth.new(raw, [:hard_breaks])
      textilized.hard_breaks = true if textilized.respond_to?("hard_breaks=")
      write_attribute "#{attr}_html", textilized.to_html
    end
  end
end