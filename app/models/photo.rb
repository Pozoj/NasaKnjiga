class Photo < ActiveRecord::Base
  belongs_to :photographable, :polymorphic => true
  named_scope :orphaned, :conditions => "photographable_id IS NULL or photographable_type IS NULL"
  named_scope :older_than_5min, :conditions => ["created_at < ?", 5.minutes.ago]
  
  # validates_presence_of :photographable
  
  has_attached_file :photo, :styles => { :mini_square => "35x35#", :square => "75x75#", :small_square => "150x150#", :small => "150x150>", :book => "380x280#", :normal => "550x550>", :print => "1600x1200>" },
                    :url  => "/assets/photos/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/photos/:id/:style/:basename.:extension"

  validates_attachment_content_type :photo, :content_type => [/jpeg/, /jpg/], :message => "je lahko samo v formatu JPEG (JPG)."
  validates_attachment_size :photo, :in => 1..3.megabytes, :message => "je večja od dovoljenih 3 MB."
  
  def self.find_orphaned_by_type(type)
    all :conditions => ["photographable_type = ? and photographable_id IS NULL", type]
  end
  
  def self.cleanup_orphaned
    orphaned.each(&:destroy)
  end
  
  def short_name
    if photographable_type == 'Order' and photographable.street and photographable.book_title
      "#{photographable.id}#{photographable.street.debalkanize.downcase[0..0]}#{photographable.street_number}.jpg".downcase
    else
      "#{Digest::SHA1.hexdigest(photo.path)[0..7]}.jpg"
    end
  end
end