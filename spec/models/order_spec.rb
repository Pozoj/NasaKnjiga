require "spec_helper"

describe Order do
  it "should be valid" do
    o = Factory.build :order
    puts o.errors.inspect
  end
  # subject { Factory :order }
  # 
  # it { should be_valid }
  # its(:errors) { should be_empty }
  # 
  # it { should belong_to(:page) }
  # it { should belong_to(:photo) }
  # it { should have_many(:photos) }
  # 
  # it { should validate_presence_of(:name) }
  # it { should validate_presence_of(:page) }
  # it { should validate_presence_of(:photo) }
  # it { should validate_presence_of(:surname) }
  # it { should validate_presence_of(:street) }
  # it { should validate_presence_of(:street_number) }
  # it { should validate_presence_of(:quantity) }
  # it { should validate_numericality_of(:quantity) }
  # it { should validate_numericality_of(:street_number) }
  # 
  # it "should have VAT ID when company name is entered" do
  #   order = Factory.build :order, :vat_id => nil
  #   order.should have(1).error_on(:vat_id)
  # end
  # 
  # it "should not require VAT ID or company when both not entered" do
  #   order = Factory.build :order, :company => nil, :vat_id => nil
  #   order.should_not have(1).error_on(:vat_id)
  #   order.should_not have(1).error_on(:company)
  # end
  # 
  # it "should require company when VAT ID is entered" do
  #   order = Factory.build :order, :company => nil
  #   order.should have(1).error_on(:company)
  # end
  # 
  # it { should belong_to(:page) }
  # it { should belong_to(:post) }
  # it { should belong_to(:pickup) }
  # 
  # context "price" do
  #   before do
  #     @book = Factory :book
  #     @section = Factory :section, :book => @book
  #     @page = Factory :page, :section => @section
  #     
  #     # Setup prices
  #     @book.prices << Factory(:price, :quantity => 1, :price_without_tax => 58.00, :book => @book)
  #     @book.prices << Factory(:price, :quantity => 2, :price_without_tax => 52.00, :book => @book)
  #     @book.prices << Factory(:price, :quantity => 3, :price_without_tax => 48.00, :book => @book)
  #     @book.prices << Factory(:price, :quantity => 4, :price_without_tax => 44.00, :book => @book)
  #     @book.prices << Factory(:price, :quantity => nil, :price_without_tax => 40.00, :book => @book) # Default price
  #   end
  #   
  #   context "for 1 book" do
  #     subject { Factory :order, :page => @page, :quantity => 1 }
  #     its(:total) { should == BigDecimal.new("62.93") }
  #     its(:tax) { should == BigDecimal.new("4.93") }
  #   end
  #     
  #   context "for 2 books" do
  #     subject { Factory :order, :page => @page, :quantity => 2 }
  #     its(:total) { should == BigDecimal.new("112.84") }
  #     its(:tax) { should == BigDecimal.new("8.84") }
  #   end
  # 
  #   context "for 12 books" do
  #     subject { Factory :order, :page => @page, :quantity => 12 }
  #     its(:total) { should == BigDecimal.new("520.8") }
  #     its(:tax) { should == BigDecimal.new("40.8") }
  #   end
  #   
  #   context "for 12 books but no price" do
  #     before { @page = Factory :page }
  #     subject { Factory :order, :page => @page, :quantity => 12 }
  #     its(:total) { should == BigDecimal.new("0.0") }
  #     its(:tax) { should == BigDecimal.new("0.0") }
  #   end
  #   
  #   context "for 5 books with 50% discount" do
  #     subject { Factory :order, :page => @page, :quantity => 5, :discount => 50 }
  #     its(:total) { should == BigDecimal.new("108.5") }
  #     its(:tax) { should == BigDecimal.new("8.5") }
  #   end
  #   
  #   context "for 5 books with 100% discount should be zero" do
  #     subject { Factory :order, :page => @page, :quantity => 5, :discount => 100 }
  #     its(:total) { should == BigDecimal.new("0.0") }
  #     its(:tax) { should == BigDecimal.new("0.0") }
  #   end
  # end
end