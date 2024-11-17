class UserProfile {
  String username;
  String name;
  String profileImage;
  String about;
  String dogType;
  String breed;
  int age;
  double weight;
  int postsCount;
  int followersCount;
  int followingCount;

  // Constructor
  UserProfile({
    required this.username,
    required this.name,
    required this.profileImage,
    required this.about,
    required this.dogType,
    required this.breed,
    required this.age,
    required this.weight,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });

  // Factory method to create an instance from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      about: json['about'] ?? '',
      dogType: json['dog_type'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? 0,
      weight: double.parse((json['weight'] ?? 0).toString()),
      postsCount: json['posts_count'] ?? 0,
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'profile_image': profileImage,
      'about': about,
      'dog_type': dogType,
      'breed': breed,
      'age': age,
      'weight': weight,
      'posts_count': postsCount,
      'followers_count': followersCount,
      'following_count': followingCount,
    };
  }
}
