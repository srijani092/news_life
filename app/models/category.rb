class Category < ActiveRecord::Base
  attr_accessible :description, :title, :icon
  validates :title, :presence => true
  has_many :articles
end
