import 'dart:convert';
import 'dart:developer';

import '../../../core/api_endpoints.dart';
import '../../../core/api_helper.dart';
import '../model/story_model.dart';

class HomeStoryRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<List<StoryModel>> fetchOwnStory() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getOwnStories,
      );
      if (response.statusCode == 200) {
        log(response.body);
        var responseBody = jsonDecode(response.body);
        log(responseBody['message']);
        List<dynamic> data = responseBody['data'];
        return data.map((json) => StoryModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Error : $e');
      return [];
    }
  }
}
