import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_text_field.dart';
import '../provider/message_provider.dart';

class MessagePage extends StatefulWidget {
  final String? imagePath;

  const MessagePage({super.key, this.imagePath});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // If an imagePath is passed from ChatPage, add it to the messages list
    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      Provider.of<MessageProvider>(context, listen: false).messages.add(
            GroupMessage(
              isSender: true,
              imageSend: widget.imagePath,
            ),
          );
    }
  }

  void showEmojiBottomSheet({
    required GroupMessage message,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 310,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              Navigator.pop(context);

              Provider.of<MessageProvider>(context, listen: false)
                  .addReactionToMessage(
                      message: message, reaction: emoji.emoji);
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  // Show full-screen image with animation and close button
  void _showFullScreenImage(String imagePath) {
    _animationController.forward(); // Start the animation

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: ScaleTransition(
                scale: _animation,
                child: Hero(
                  tag: imagePath,
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  _animationController.reverse();
                  Navigator.of(context).pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      _animationController.reset();
    });
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
            GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Icon(Icons.arrow_back)),
            const SizedBox(width: 12),
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
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<MessageProvider>(
          // Wrap in Consumer to listen to changes
          builder: (context, chatProvider, _) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: chatProvider.scrollController,
                      itemCount: chatProvider.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatProvider.messages[index];

                        final heroTag = message.text ??
                            message.imageSend ??
                            'default-hero-tag-$index';

                        return GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (_) => ReactionsDialogWidget(
                                id: heroTag,
                                messageWidget: buildMessageWidget(message),
                                onReactionTap: (reaction) {
                                  if (reaction == '➕') {
                                    showEmojiBottomSheet(message: message);
                                  } else {
                                    chatProvider.addReactionToMessage(
                                      message: message,
                                      reaction: reaction,
                                    );
                                  }
                                },
                                widgetAlignment: message.isSender
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                // ignore: non_constant_identifier_names
                                onContextMenuTap: (MenuItem) {},
                              ),
                            );
                          },
                          child: message.imageSend != null
                              ? Hero(
                                  tag: heroTag,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showFullScreenImage(message.imageSend!);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        constraints: const BoxConstraints(
                                          maxHeight: 200,
                                          maxWidth: 160,
                                        ),
                                        child: Image.file(
                                          File(message.imageSend!),
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : buildMessageWidget(message),
                        );
                      },
                    ),
                  ),
                ),
                buildChatInputField(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildMessageWidget(GroupMessage message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isSender)
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              message.avatarUrl ??
                  'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
            ),
            radius: 24,
          ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: message.isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: message.isSender ? Colors.white : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: Border.all(
                    color: colorScheme(context).outline.withOpacity(0.2),
                  ),
                ),
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child:
                      message.imageSend != null && message.imageSend!.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _showFullScreenImage(message.imageSend!);
                              },
                              child: Hero(
                                tag: message.imageSend!,
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 200,
                                    maxWidth: 200,
                                  ),
                                  child: Image.file(
                                    File(message.imageSend!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : Text(message.text ?? ''),
                ),
              ),
              if (message.reactions.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: Wrap(
                      children: message.reactions
                          .map((reaction) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text(
                                  reaction,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (message.isSender)
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              message.avatarUrl ??
                  'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
            ),
            radius: 24,
          ),
      ],
    );
  }

  Widget buildChatInputField(BuildContext context) {
    final chatProvider = Provider.of<MessageProvider>(context, listen: false);

    return SizedBox(
      height: 50,
      child: CustomTextFormField(
        hint: 'Type..',
        focusNode: chatProvider.focusNode,
        controller: chatProvider.messageController,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              chatProvider.pickImageFromCamera();
            },
            child: SvgPicture.asset(
              AppIcons.chatCamera,
              height: 24,
            ),
          ),
        ),
        borderColor: AppColor.hintText,
        prefixConstraints: const BoxConstraints(minHeight: 24),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppIcons.mikeIcon),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                chatProvider.pickImageFromGallery();
              },
              child: SvgPicture.asset(AppIcons.chatGalleryIcon),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                if (chatProvider.messageController.text.isNotEmpty) {
                  chatProvider.sendMessage(chatProvider.messageController.text);
                }
              },
              child: SvgPicture.asset(AppIcons.outlineSendIcon),
            ),
            const SizedBox(width: 10),
          ],
        ),
        hintColor: colorScheme(context).onSurface,
      ),
    );
  }
}
