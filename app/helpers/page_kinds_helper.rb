module PageKindsHelper
  def format_page_fields(kind, fields)
    if fields
      fields.keys.map { |field| kind.field_name(field) }.join(", ")
    end
  end
end
