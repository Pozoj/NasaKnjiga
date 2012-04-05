require "spec_Helper"

describe Book do
  subject { Factory :book }
    
  it { should have_many(:sections) }
  it { should have_many(:prices) }
  
  it { should be_valid }
  its(:errors) { should be_empty }  
  it { should validate_presence_of(:kind_id) }
  it { should validate_presence_of(:title) }
  
  # Subdomain
  its(:subdomain) { should == "vinska-gora" }
  
  context "subdomain" do
    it "should be unique" do
      b1 = Factory :book
      b2 = Factory :book
      b3 = Factory :book
      b4 = Factory :book
      b5 = Factory :book
      b6 = Factory :book
  
      b1.subdomain.should_not == b2.subdomain
      b1.subdomain.should_not == b3.subdomain
      b1.subdomain.should_not == b4.subdomain
      b1.subdomain.should_not == b5.subdomain
      b1.subdomain.should_not == b6.subdomain
      b4.subdomain.should     == "vinska-gora-3"
    end
    
    it "should accept custom subdomain" do
      book = Factory :book, :subdomain => "lolol"
      book.subdomain.should == "lolol"
    end
  
    it "should allow only alphanumeric and dash chars as subdomain" do
      book = Factory.build :book, :subdomain => '(leet)hax'
      book.should have(1).error_on(:subdomain)
      
      book = Factory.build :book, :subdomain => 'leet-hax'
      book.should_not have(1).error_on(:subdomain)
  
      book = Factory.build :book, :subdomain => 'leet123hax'
      book.should_not have(1).error_on(:subdomain)
    end
  
    it "should not have dash as the first char" do
      book = Factory.build :book, :subdomain => '-leet-h2ax'
      book.should have(1).error_on(:subdomain)
    end
  
    it "should not have a dash as the last char" do
      book = Factory.build :book, :subdomain => 'l23eet-h2ax--'
      book.should have(1).error_on(:subdomain)
    end
  
    it "should be downcase" do
      book = Factory :book, :subdomain => "LEETh4x"
      book.subdomain.should eql('leeth4x')
    end
  
    it "should be longer than 3 characters" do
      book = Factory.build :book, :subdomain => "nu"
      book.should have(1).error_on(:subdomain)
    end
  
    it "should not be longer than 20 characters" do
      book = Factory.build :book, :subdomain => "n98d9a87daskajhdkajdhaksjdhasdasu"
      book.should have(1).error_on(:subdomain)
    end
  
    it "should not allow certain strings" do
      book = Factory.build :book, :subdomain => 'www'
      book.should have(1).error_on(:subdomain)
    end
  end

end