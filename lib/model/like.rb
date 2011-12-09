class Like
  include Mongoid::Document
  
  field :name
  validates_uniqueness_of :name
  validates_presence_of :name
  
  embeds_one :following, class_name: "LikeFollowing"
  accepts_nested_attributes_for :following
  validates_presence_of :following  
end