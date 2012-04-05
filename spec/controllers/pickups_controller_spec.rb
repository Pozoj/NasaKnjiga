require "spec_helper"

describe PickupsController do
  it_should_require_admin_for_actions :index, :show, :new, :edit, :create, :update, :destroy
end