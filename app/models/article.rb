class Article < ActiveRecord::Base
  belongs_to :category
  attr_accessible :content, :dated, :headline, :photo
   has_attached_file :photo
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  
end
