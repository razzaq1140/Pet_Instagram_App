// Assuming this is your StoryModel class, modify it to add a `seen` property.
class StoryModelss {
  final String title;
  final String imagePath;
  bool seen;

  StoryModelss({
    required this.title,
    required this.imagePath,
    this.seen = false,
  });
}

class StoryItemss {
  final String url;
  final bool isVideo;

  StoryItemss({required this.url, required this.isVideo});
}

// Story Model
class StoryModel {
  final int id;
  final int userId;
  final String mediaType;
  final String mediaUrl;
  final String textContent;
  final String privacy;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  StoryModel({
    required this.id,
    required this.userId,
    required this.mediaType,
    required this.mediaUrl,
    required this.textContent,
    required this.privacy,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      userId: json['user_id'],
      mediaType: json['media_type'],
      mediaUrl: json['media_url'],
      textContent: json['text_content'],
      privacy: json['privacy'],
      expiresAt: DateTime.parse(json['expires_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'media_type': mediaType,
      'media_url': mediaUrl,
      'text_content': textContent,
      'privacy': privacy,
      'expires_at': expiresAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
