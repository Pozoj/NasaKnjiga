require "spec_helper"

describe BooksController do
  it_should_require_admin_for_actions :show, :new, :edit, :create, :update, :destroy
  it_should_not_require_login_for_actions :index
end