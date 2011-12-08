require 'spec_helper'

describe User do 
  it "should create a new instance given a valid attribute" do
    Factory(:user)
  end
  
  it "should be valid when proper arguments are passed" do
    user = Factory.build(:user)
    user.should be_valid
  end
end