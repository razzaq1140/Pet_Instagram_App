import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MessageProvider extends ChangeNotifier {
  final List<GroupMessage> _messages = [];
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  File? image;

  List<GroupMessage> get messages => _messages;

  MessageProvider() {
    // Pre-load messages
    _messages.addAll([
      GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ),
      GroupMessage(
        text: 'I am doing well, thank you!',
        isSender: true,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ),
    ]);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Send a text message
  void sendMessage(String text) {
    if (text.isNotEmpty) {
      _messages.add(GroupMessage(
        text: text,
        isSender: true,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ));
      messageController.clear();
      notifyListeners();
      _scrollToBottom();
    }
  }

  // Pick an image from camera
  Future<void> pickImageFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      _messages.add(GroupMessage(
        isSender: true,
        imageSend: image!.path,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ));
      notifyListeners();
      _scrollToBottom();
    }
  }

  // Pick an image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      _messages.add(GroupMessage(
        isSender: true,
        imageSend: image!.path,
        avatarUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      ));
      notifyListeners();
      _scrollToBottom();
    }
  }

  // Add reactions to messages
  void addReactionToMessage({required GroupMessage message, required String reaction}) {
    message.reactions.add(reaction);
    notifyListeners();
  }
}

class GroupMessage {
  final String? text;
  final String? imageSend;
  final String? avatarUrl;
  final bool isSender;
  List<String> reactions = [];

  GroupMessage({
    this.text,
    this.imageSend,
    this.avatarUrl,
    required this.isSender,
  });
}
