require "spec_helper"

describe BookKind do
  subject { Factory :book_kind }
  
  it { should be_valid}
  its(:errors) { should be_empty }
  
  it { should validate_presence_of(:name) }
  
  it { should have_many(:books) }
  it { should have_many(:page_kinds) }
  
end