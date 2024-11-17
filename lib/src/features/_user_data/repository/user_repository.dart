import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../../../core/api_endpoints.dart';
import '../../../core/api_helper.dart';
import '../../../models/user_model.dart';

class UserRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<UserProfile?> getUserData() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getUserProfile,
      );
      if (response.statusCode == 200) {
        return UserProfile.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        log('Failed: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future<bool> setUserProfileImage(File image, String accessToken) async {
    try {
      final response = await _apiHelper.postFileRequest(
          endpoint: ApiEndpoints.setUserProfileImage,
          file: image,
          key: 'profile_image',
          authToken: accessToken);

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed : ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }

  Future<bool> updateUserAbout(
      String username,
      String name,
      String petType,
      String breed,
      int age,
      double weight,
      String about,
      String accessToken,
      File? image) async {
    try {
      final data = {
        'username': username,
        'name': name,
        "about": about,
        'dog_type': petType,
        'breed': breed,
        'age': age,
        "weight": weight,
      };

      if (image != null) {
        setUserProfileImage(image, accessToken);
      }
      final response = await _apiHelper.postRequest(
          endpoint: ApiEndpoints.setUserAbout,
          data: data,
          authToken: accessToken);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error : $e');
      return false;
    }
  }
}
