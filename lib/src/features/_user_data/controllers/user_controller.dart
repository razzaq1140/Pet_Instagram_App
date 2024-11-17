import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_project/src/common/constants/static_data.dart';
import 'package:pet_project/src/features/_user_data/repository/user_repository.dart';
import 'package:pet_project/src/models/user_model.dart';
import '../../../common/utils/shared_preferences_helper.dart';

class UserController extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  UserProfile? _user;

  UserProfile? get user => _user;

  Future<void> fetchUserData() async {
    try {
      final response = await _repository.getUserData();
      if (response != null) {
        _user = response;
        // HomeRepository().setUserStory();
      } else {
        StaticData.isLoggedIn = false;
        StaticData.accessToken = '';
        log('Failed to fetch user data');
      }
      notifyListeners();
    } catch (e) {
      log('Error fetching user data: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateUserAbout({
    required String username,
    required String name,
    required String dogType,
    required String breed,
    required int age,
    required double weight,
    required String about,
    required File? image,
    required Function(String? message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      String accessToken = SharedPrefHelper.getAccessToken()!;
      bool done = await _repository.updateUserAbout(username, name, dogType,
          breed, age, weight, about, accessToken, image);
      if (done) {
        fetchUserData();
        onSuccess(null);
      } else {
        onError('Failed to upload data, Please try again.');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
