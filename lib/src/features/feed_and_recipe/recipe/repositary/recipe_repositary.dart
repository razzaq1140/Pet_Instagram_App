import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pet_project/src/common/utils/shared_preferences_helper.dart';

import 'package:pet_project/src/core/api_endpoints.dart';
import 'package:pet_project/src/core/api_helper.dart';
import 'package:pet_project/src/models/recipe_model.dart';

class RecipeRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<bool> uploadRecipe(
    String accessToken,
    String name,
    String category,
    String preparationSteps,
    List<File> images,
  ) async {
    try {
      var uri = Uri.parse(ApiEndpoints.uploadRecipe);
      var request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $accessToken';

      request.fields['name'] = name;
      request.fields['category'] = category;
      request.fields['preparation_steps'] = preparationSteps;

      for (var image in images) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images[]',
            image.path,
            filename: basename(image.path),
          ),
        );
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        log('Recipe uploaded successfully');
        return true;
      } else {
        final responseBody = await response.stream.bytesToString();
        log('Failed: $responseBody');
        return false;
      }
    } catch (e) {
      log('Error: $e');
      return false;
    }
  }

  Future<List<RecipeModel>> fetchRecipe() async {
  try {
    final accessToken = SharedPrefHelper.getAccessToken();
   

    final response = await _apiHelper.getRequest(
      endpoint: ApiEndpoints.getRecipe,
      authToken: accessToken,
    );

    if (response.statusCode != 200) {
      log('Failed to fetch data. Status code: ${response.statusCode}');
      return [];
    }

    final responseBody = jsonDecode(response.body);
    log(responseBody['message']);

    final data = responseBody['data'];
    if (data is List) {
      return data.map((json) => RecipeModel.fromMap(json)).toList();
    } else if (data is Map<String, dynamic>) {
      log('$data');
      return [RecipeModel.fromMap(data)];
      
    } else {
      log('Unexpected data structure: ${data.runtimeType}');
      return [];
    }
  } catch (e, stackTrace) {
    log('Error fetching recipes: $e', stackTrace: stackTrace);
    return [];
  }
}

}
