require "spec_helper"

describe Post do
  subject { Factory :post }
  
  it { should be_valid }
  its(:errors) { should be_empty }
  
  it { should validate_presence_of(:name) }
end