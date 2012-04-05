require "spec_helper"

describe PageKind do
  subject { Factory :page_kind }
  
  it { should be_valid}
  its(:errors) { should be_empty }
  
  it { should validate_presence_of(:name) }
  
  it { should belong_to(:book_kind) }
  it { should have_many(:pages) }
end