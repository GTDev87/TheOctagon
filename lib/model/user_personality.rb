class UserPersonality
  include Mongoid::Document

  has_and_belongs_to_many :likes, class_name: "Like", inverse_of: nil
  accepts_nested_attributes_for :likes
  
  embedded_in :user, :inverse_of => :personality
end