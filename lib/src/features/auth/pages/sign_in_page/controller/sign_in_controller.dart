import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/src/features/auth/pages/sign_in_page/repositary/sign_in_repositary.dart';
import 'package:pet_project/src/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../../_user_data/controllers/user_controller.dart';

class SignInController extends ChangeNotifier {
  final SignInRepositary _repository = SignInRepositary();
  bool _rememberMe = false;
  UserProfile? _user;
  bool _isLoading = false;
  String? _errorMessage;
  String? _fcmToken;

  UserProfile? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get rememberMe => _rememberMe;

  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required Function(String message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      await getFCMToken();
      log(_fcmToken.toString());
      bool isLogin = await _repository.loginUser(
          email,
          password,
          _fcmToken ??
              "cSkTRshzS9Gxz2ngVVHir6:APA91bGKFIjKgOOv--P3semoiC-miX1ugmI125sd70oo_iHobBNUP3J-u0FaJMvpttLYOaUFjrWkGjKOapkOoFTtW6dHusiRozoClmTgjMmnP_8IgPsmFR8");
      if (isLogin) {
        final userController =
            Provider.of<UserController>(context, listen: false);
        userController.fetchUserData();
        onSuccess('Login Successfully');
      } else {
        onError('Error while login account, Please try again.');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getFCMToken() async {
    _fcmToken = await FirebaseMessaging.instance.getToken();
  }
}
