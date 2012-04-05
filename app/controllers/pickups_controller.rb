class PickupsController < InheritedResources::Base
  before_filter :authenticate_admin
  
  def create
    create! { collection_path }
  end
  def update
    update! { collection_path }
  end
end
