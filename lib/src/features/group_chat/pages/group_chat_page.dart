import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/features/group_chat/model/group_chat_model.dart';
import 'package:pet_project/src/features/group_chat/provider/create_group_provider.dart';
import 'package:pet_project/src/features/group_chat/widget/group_chat_search_delegate.dart';
import 'package:pet_project/src/features/group_chat/widget/group_bottom_sheet.dart';
import 'package:pet_project/src/features/group_chat/widget/group_chat_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/global_variables.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({
    super.key,
  });

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GroupChatProvider>(context, listen: false).initialize([
        GroupChatModel(
            image:
                'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            name: 'Group Name 1',
            member: '12k Members',
            btTxt: 'Join Group Chat',
            message: '',
            status: 'Public'),
        GroupChatModel(
            image:
                'https://images.unsplash.com/photo-1517423568366-8b83523034fd?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            name: 'Group Name 2',
            member: '12k Members',
            message: '',
            btTxt: 'Join Group Chat',
            status: 'Private'),
        GroupChatModel(
            image:
                'https://images.unsplash.com/photo-1535554672698-902bc7dfbc50?q=80&w=1454&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            message: 'Unread: 25 messages',
            name: 'Group Name 3',
            member: '12k Members',
            btTxt: 'Chat',
            status: 'Private'),
        GroupChatModel(
            image:
                'https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=1528&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            name: 'Group Name 4',
            member: '12k Members',
            message: 'Unread: 25 messages',
            btTxt: 'Chat',
            status: 'Private'),
        GroupChatModel(
            image:
                'https://img.freepik.com/free-photo/view-cats-dogs-being-friends_23-2151806375.jpg?t=st=1726916519~exp=1726920119~hmac=a47d98e71ecb57c70416d25ea8b85ecc3f9c5665a187324529a092597592340a&w=360',
            name: 'Group Name 5',
            member: '12k Members',
            message: '',
            btTxt: 'Join Group Chat',
            status: 'Public'),
        GroupChatModel(
            image:
                'https://img.freepik.com/free-photo/view-cats-dogs-being-friends_23-2151806375.jpg?t=st=1726916519~exp=1726920119~hmac=a47d98e71ecb57c70416d25ea8b85ecc3f9c5665a187324529a092597592340a&w=360',
            name: 'Group Name 6',
            member: '12k Members',
            message: '',
            btTxt: 'Join Group Chat',
            status: 'Private'),
        GroupChatModel(
            image:
                'https://img.freepik.com/free-photo/view-cats-dogs-being-friends_23-2151806375.jpg?t=st=1726916519~exp=1726920119~hmac=a47d98e71ecb57c70416d25ea8b85ecc3f9c5665a187324529a092597592340a&w=360',
            name: 'Group Name 7',
            member: '12k Members',
            btTxt: 'Chat',
            status: 'Private'),
        GroupChatModel(
            image:
                'https://images.unsplash.com/photo-1518378188025-22bd89516ee2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            name: 'Group Name 8',
            member: '12k Members',
            message: '',
            btTxt: 'Join Group Chat',
            status: 'Public'),
        GroupChatModel(
            image:
                'https://images.unsplash.com/photo-1450778869180-41d0601e046e?q=80&w=1586&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            name: 'Group Name 9',
            member: '12k Members',
            btTxt: 'Chat',
            message: 'Unread: 25 messages',
            status: 'Private'),
        GroupChatModel(
            image:
                'https://img.freepik.com/free-photo/view-cats-dogs-being-friends_23-2151806375.jpg?t=st=1726916519~exp=1726920119~hmac=a47d98e71ecb57c70416d25ea8b85ecc3f9c5665a187324529a092597592340a&w=360',
            name: 'Group Name 10',
            member: '12k Members',
            btTxt: 'Join Group Chat',
            message: '',
            status: 'Public'),
        // Yahan aur groups add karen agar zarurat ho
      ]);
    });
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Consumer<GroupChatProvider>(
          builder: (context, groupChatProvider, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "group_chat".tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 20,
                            color: colorScheme(context).onSurface),
                      ),
                      TextButton(
                        child: Text("create_group".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 20,
                                    color: colorScheme(context).primary)),
                        onPressed: () {
                          showMyDialog(context);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<GroupChatProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: GroupChatSearchDelegate(
                                groupList: Provider.of<GroupChatProvider>(
                                        context,
                                        listen: false)
                                    .groupChats),
                          );
                        },
                        child: AbsorbPointer(
                          // AbsorbPointer will ensure the text field doesn't take direct input
                          child: CustomTextFormField(
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(AppIcons.outlineSearch),
                            ),

                            readOnly: true, // Make sure the field is read-only
                            hint: 'search_hint'.tr(),
                            borderColor:
                                colorScheme(context).outline.withOpacity(0.4),
                            fillColor: colorScheme(context).surface,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: SvgPicture.asset(AppIcons.filter),
                            ),
                            suffixConstraints:
                                const BoxConstraints(minHeight: 20),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: groupChatProvider.groupChats.length,
                    itemBuilder: (context, index) {
                      final group = groupChatProvider.groupChats[index];
                      return GroupChatWidget(
                        image: group.image,
                        name: group.name,
                        status: group.status,
                        message: group.message ?? '',
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  showMyDialog(BuildContext context) {
    String? selectedValue = 'Option 1';
    final formKey = GlobalKey<FormState>();
    TextEditingController groupNameController = TextEditingController();
    TextEditingController groupDescriptionController = TextEditingController();
    File? image; // Local file to hold the picked image
    final ImagePicker imagePicker = ImagePicker();
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dialog",
      pageBuilder: (context, _, __) {
        return Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.1),
          body: Form(
            key: formKey,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // 90% of the screen width
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('create_group_chat'.tr()),
                          const SizedBox(height: 8),
                          Text('upload_group_image'.tr()),
                          const SizedBox(height: 8),
                          InkWell(
                              onTap: () async {
                                final pickedImage = await imagePicker.pickImage(
                                    source: ImageSource.gallery);

                                if (pickedImage != null) {
                                  // Use setState to update the image in the dialog UI
                                  setState(() {
                                    image = File(pickedImage.path);
                                  });
                                }
                                // _showPersistentBottomSheet(context);
                                // setState(() {
                                //   image;
                                // });
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    image != null ? FileImage(image!) : null,
                                child: image == null
                                    ? const Icon(Icons.camera_alt)
                                    : null,
                              )),
                          const SizedBox(height: 8),
                          Text('enter_group_name',
                              style: textTheme(context).titleMedium!.copyWith(
                                    color: colorScheme(context).outline,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  )),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: groupNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'name_cannot_be_empty';
                              }
                              return null;
                            },
                            contentPadding: const EdgeInsets.all(8),
                            textStyle: textTheme(context).labelSmall!.copyWith(
                                color: colorScheme(context).outline,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            hint: 'enter_group_name'.tr(),
                            borderColor:
                                colorScheme(context).outline.withOpacity(0.4),
                          ),
                          const SizedBox(height: 8),
                          Text('enter_group_description'.tr(),
                              style: textTheme(context).titleMedium!.copyWith(
                                    color: colorScheme(context).outline,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  )),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: groupDescriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'description_cannot_be_empty'.tr();
                              }
                              return null;
                            },
                            contentPadding: const EdgeInsets.all(8),
                            maxline: 2,
                            textStyle: textTheme(context).labelSmall!.copyWith(
                                color: colorScheme(context).outline,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            hint:
                                '''Lorem Ipsum has been the industry's stand ard dummy text ever since Lorem Ipsum has been the industry's standard .''',
                            borderColor:
                                colorScheme(context).outline.withOpacity(0.4),
                          ),
                          const SizedBox(height: 8),
                          Text('group_category'.tr(),
                              style: textTheme(context).titleMedium!.copyWith(
                                    color: colorScheme(context).outline,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  )),
                          Row(
                            children: [
                              Text('public'.tr(),
                                  style:
                                      textTheme(context).labelLarge!.copyWith(
                                            color: colorScheme(context).outline,
                                          )),
                              Radio<String>(
                                  value: 'Option 1',
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  }),
                              Text('private'.tr(),
                                  style:
                                      textTheme(context).labelLarge!.copyWith(
                                            color: colorScheme(context).outline,
                                          )),
                              Radio<String>(
                                  value: 'Option 2',
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  }),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showCreateGroupBottomSheet(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: colorScheme(context).primary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'select_group_members'.tr(),
                                style: textTheme(context).labelMedium!.copyWith(
                                      color: colorScheme(context).onPrimary,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                              height: 45,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Provider.of<GroupChatProvider>(context,
                                          listen: false)
                                      .addGroup(
                                    GroupChatModel(
                                      image: image != null ? image!.path : '',
                                      name: groupNameController.text,
                                      member: '0 Members',
                                      message: '',
                                      btTxt: 'Join Group Chat',
                                      status:
                                          //selectedValue == 'Option 1'
                                          // ? 'public'.tr()
                                          'private'.tr(),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              text: 'create_group'.tr(),
                              textSize: 16),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: colorScheme(context)
                                        .outline
                                        .withOpacity(0.4)),
                              ),
                              child: Center(
                                child: Text('back'.tr(),
                                    style:
                                        textTheme(context).titleSmall!.copyWith(
                                              color: colorScheme(context)
                                                  .outline
                                                  .withOpacity(0.4),
                                            )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showCreateGroupBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the bottom sheet to be scrollable if content exceeds screen size
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => const CreateGroupBottomSheet(),
    );
  }
}
