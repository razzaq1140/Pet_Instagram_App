import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';

import '../../common/constants/global_variables.dart';

class GroupMessagePage extends StatefulWidget {
  const GroupMessagePage({super.key});

  @override
  State<GroupMessagePage> createState() => _GroupMessagePageState();
}

class _GroupMessagePageState extends State<GroupMessagePage> {
  final List<GroupMessage> messages = [
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'I am doing well, thank you!',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'This is a default forwarded message.',
        isSender: true,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    GroupMessage(
        text: 'Hello! How are you?',
        isSender: false,
        imageUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  ]; // Default messages to display

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void scrollBottamSheet(FocusNode focusNode){
    focusNode.addListener((){
      if (focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  void sendMessage(String text) {
    setState(() {
      messages.add(GroupMessage(
          text: text,
          isSender: true,
          imageUrl:
              'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'));
      _messageController.clear();
    });
    _scrollToBottom(); // Scroll to the bottom after sending a message
  }

  void sendVoice(String voiceUrl) {
    setState(() {
      messages.add(GroupMessage(text: '', voiceUrl: voiceUrl, isSender: true));
    });
    _scrollToBottom(); // Scroll to the bottom after sending a voice message
  }

  // Function to scroll to the bottom of the list
  void _scrollToBottom() {
    // Ensure the scroll happens after the layout has been completed
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  String formattedText(String? text) {
    if (text!.length > 30) {
      return text.replaceAllMapped(
          RegExp(r".{30}"), (match) => "${match.group(0)}\n");
    }
    return text;
  }

  File? image;
  void _pickImageCamera() async {
    final pickImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickImage != null) {
      setState(() {
        image = File(pickImage.path);
        messages.add(GroupMessage(
            isSender: false,
            imageSend: image!.path,
            imageUrl:
                'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'));
      });
      _scrollToBottom();
    }
  }

  void _pickImageGallery() async {
    final pickImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      setState(() {
        image = File(pickImage.path);
        messages.add(GroupMessage(
            isSender: false,
            imageSend: image!.path,
            imageUrl:
                'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'));
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: AppColor.hintText,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
                width: 12), // Adjust the spacing between image and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Group Chat',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
                Text(
                  'Jerome Bell',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColor.hintText),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: SvgPicture.asset(AppIcons.callIcon),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SvgPicture.asset(AppIcons.videoIcon),
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(1.0),
        //   child: Container(
        //     color: Colors.grey, // Divider color
        //     height: 1.0,
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 9),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColor.lightBlack.withOpacity(0.3)),
                  bottom:
                      BorderSide(color: AppColor.lightBlack.withOpacity(0.3)),
                ),
              ),
              child: Center(
                child: Text(
                  'About Food',
                  style: textTheme(context).titleMedium!.copyWith(
                      letterSpacing: 0, color: colorScheme(context).primary),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Align(
                          alignment: message.isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: message.isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!message.isSender)
                                    message.text == null
                                        ? Container()
                                        : CircleAvatar(
                                            radius: 18,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              message.imageUrl.toString(),
                                            ),
                                          ),
                                  Flexible(
                                    child: message.text == null
                                        ? Container(
                                            color: Colors.transparent,
                                          )
                                        : Card(
                                            margin: const EdgeInsets.all(12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            color: message.isSender
                                                ? colorScheme(context)
                                                    .onPrimary // sender ka color
                                                : colorScheme(context)
                                                    .onPrimary, // receiver ka color
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (message.text != null &&
                                                      message.text!.isNotEmpty)
                                                    Text(
                                                      formattedText(
                                                          message.text),
                                                      softWrap: true,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  if (message.imageUrl != null)
                                                    // yahan par image ko show karne ka code
                                                    //   CachedNetworkImage(
                                                    //     imageUrl: message.imageUrl!,
                                                    //     placeholder: (context, url) =>
                                                    //     const CircularProgressIndicator(),
                                                    //     errorWidget: (context, url, error) =>
                                                    //     const Icon(Icons.error),
                                                    //     height: 150,
                                                    //     fit: BoxFit.cover,
                                                    //   ),
                                                    if (message.voiceUrl !=
                                                        null)
                                                      const Icon(
                                                          Icons.play_arrow),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                  if (message.isSender)
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        message.imageUrl.toString(),
                                      ),
                                    ),
                                ],
                              ),
                              message.imageSend != null &&
                                      message.imageSend!.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Container(
                                              height: 230,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  File(message.imageSend
                                                      .toString()),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              message.imageUrl.toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 45,
              child: CustomTextFormField(
                hint: 'Type..',

                focusNode: _focusNode,
                controller: _messageController,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _pickImageCamera();
                    },
                    child: SvgPicture.asset(
                      AppIcons.chatCamera,
                      height: 24, // Adjust the size if necessary
                    ),
                  ),
                ),
                borderColor: AppColor.hintText,
                prefixConstraints: const BoxConstraints(minHeight: 24),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Ensure this doesn't take too much space
                  children: [
                    SvgPicture.asset(AppIcons.mikeIcon),
                    const SizedBox(width: 10),
                    InkWell(
                        onTap: () {
                          _pickImageGallery();
                        },
                        child: SvgPicture.asset(AppIcons.chatGalleryIcon)),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        if (_messageController.text.isNotEmpty) {
                          sendMessage(_messageController.text);
                        }
                      },
                      child: SvgPicture.asset(
                        AppIcons.outlineSendIcon,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                hintColor: colorScheme(context).onSurface,
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class GroupMessage {
  final String? text;
  final String? imageUrl;
  final String? imageSend;
  final String? voiceUrl;
  final bool isSender;

  GroupMessage({
    this.text,
    this.imageUrl,
    this.imageSend,
    this.voiceUrl,
    required this.isSender,
  });
}
