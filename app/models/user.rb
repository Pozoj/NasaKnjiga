class User < ActiveRecord::Base
  has_many :owned_pages, :foreign_key => "owner_id", :class_name => "Page"
  has_many :reviewed_pages, :class_name => "Page", :foreign_key => "reviewer_id"
  belongs_to :kind, :class_name => "UserKind"
  has_many :permissions
  
  has_many :books, :through => :permissions
  has_many :pages, :through => :permissions
  
  validates_presence_of :name, :surname, :email, :password_hash
  validates_presence_of :password, :on => :create
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_nil => true, :allow_blank => true
  
  def password
    @password
  end
  
  def password=(_password)
    @password = _password
    self.password_hash = @password.sha2 if @password
  end
  
  def self.authenticate(email, password)
    if email and password
      find_by_email_and_password_hash email, password.sha2
    end
  end
  
  def admin?
    (kind and kind.kind == "admin")
  end

  def reviewer?
    (kind and kind.kind == "reviewer")
  end

  def editor?
    (kind and kind.kind == "editor")
  end
  
  def designer?
    (kind and kind.kind == "designer")
  end
  
  def book_permissions
    @book_permissions ||= permissions.map(&:book_id).reject { |id| id.blank? or id.nil? }
  end
  
  def page_permissions
    @page_permissions ||= permissions.map(&:page_id).reject { |id| id.blank? or id.nil? }
  end
  
  def can_resource?(action, resource, id = nil)  
    # If we have an admin on our hands, let him through immediately.
    return true if admin?
    
    # No passaran.
    return false unless resource
    
    # If the resource is a string, use it as is, otherwise fetch the ID from the object.
    unless resource.instance_of? String
      id = resource.id
      resource_class = resource.class.to_s.downcase
    end
    resource_permissions = "#{resource_class}_permissions"

    # Exit if not permissions for object exist.
    return unless respond_to?(resource_permissions)
    
    # Can haz permission?
    can = send(resource_permissions).include?(id)
    # If the resource is a page, we need to check if we have permissions for the whole book
    # in which case we have permissions for the page also.
    can_page = if resource_class == "page" and id
      book_permissions.include? resource.book.id
    end
    
    if reviewer? or editor?
      can or can_page
    elsif designer? and action == :see
      can or can_page
    end
  end
  
  def can_edit?(resource, id = nil)
    can_resource? :edit, resource, id
  end
  
  def can_see?(resource, id = nil)
    can_resource? :see, resource, id
  end
  
  def full_name
    "#{name} #{surname}"
  end
  
  def to_s
    full_name
  end

end
