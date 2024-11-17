import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:pet_project/src/core/api_helper.dart';
import 'package:pet_project/src/models/user_model.dart';

class SettingsRepositary {
  final ApiHelper _apiHelper = ApiHelper();
  final String baseUrl = 'https://pet-insta.nextwys.com/api';

  Future<UserProfile?> getUserData() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: '$baseUrl/user/profile',
      );

      if (response.statusCode == 200) {
        return UserProfile.fromJson(json.decode(response.body));
      } else {
        log('Failed: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future getCurrentUser() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: '$baseUrl/profile/current',
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        log('data $data');
        return data;
      } else {
        log('Failed: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future postSwitchProfile({required String accessToken}) async {
    try {
      final response = await _apiHelper.postRequest(
        endpoint: '$baseUrl/profile/switch',
        authToken: accessToken,
      );
      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {"message": responseBody["message"]};
      } else {
        log('Failed: ${response.body}');
        return responseBody;
      }
    } catch (e) {
      log('Error: $e');
      return {"error": "An error occurred while switching profiles"};
    }
  }

  Future<List<dynamic>?> getMemberships({required String accessToken}) async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: '$baseUrl/memberships',
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('reponse: ${response.body}');

        final message = responseBody["message"];

        log('message $message');
        return responseBody["data"];
      } else {
        log('Failed to fetch memberships: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error fetching memberships: $e');
      return null;
    }
  }

  Future postPurchaseMemberShip(
      {required String accessToken, required int id}) async {
    final data = {
      'membership_id': id,
      'payment_token': 'pm_card_visa',
    };

    try {
      final response = await _apiHelper.postRequest(
        endpoint: '$baseUrl/membership/purchase',
        data: data,
        authToken: accessToken,
      );

      final responseBody = jsonDecode(response.body);
      final message = responseBody['message'];

      log('message: $message');

      if (response.statusCode == 200) {
        // showSnackbar(message: message);
        log(responseBody);
        return responseBody;
      } else {
        log('Failed: ${response.body}');
        return {"error": responseBody["error"]};
      }
    } catch (e) {
      log('Error: $e');
      return 'An error occurred while purchasing membership.';
    }
  }

  Future postSellerSetupCenter(
      {required String accessToken,
      required String storeName,
      required String ownerName,
      required String storeDetails}) async {
    // data to send
    final data = {
      'store_name': storeName,
      'owner_name': ownerName,
      'store_details': storeDetails,
    };

    try {
      final response = await _apiHelper.postRequest(
        endpoint: '$baseUrl/seller-center/setup',
        data: data,
        authToken: accessToken,
      );
      log('code: ${response.statusCode}');
      log('code: ${response.body}');

      final responseBody = jsonDecode(response.body);
      final message = responseBody['message'];

      log('message: $message');

      log('message: $responseBody');

      if (response.statusCode == 200) {
        // showSnackbar(message: message);
        return responseBody;
      } else {
        log('Failed: ${response.body}');
        return response.body;
      }
    } catch (e) {
      log('Error: $e');
      return 'An error occurred while purchasing membership.';
    }
  }

  Future postSellerSetupCenterLogo(
      {required String accessToken, required File logo}) async {
    try {
      final response = await _apiHelper.postFileRequest(
          endpoint: '$baseUrl/seller-center/store-logo',
          file: logo,
          key: 'store_logo',
          authToken: accessToken);
 
      log('code: ${response.statusCode}');
 
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

  Future getSellerDashboard({required String accessToken}) async {
    try {
      final response = await _apiHelper.getRequest(
          endpoint: '$baseUrl/seller/dashboard', authToken: accessToken);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        log('data $data');
        return data;
      } else {
        log('Failed: ${response.body}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
