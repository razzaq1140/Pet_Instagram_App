import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_project/src/features/home/model/post_model.dart';
import 'package:pet_project/src/features/home/repository/home_repository.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();
  List<PostModel> _postList = [];
  List<PostModel> get postList => _postList;

  Future<void> fetchPostFeed() async {
    try {
      final response = await _repository.fetchPosts();
      if (response.isNotEmpty) {
        _postList = response;
      } else {
        log('Failed to fetch Posts data');
      }
    } catch (e) {
      log('Error fetching user data: $e');
    } finally {
      notifyListeners();
      // _repository.submitAPost();
    }
  }

  Future<void> toggleLike({
    required int postId,
    required Function(String? message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      bool done = await _repository.toggleLike(postId: postId);
      if (done) {
        onSuccess(null);
      } else {
        onError('Failed to like post, Please try again.');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleSave({
    required int postId,
    required Function(String? message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      bool done = await _repository.toggleSave(postId: postId);
      if (done) {
        onSuccess(null);
      } else {
        onError('Failed to like post, Please try again.');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> submitAPost({
    required List<File> files,
    required Function(String? message) onSuccess,
    required Function(String error) onError,
    required BuildContext context,
  }) async {
    try {
      bool? isDone = await _repository.submitAPost(files: files);
      if (isDone == true) {
        onSuccess(null);
      } else if (isDone == false) {
        onError('Failed to set name, please try again!');
      } else {
        onError('Try a different username!');
      }
    } catch (e) {
      onError(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
