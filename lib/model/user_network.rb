class UserNetwork
  include Mongoid::Document

  has_and_belongs_to_many :contacts, class_name: "User", validate: true, autosave: true, inverse_of: nil
  embedded_in :user, :inverse_of => :network
  accepts_nested_attributes_for :contacts
  
end