require "spec_helper"

describe User do
  subject { Factory :user, :password => "loolapallooza" }
  
  it { should be_valid }
  its(:errors) { should be_empty }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_hash) }
  
  # Email check
  it { should_not allow_value("asdas").for(:email) }
  it { should_not allow_value("asdas@").for(:email) }
  it { should_not allow_value("peter.klepec").for(:email) }
  it { should allow_value("rasmajx@gmail.com").for(:email) }
  it { should allow_value("peter.rebernik@gmail.com").for(:email) }
  
  # Password hashing
  its(:password_hash) { should == "1ddcbca2e8c99019ccfd5d565de1443fcf36e2098a0e40de9a5fa5eedd7efff9" }
  
  
  it "should let us login" do
    user = Factory :user, :email => "peter@pozoj.si", :password => "rpeb"
    login = User.authenticate("peter@pozoj.si", "rpeb")
    login.should eql(user)
  end
  
  it "should fail on blank credentials" do
    login = User.authenticate(nil, nil)
    login.should eql(nil)
  end
  
  context "roles" do
    context "reviewer" do
      before do
        @book_allowed = Factory :book
        section = Factory :section, :book => @book_allowed
        @page_allowed = Factory :page, :section => section
        
        @book_not_allowed = Factory :book
        section = Factory :section, :book => @book_not_allowed
        @page_not_allowed = Factory :page, :section => section
        
        @user = Factory :user, :kind => Factory(:user_kind, :kind => "reviewer")
        @user.permissions << Permission.new(:book => @book_allowed)
      end
      
      it "should be allowed to edit permitted books" do
        @user.should be_can_edit(@book_allowed)
      end
      it "should not be allowed to edit non permitted books" do
        @user.should_not be_can_edit(@book_not_allowed)
      end
      it "should be allowed to see permitted books" do
        @user.should be_can_see(@book_allowed)
      end
      
      it "should be allowed to edit pages under permitted books" do
        @user.should be_can_edit(@page_allowed)
      end
      it "should not be allowed to edit pages under not permitted books" do
        @user.should_not be_can_edit(@page_not_allowed)
      end
    end
    
    context "editor" do
      before do
        @book_allowed = Factory :book
        @book_not_allowed = Factory :book
        @user = Factory :user, :kind => Factory(:user_kind, :kind => "editor")
        @user.permissions << Permission.new(:book => @book_allowed)
      end
      
      it "should be allowed to edit permitted books" do
        @user.should be_can_edit(@book_allowed)
      end
      it "should not be allowed to edit non permitted books" do
        @user.should_not be_can_edit(@book_not_allowed)
      end
      it "should be allowed to see permitted books" do
        @user.should be_can_see(@book_allowed)
      end
    end
    
    context "designer" do
      before do
        @book_allowed = Factory :book
        @book_not_allowed = Factory :book
        @user = Factory :user, :kind => Factory(:user_kind, :kind => "designer")
        @user.permissions << Permission.new(:book => @book_allowed)
      end
      
      it "should not be allowed to edit any books" do
        @user.should_not be_can_edit(@book_allowed)
        @user.should_not be_can_edit(@book_not_allowed)
      end
      it "should be allowed to see permitted books" do
        @user.should be_can_see(@book_allowed)
      end
    end
    
    context "admin" do
      before do
        @book_allowed = Factory :book
        @book_not_allowed = Factory :book
        @user = Factory :user, :kind => Factory(:user_kind, :kind => "admin")
        @user.permissions << Permission.new(:book => @book_allowed)
      end
      
      it "should be allowed to edit any book" do
        @user.should be_can_edit(@book_allowed)
        @user.should be_can_edit(@book_not_allowed)
        @user.should be_can_see(@book_allowed)
        @user.should be_can_see(@book_not_allowed)
      end
    end
  end
end