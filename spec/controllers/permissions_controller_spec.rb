require "spec_helper"

describe PermissionsController do
  before do
    @user = Factory :user, :kind => Factory(:user_kind, :kind => "reviewer")
  end
end