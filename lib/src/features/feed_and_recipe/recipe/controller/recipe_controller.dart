import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/src/common/utils/image_picker_helper.dart';
import 'package:pet_project/src/common/utils/shared_preferences_helper.dart';
import 'package:pet_project/src/features/feed_and_recipe/recipe/repositary/recipe_repositary.dart';
import 'package:pet_project/src/models/recipe_model.dart';

class UploadRecipeController extends ChangeNotifier {
  final RecipeRepository _repository = RecipeRepository();

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  final List<File> _pickedImages = [];
  String _descriptionJson = '';
  List<RecipeModel> _recipeList = [];
  List<RecipeModel> get recipeList => _recipeList;
  List<File> get pickedImages => _pickedImages;
  String get descriptionJson => _descriptionJson;

  void updateDescription(String description) {
    _descriptionJson = description;
    notifyListeners();
  }

  void removeImage(int index) {
    _pickedImages.removeAt(index);
    notifyListeners();
  }

  Future<void> fetchRecipeFeed() async {
    try {
      final response = await _repository.fetchRecipe();
      if (response.isNotEmpty) {
        _recipeList = response;
      } else {
        log('Failed to fetch  data');
      }
    } catch (e) {
      log('Error fetching  data: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    ImagePickerHelper.showImageSourceSelection(
      context,
      onTapCamera: () async {
        final XFile? image = await ImagePickerHelper.pickImageFromCamera();
        if (image != null) {
          _pickedImages.add(File(image.path));
          notifyListeners();
        }
      },
      onTapGallery: () async {
        final List<XFile> images = await ImagePickerHelper.pickMultipleImages();
        if (images.isNotEmpty) {
          _pickedImages.addAll(images.map((image) => File(image.path)));
          notifyListeners();
        }
      },
    );
  }

  Future<void> uploadRecipe({
    required String name,
    required String category,
    required String preparationSteps,
    required List<File> images,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      String accessToken = SharedPrefHelper.getAccessToken()!;
      bool isUploaded = await _repository.uploadRecipe(
          accessToken, name, category, preparationSteps, images);
      if (isUploaded) {
        onSuccess('');
      } else {
        onError('Error while uploading recipe, Please try again.');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
    // final ImagePicker picker = ImagePicker();
    // final List<XFile> images = await picker.pickMultiImage();
    // if (images.isNotEmpty) {
    //   _pickedImages.addAll(images.map((image) => File(image.path)));
    //   notifyListeners();
    // }