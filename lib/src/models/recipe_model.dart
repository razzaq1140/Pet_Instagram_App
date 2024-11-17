import 'dart:io';

class RecipeModel {
  final String name;
  final String category;
  final String preparationSteps;
  final List<File> images;

  RecipeModel({
    required this.name,
    required this.category,
    required this.preparationSteps,
    required this.images,
  });

  // Factory constructor to create RecipeModel from a Map
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      name: map['name'] as String? ?? 'Unknown',
      category: map['category'] as String? ?? 'Uncategorized',
      preparationSteps: map['preparationSteps'] as String? ?? '',
      images: (map['images'] as List<dynamic>? ?? [])
          .map((path) => File(path as String))
          .toList(),
    );
  }

  // Convert RecipeModel to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'preparationSteps': preparationSteps,
      'images': images.map((file) => file.path).toList(),
    };
  }
}
