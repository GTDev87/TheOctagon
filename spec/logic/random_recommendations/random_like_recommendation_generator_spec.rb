require 'spec_helper'

describe RandomLikeRecommendationGenerator do
  before(:each) do
    @user = Factory.build(:user)
    @recommendation_generator = RandomLikeRecommendationGenerator.new(@user)
  end
  
  def connect_likes(user,like)
    user.personality.likes << like
    like.following.users << user
    like.save
    like.reload
    user.save
    user.reload
  end

  describe "Recommending likes" do
    it "should return likes equal to the number of likes requested" do
      7.times do
        Factory(:like)
      end
      @recommendation_generator.generate_recommendations(5).like_list.size.should == 5
    end
    
    it "should return likes not owned by user" do
      unowned_likes = {}
      owned_likes = {}
      
      unowned_likes[Factory(:like).name] = true
      connect_likes(@user,Factory(:like))
      unowned_likes[Factory(:like).name] = true
      connect_likes(@user,Factory(:like))
      unowned_likes[Factory(:like).name] = true
      connect_likes(@user,Factory(:like))
      unowned_likes[Factory(:like).name] = true
      connect_likes(@user,Factory(:like))
      
      @user.reload
      
      @user.personality.likes.each do |like|
        owned_likes[like.name] = true
      end
      
      like_list = @recommendation_generator.generate_recommendations(4).like_list
      
      
      like_list.each do |like|
        owned_likes.should_not have_key(like.name)
        unowned_likes.should have_key(like.name)
      end
    end
  end
end