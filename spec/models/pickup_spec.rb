require "spec_helper"

describe Pickup do
  subject { Factory :pickup }
  
  it { should be_valid }
  it { should have_many(:orders) }
  
  its(:errors) { should be_empty }
  it { should validate_presence_of(:name) }
end