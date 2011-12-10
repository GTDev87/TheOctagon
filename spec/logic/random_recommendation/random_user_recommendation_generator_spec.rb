require 'spec_helper'

describe RandomUserRecommendationGenerator do
  before(:each) do    
    @user = Factory(:user)
    @recommendation_generator = RandomUserRecommendationGenerator.new(@user)
  end

  describe "Recommending users" do
    it "should return likes equal to the number of likes requested" do
      7.times do
        Factory(:user)
      end
      @recommendation_generator.generate_recommendations(5).user_list.size.should == 5
    end
    
    it "should return fewer users if there are not available" do
      2.times do
        Factory(:user)
      end
      @recommendation_generator.generate_recommendations(100).user_list.size.should == 2
    end
    
    it "should not recomend self" do
      other_users = {}
      
      other_users[Factory(:user).username] = true
      other_users[Factory(:user).username] = true
      other_users[Factory(:user).username] = true
      
      recommendations = @recommendation_generator.generate_recommendations(4).user_list
      recommendations.each do |user|
        other_users.should have_key(user.username)
        user.username.should_not be(@user.username)
      end
    end
    
    it "should not recomend contacts" do
      @amol = Factory(:user)
      @zac = Factory(:user)
      @reid = Factory(:user)
      @deepak = Factory(:user)
      
      other_users = {}
      @user.network.contacts << @amol
      @user.network.contacts << @zac
      
      @user.reload
      
      recommendations = @recommendation_generator.generate_recommendations(4).user_list
      recommendations.should =~ [@deepak, @reid]
    end
  end
  
  describe "name" do
    it "should return its name" do
      @recommendation_generator.name.should == "Random User Recommendation Generator"
    end
  end
end