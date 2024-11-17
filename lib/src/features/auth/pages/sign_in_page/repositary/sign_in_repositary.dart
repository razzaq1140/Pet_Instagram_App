import 'dart:convert';
import 'dart:developer';
import 'package:pet_project/src/core/api_helper.dart';
import '../../../../../common/utils/shared_preferences_helper.dart';
import '../../../../../core/api_endpoints.dart';

class SignInRepositary {
  final ApiHelper _apiHelper = ApiHelper();
  Future<bool> loginUser(String email, String password, fcmToken) async {
    try {
      log(fcmToken);
      final data = {
        'username': email,
        'password': password,
        'fcm_token': fcmToken
      };

      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.login,
        data: data,
      );

      if (response.statusCode == 200) {
        log('verified $email');
        final responseBody = jsonDecode(response.body);

        String accessToken = responseBody['access_token'];

        await SharedPrefHelper.saveAccessToken(accessToken);
        SharedPrefHelper.saveBool('isLoggedIn', true);

        return true;
      } else {
        log('Failed: ${response.body}');
        return false;
      }
    } catch (e) {
      log('Error: $e');
      return false;
    }
  }
}
