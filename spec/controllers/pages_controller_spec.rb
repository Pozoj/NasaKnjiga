require "spec_helper"

describe PagesController do
  it_should_require_admin_for_actions :destroy
end