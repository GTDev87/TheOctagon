require 'spec_helper'

describe UserQuery do
  before(:each) do
    @greg = Factory(:user, username: "GregT")
    @zac = Factory(:user, username: "ZacC")
    @amol = Factory(:user, username: "AmolK")
  end
  
  describe "finding users" do
    it "should find users with the name mentioned by id" do      
      UserQuery.find(@zac.id).username.should == "ZacC"
      UserQuery.find(@amol.id).username.should == "AmolK"
      UserQuery.find(@greg.id).username.should == "GregT"
    end
  end
  
  describe "finding all users" do
    it "should return all users when all is called" do
      users = UserQuery.all

      users.entries.should =~ [@zac, @amol, @greg]
    end
    
    it "should return all users without specified usernames" do
      users_query = UserQuery.query_users_without_username(["ZacC"])

      users_query.query_returner.return_all.entries.should =~ [@greg, @amol] 
    end    
  end
  
  describe "finding users by username" do
    it "should should return user object" do
      UserQuery.find_user_by_username("GregT").should == @greg
      UserQuery.find_user_by_username("AmolK").should == @amol
      UserQuery.find_user_by_username("ZacC").should == @zac 
    end
  end  
end