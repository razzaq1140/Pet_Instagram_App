class PostModel {
  final int id;
  final int userId;
  final List<String> mediaPaths;
  final String caption;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool likedByUser;
  final bool savedByUser;
  final int commentsCount;
  final UserModel user;
  final List<LikeModel> likes;
  final List<CommentModel> comments;

  PostModel({
    required this.id,
    required this.userId,
    required this.mediaPaths,
    required this.caption,
    required this.createdAt,
    required this.updatedAt,
    required this.likedByUser,
    required this.savedByUser,
    required this.commentsCount,
    required this.user,
    required this.likes,
    required this.comments,
  });

  // From JSON
  factory PostModel.fromJson(Map<String, dynamic> json) {
    List<String> mediaPathsList = List<String>.from(json['media_paths'] ?? []);
    if (mediaPathsList.isNotEmpty) {
      mediaPathsList = mediaPathsList.map((path) {
        if (path.contains('public')) {
          return path; // URL is already complete in JSON
        } else {
          final updatedPath = path.replaceAll('uploads', 'public/uploads');
          return updatedPath;
        }
      }).toList();
    }

    return PostModel(
      id: json['id'],
      userId: json['user_id'],
      mediaPaths: mediaPathsList,
      caption: json['caption'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      likedByUser: json['liked_by_user'] ?? false,
      savedByUser: json['saved_by_user'] ?? false,
      commentsCount: json['comments_count'] ?? 0,
      user: UserModel.fromJson(json['user']),
      likes: (json['likes'] as List).map((e) => LikeModel.fromJson(e)).toList(),
      comments: (json['comments'] as List)
          .map((e) => CommentModel.fromJson(e))
          .toList(),
    );
  }
}

// User Model
class UserModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt; // Nullable field
  final String? contactNumber; // Nullable field
  final String username;
  final String about;
  final String dogType;
  final String breed;
  final int age;
  final bool isActive;
  final double weight;
  final String profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.contactNumber,
    required this.username,
    required this.about,
    required this.dogType,
    required this.breed,
    required this.age,
    required this.isActive,
    required this.weight,
    required this.profileImage,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    String profileImage = json['profile_image'] ?? '';
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '', // Default empty string if null
      emailVerifiedAt: json['email_verified_at'], // Nullable field
      contactNumber: json['contact_number'], // Nullable field
      username: json['username'] ?? '',
      about: json['about'] ?? '',
      dogType: json['dog_type'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? 0, // Default to 0 if missing
      isActive: json['is_active'] == 1, // Assuming 1 is true, 0 is false
      weight: json['weight']?.toDouble() ?? 0.0, // Default to 0.0 if null
      profileImage:
          "https://pet-insta.nextwys.com/public/uploads/$profileImage",
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'contact_number': contactNumber,
      'username': username,
      'about': about,
      'dog_type': dogType,
      'breed': breed,
      'age': age,
      'is_active': isActive ? 1 : 0, // Convert to 1/0 for boolean
      'weight': weight,
      'profile_image': profileImage,
    };
  }
}

// Like Model
class LikeModel {
  final int id;
  final int userId;
  final int postId;
  final DateTime createdAt;
  final DateTime updatedAt;

  LikeModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      userId: json['user_id'],
      postId: json['post_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'post_id': postId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Comment Model
class CommentModel {
  final int id;
  final String content;
  final DateTime createdAt;
  final UserModel user;

  CommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
  });

  // From JSON
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'] ?? '', // Default empty string if null
      createdAt: DateTime.parse(json['created_at']),
      user: UserModel.fromJson(json['user']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}
