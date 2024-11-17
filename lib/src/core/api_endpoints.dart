class ApiEndpoints {
  static const String baseUrl = 'https://pet-insta.nextwys.com/api';

  static const String baseImageUrl =
      'https://pet-insta.nextwys.com/public/uploads/';

  /// ############################# [Auth] #############################
  static const String sendOtp = '$baseUrl/send-otp';
  static const String verifyOtp = '$baseUrl/verify-otp';
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String forgotPassword = '$baseUrl/password/forgot';
  static const String passwordReset = '$baseUrl/password/reset';

  /// ############################# [Profile] #############################
  static const String setUserName = '$baseUrl/user/username';
  static const String setUserProfileImage = '$baseUrl/user/profile/image';
  static const String setUserAbout = '$baseUrl/user/about';
  static const String updateUserAbout = '$baseUrl/profile/update';
  static const String getUserProfile = '$baseUrl/user/profile';
  static const String getAllUsers = '$baseUrl/users/feed?search=';

  /// ############################# [Profile Settings] #############################
  /// ############################# [Home] #############################
  /// ############################# [Posts] #############################
  static const String getPostFeed = '$baseUrl/feed';
  static const String getAPost = '$baseUrl/posts/';
  static const String submitAPost = '$baseUrl/posts';

  /// ############################# [Stories] #############################
  static const String getOwnStories = '$baseUrl/stories/own';
  static const String getOtherStories = '$baseUrl/stories';
  static const String postStory = '$baseUrl/stories/user/';

  /// ############################# [Sub-Part-of-Endpoint] #############################
  static const String toggleLike = '/toggle-like';
  static const String toggleSave = '/toggle-save';

  /// ############################# [ Recipe ] #############################

  static const String uploadRecipe = '$baseUrl/recipes/post';
  static const String getRecipe = '$baseUrl/recipes/feed';
  static const String commentRecipe = '$baseUrl/recipes/81/comment';
  static const String likeRecipe = '$baseUrl/recipes/81/toggle-like';
  static const String saveRecipe = '$baseUrl/recipes/81/toggle-save';
  static const String likeRecipeComment = '$baseUrl/recipe-comments/1/like';
  static const String replyRecipeComment = '$baseUrl/recipe-comments/1/reply';
}
