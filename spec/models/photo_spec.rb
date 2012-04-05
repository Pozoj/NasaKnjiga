require "spec_helper"

describe Photo do
  subject { Factory :photo }
  
  it { should belong_to(:photographable) }
  it { should respond_to(:photo) }
  
  it "should have DB fields defined" do
    should have_db_column("photo_file_name").of_type(:string)
    should have_db_column("photo_content_type").of_type(:string)
    should have_db_column("photo_file_size").of_type(:integer)
  end
  
  its(:photo) { should be_an_instance_of(Paperclip::Attachment) }
end