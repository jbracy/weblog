class Blog < ActiveRecord::Base
  belongs_to :user, :inverse_of => :blogs
  
  validates :title, :presence => true, :uniqueness => true
  validates :content, :presence => true
  validates_presence_of :user
  attr_accessible :title, :content
end
