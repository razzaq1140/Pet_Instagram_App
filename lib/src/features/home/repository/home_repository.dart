import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:pet_project/src/common/constants/static_data.dart';
import 'package:pet_project/src/core/api_endpoints.dart';
import 'package:pet_project/src/core/api_helper.dart';
import '../model/post_model.dart';

class HomeRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getPostFeed,
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        log(responseBody['message']);
        List<dynamic> data = responseBody['data'];
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Error : $e');
      return [];
    }
  }

  Future<bool> toggleLike({required int postId}) async {
    try {
      final response = await _apiHelper.postRequest(
        endpoint: '${ApiEndpoints.getAPost}$postId${ApiEndpoints.toggleLike}',
        authToken: StaticData.accessToken,
      );
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

  Future<bool> toggleSave({required int postId}) async {
    try {
      final response = await _apiHelper.postRequest(
        endpoint: '${ApiEndpoints.getAPost}$postId${ApiEndpoints.toggleSave}',
        authToken: StaticData.accessToken,
      );
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

  Future<bool> submitAPost({required List<File> files}) async {
    try {
      final Map<String, String> data = {
        'caption': 'My Post caption for caption is caption',
      };

      final response = await _apiHelper.postFilesWithDataRequest(
        endpoint: ApiEndpoints.submitAPost,
        data: data,
        key: 'media[]',
        files: files,
      );

      // final response = await request.send();
      log(response.statusCode.toString());
      log(await response.stream.bytesToString());
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

  Future<bool> setUserStory() async {
    try {
      final Map<String, String> data = {
        'media_type': 'image',
        'text_content': 'My Story captioncaptioncaption',
      };

      final response = await _apiHelper.postFilesWithDataRequest(
          endpoint: 'https://pet-insta.nextwys.com/api/stories',
          data: data,
          key: 'image',
          files: [
            File(
                "/data/user/0/com.example.pet_project/cache/6ae1b5af-36a8-4aa6-ac5a-86b006579c67/1729751181970.jpg"),
          ]);
      // final response = await request.send();
      log(response.statusCode.toString());
      log(response.stream.toString());
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
