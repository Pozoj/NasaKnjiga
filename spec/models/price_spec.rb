require "spec_helper"

describe Price do
  subject { Factory :price }
  
  it { should be_valid }
  its(:errors) { should be_empty }
  
  it { should validate_presence_of(:price_without_tax) }
  it { should_not validate_presence_of(:quantity) }
  it { should validate_presence_of(:book) }
  
  it { should belong_to(:book) }

end