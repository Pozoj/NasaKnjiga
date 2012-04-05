require "spec_helper"

describe Section do
  subject { Factory :section }
  
  it { should be_valid }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:book) }
  it { should belong_to(:book) }
  it { should have_many(:pages) }
  
  # Permalink check
  its(:permalink) { should == "zaselek-1" }  
end