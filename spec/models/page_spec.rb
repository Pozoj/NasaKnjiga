require "spec_helper"

describe Page do
  subject { Factory :page, :body => "Simon Talek se je vrnil\nIz Afrike cel vesel in prepoten *da bi koncno videl mati*" }
  
  it { should be_valid }
  its(:errors) { should be_empty }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:title) }
  it { should belong_to(:kind) }
  it { should belong_to(:section) }
  it { should have_many(:orders) }
  
  # Permalink check
  its(:permalink) { should == "simon-talek" }
  
  # Textile check
  its(:body_html) { should == "<p>Simon Talek se je vrnil<br />\nIz Afrike cel vesel in prepoten <strong>da bi koncno videl mati</strong></p>" }
  
  # Email check 
  it { should_not allow_value("asdas").for(:email) }
  it { should_not allow_value("asdas@").for(:email) }
  it { should_not allow_value("peter.klepec").for(:email) }
  it { should allow_value("rasmajx@gmail.com").for(:email) }
  it { should allow_value("peter.rebernik@gmail.com").for(:email) }
  
  # Website check
  it { should_not allow_value("asdas").for(:website) }
  it { should_not allow_value("simon+loli.com").for(:website) }
  it { should_not allow_value("asdsd?/as").for(:website) }
  it { should allow_value("asdas.com").for(:website) }
  it { should allow_value("www.google.com").for(:website) }
  it { should allow_value("http://simontalek.com").for(:website) }
  it { should allow_value("http://www.vinskagora.si").for(:website) }
end