import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_search_delegate.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../models/pet__friends_model.dart';
import '../../../router/routes.dart';
import '../../group_chat/pages/group_chat_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  PetFollowerScreenState createState() => PetFollowerScreenState();
}

class PetFollowerScreenState extends State<ChatPage> {
  TextEditingController searchController = TextEditingController();
  bool isChatSelected = true; // Default selection is "Chat"
  final PageController _pageController =
      PageController(initialPage: 0); // PageView controller

  // List of Pet Followers (data handled through model class)
  final List<PetFriends> followers = [
    PetFriends(
      name: 'Kathryn Murphy',
      subtitle: 'Darrell Steward',
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    ),
    PetFriends(
        name: 'Annette Black',
        subtitle: 'Esther Howard',
        avatarUrl:
            "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg"),
    PetFriends(
        name: 'Eleanor Pena',
        subtitle: 'Cody Fisher',
        avatarUrl:
            "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg"),
    PetFriends(
        name: 'Jerome Bell',
        subtitle: 'Wade Warren',
        avatarUrl:
            "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg"),
  ];

  // For picking image from camera
  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      context.pushNamed(AppRoute.messagePage, extra: pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    isChatSelected = index == 0;
                  });
                },
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "chat".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 20,
                                      color: colorScheme(context).onSurface),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRoute.chatRequest);
                              },
                              child: Text(
                                "chat_request".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 20,
                                        color: colorScheme(context).onSurface),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(
                              searchTerms: [
                                'Jerome Bell'.tr(),
                                'Eleanor Pena'.tr(),
                                'Kathryn Murphy'.tr(),
                                'fish'.tr()
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:16.0),
                          child: AbsorbPointer(
                            child: CustomTextFormField(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(AppIcons.outlineSearch),
                              ),
                              readOnly: true,
                              hint: 'search_hint'.tr(),
                              borderColor:
                                  colorScheme(context).outline.withOpacity(0.4),
                              fillColor: colorScheme(context).surface,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: SvgPicture.asset(AppIcons.filter),
                              ),
                              suffixConstraints:
                                  const BoxConstraints(minHeight: 20),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: followers.length,
                            itemBuilder: (context, index) {
                              final follower = followers[index];
                              return ListTile(
                                onTap: () {
                                  context.pushNamed(AppRoute.messagePage);
                                },
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: follower.avatarUrl
                                          .contains('http')
                                      ? CachedNetworkImageProvider(
                                          follower.avatarUrl)
                                      : FileImage(File(follower.avatarUrl))
                                          as ImageProvider, // Display local images
                                ),
                                title: Text(
                                  follower.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color:
                                              colorScheme(context).onSurface),
                                ),
                                subtitle: Text(
                                  follower.subtitle,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: colorScheme(context)
                                            .onSurface
                                            .withOpacity(0.4),
                                      ),
                                ),
                                trailing: IconButton(
                                  icon: SvgPicture.asset(
                                    AppIcons.chatCamera,
                                    width: 24,
                                    height: 24,
                                  ),
                                  onPressed:
                                      _pickImageFromCamera, // Trigger camera
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  const GroupChatPage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                    color: colorScheme(context)
                        .onPrimary, // Light background for the toggle
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: colorScheme(context).outline.withOpacity(0.06))),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChatSelected = true;
                          });
                          _pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: isChatSelected
                                ? colorScheme(context).primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'chat'.tr(),
                            style: TextStyle(
                              color: isChatSelected
                                  ? colorScheme(context).surface
                                  : colorScheme(context)
                                      .outline
                                      .withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChatSelected = false;
                          });
                          _pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: !isChatSelected
                                ? colorScheme(context).primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'group'.tr(),
                            style: TextStyle(
                              color: !isChatSelected
                                  ? colorScheme(context).surface
                                  : colorScheme(context)
                                      .outline
                                      .withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
