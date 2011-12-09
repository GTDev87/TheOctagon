class User
  include Mongoid::Document
  
  field :username
  validates_uniqueness_of :username
  validates_presence_of :username
  
  embeds_one :personality, class_name: "UserPersonality"
  validates_presence_of :personality
  accepts_nested_attributes_for :personality
  
  embeds_one :network, class_name: "UserNetwork"
  accepts_nested_attributes_for :network
end

