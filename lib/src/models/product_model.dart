
class CategoryModel {
  final String imagePath;
  final String title;

  CategoryModel({
    required this.imagePath,
    required this.title,
  });
}

class ProductModel {
  final String imageUrl;
  final String title;
  final double price;
  final String? category;
   bool isFavorite;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.price,
    this.isFavorite=false,

    this.category,
  });
}

class SellerModels {
  final String imageUrl;
  final String name;

  SellerModels({required this.imageUrl, required this.name});
}
