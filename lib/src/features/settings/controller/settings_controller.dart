// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/src/common/utils/custom_snackbar.dart';
import 'package:pet_project/src/common/utils/shared_preferences_helper.dart';
import 'package:pet_project/src/features/settings/repositary/settings_repositary.dart';
import 'package:pet_project/src/models/user_model.dart';
import 'package:pet_project/src/router/routes.dart';

class SettingsController extends ChangeNotifier {
  final SettingsRepositary _repository = SettingsRepositary();
  Map<String, dynamic>? currentUser;
  Map<String, dynamic>? profileSwitch;
  UserProfile? _user;
  bool _isLoading = false;
  String? _errorMessage;
  String currentRole = "user";
  File? _image;

  File? get image => _image;
  UserProfile? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSeller => currentRole == "seller";

// for logo
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      _image = File(selectedImage.path);
      notifyListeners();
    }
  }

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _repository.getUserData();

      if (response != null) {
        _user = response;
      } else {
        _errorMessage = 'Failed to fetch user data';
        log('Failed to fetch user data');
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error fetching user data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCurrentUser() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _repository.getCurrentUser();
      if (response != null && response.containsKey("current_role")) {
        currentRole = response["current_role"];
        log("Fetched current user role: $currentRole");
        notifyListeners();
      } else {
        _errorMessage = 'Failed to fetch current user role';
        log('Failed to fetch current user role');
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error fetching current user role: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> switchProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      String accessToken = SharedPrefHelper.getAccessToken()!;
      final result =
          await _repository.postSwitchProfile(accessToken: accessToken);

      if (result.containsKey("error")) {
        _errorMessage = result["error"]!;
        log('Failed to switch profile: $_errorMessage');

        if (_errorMessage!.contains(
            "You need to purchase a membership before switching to the seller profile.")) {
          // Navigate to Membership Page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.pushNamed(AppRoute.membershipPage);
          });
          // showSnackbar(message: _errorMessage!);
        } else {
          showSnackbar(message: _errorMessage!);
        }
      } else if (result.containsKey("message") &&
          result.containsKey("current_role")) {
        // Update currentRole with the new role from the response
        currentRole = result["current_role"];
        log("Profile switch successful: ${result['message']} to $currentRole");

        // Save new role in shared preferences
        await SharedPrefHelper.saveString('current_role', currentRole);

        notifyListeners();

        // Show success message
        showSnackbar(message: result['message']);

        // Delay to ensure UI updates properly
        Future.delayed(const Duration(milliseconds: 200), () {
          notifyListeners();
        });
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error switching profile: $e');
      showSnackbar(message: _errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<dynamic> memberships = [];

  Future fetchMemberships() async {
    _isLoading = true;
    notifyListeners();
    String accessToken = SharedPrefHelper.getAccessToken()!;

    log("accessToken $accessToken");

    try {
      final response =
          await _repository.getMemberships(accessToken: accessToken);

      if (response != null) {
        memberships = response;
        log('Fetched memberships: $memberships');
      } else {
        _errorMessage = 'Failed to fetch memberships';
        log('Failed to fetch memberships');
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error fetching memberships: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future purchaseMemberShip({required int userId}) async {
    _isLoading = true;
    notifyListeners();
    String accessToken = SharedPrefHelper.getAccessToken()!;

    log("accessToken $accessToken");

    try {
      final response = await _repository.postPurchaseMemberShip(
          accessToken: accessToken, id: userId);

      if (response != null) {
        log('Membership purchased: $response');
      } else {
        _errorMessage = 'Failed to purchase membership';
        log('Failed to purchase membership');
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error purchasing membership: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future setupSellerCenter(
      {required String storeName,
      required String ownerName,
      required String storeDetails}) async {
    _isLoading = true;
    notifyListeners();
    String accessToken = SharedPrefHelper.getAccessToken()!;

    log("accessToken $accessToken");

    try {
      final response = await _repository.postSellerSetupCenter(
          ownerName: ownerName,
          storeDetails: storeDetails,
          storeName: storeName,
          accessToken: accessToken);

      if (response != null) {
        final message = response['message'];
        showSnackbar(message: message);
      } else {
        _errorMessage = 'Failed to setup seller center';
        log('Failed to setup seller center');
        showSnackbar(message: _errorMessage!);
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error in seting up seller center: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future sellerSetupCenterLogo({
    required File logo,
    required Function(String? message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      String accessToken = SharedPrefHelper.getAccessToken()!;

      bool? isDone = await _repository.postSellerSetupCenterLogo(
          logo: logo, accessToken: accessToken);

      if (isDone == true) {
        onSuccess(null);
      } else if (isDone == false) {
        onError('Failed to set logo, please try again!');
      } else {
        onError('Try a different logo!');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future getSellerDashboard() async {
    _isLoading = true;
    notifyListeners();
    try {
      String accessToken = SharedPrefHelper.getAccessToken()!;

      final response =
          await _repository.getSellerDashboard(accessToken: accessToken);

      if (response != null) {
        final message = response["message"];

        log("Fetched current user role: $response");
        log("Fetched current user role: $message");
      } else {
        _errorMessage = 'Failed to fetch current user role';
        log('Failed to fetch current user role');
      }
    } catch (e) {
      _errorMessage = e.toString();
      log('Error fetching current user role: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
