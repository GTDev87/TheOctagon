class RandomUserRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_recommendations(number_of_users)
    friends = []
    if @user.network != nil
      @user.network.contacts.each do |user|
        friends << user.username
      end
    end
    
    users = UserQuery.query_users_without_username(friends | [@user.username])
    return UserRecommendation.new(users.query_returner.return_n_random(number_of_users))
  end
  
  def name()
    return "Random User Recommendation Generator"
  end
end