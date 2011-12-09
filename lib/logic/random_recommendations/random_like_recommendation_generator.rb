class RandomLikeRecommendationGenerator
  def initialize(user)
    @user = user
  end
  
  def generate_recommendations(number_of_interests)
    username_list = []
    @user.personality.likes.each do |like|
      username_list << like.name
    end
    other_likes = LikeQuery.query_likes_without_names(username_list)
    return LikeRecommendation.new(other_likes.query_returner.return_n_random(number_of_interests))
  end
end