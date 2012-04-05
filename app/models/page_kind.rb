class PageKind < ActiveRecord::Base
  has_many :pages, :foreign_key => "kind_id"
  belongs_to :book_kind
  has_one :translation, :dependent => :destroy
  accepts_nested_attributes_for :translation
  attr_accessible :translation_attributes, :name, :page_fields
  serialize :page_fields
  before_validation_on_create :initialize_translation
  
  validates_presence_of :name
  
  def field_name(attribute)
    if translation and translation.respond_to?(attribute) and translation.send(attribute) and not translation.send(attribute).blank?
      translation.send(attribute)
    else
      Page.human_attribute_name(attribute)
    end
  end
  
  def initialize_translation
    translation.page_kind = self if translation
  end
  
  def to_s
    name
  end
end