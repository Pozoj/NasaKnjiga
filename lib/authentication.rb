module Authentication
  def self.included(base)
    base.helper_method :current_user, :current_user?, :admin?, :reviewer?, :designer?, :editor?, :can_edit?, :can_see?
  end
  
  def current_user
    @current_user ||= if session[:user]
      User.find session[:user]
    end
  end
  
  def current_user?
    !!current_user
  end

  def admin?
    current_user.admin? if current_user?
  end
  
  def reviewer?
    if current_user?
      admin? or current_user.reviewer?
    end
  end
  
  def editor?
    if current_user?
      admin? or current_user.editor?
    end
  end
  
  def designer?
    if current_user?
      admin? or current_user.designer? 
    end
  end
  
  def can_edit?(resource)
    if current_user?
      admin? or current_user.can_edit?(resource)    
    end
  end
  
  def can_see?(resource)
    if current_user?
      admin? or current_user.can_see?(resource)
    end
  end
  
  def editor_or_reviewer?
    (admin? or editor? or reviewer?)
  end
  
  def authenticate(type, flash_error)
    unless send("#{type}?")
      authentication_error flash_error
    end
  end
  
  def authenticate_user
    authenticate("current_user", "Prosimo prijavite se s svojim uporabniškim računom.")
  end
  def user_error
    authentication_error "Prosimo prijavite se s svojim uporabniškim računom."
  end
    
  def authenticate_admin
    authenticate("admin", "Prosimo prijavite se s svojim administratorskim računom.")
  end
  def admin_error
    authentication_error "Prosimo prijavite se s svojim administratorskim računom."
  end
  
  def authenticate_reviewer
    authenticate("reviewer", "Prosimo prijavite se s svojim lektorskim računom.")
  end
  def reviewer_error
    authentication_error "Prosimo prijavite se s svojim lektorskim računom."
  end
  
  def authenticate_editor
    authenticate("editor", "Prosimo prijavite se s svojim uredniškim računom.")
  end
  def editor_error
    authentication_error "Prosimo prijavite se s svojim uredniškim računom."
  end
  
  def authenticate_designer
    authenticate("designer", "Prosimo prijavite se s svojim oblikovalskim računom.")
  end
  def designer_error
    authentication_error "Prosimo prijavite se s svojim oblikovalskim računom."
  end
  
  def authenticate_editor_or_reviewer
    authenticate("editor_or_reviewer", "Prosimo prijavite se s svojim uredniškim ali lektorskim računom.")
  end
  def editor_or_reviewer_error
    authentication_error "Prosimo prijavite se s svojim uredniškim ali lektorskim računom."
  end
  
  def authorized_for_book(book)
    !!session["book_#{book.id}_authorization"]
  end
  
  def restrict_unpublished_books
    unless admin? or current_book.published? or (!current_book.published? and authorized_for_book(current_book)) or (!current_book.published? and can_see?(current_book))
      redirect_to authorize_book_path(current_book, :subdomain => false)
      session[:go_back] = request.url
    end
  end
  
  def authentication_error(flash_error)
    flash[:error] = flash_error
    session[:back_to] = request.url
    redirect_to new_session_path(:subdomain => false)
  end
end