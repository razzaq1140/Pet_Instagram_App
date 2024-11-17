import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_text_field.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({super.key});

  @override
  CreateGroupBottomSheetState createState() => CreateGroupBottomSheetState();
}

class CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  // List of members with selection status
  final List<Member> members = [
    Member(
      name: 'Pet Training',
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: false,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
      'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
      'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
      'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
      'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
    Member(
      name: 'Pet Training',
      avatarUrl:
      'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      isSelected: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Adjust the bottom sheet height based on content
        children: [
          Text(
            'create_group'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16, color: colorScheme(context).onSurface),
          ),
          const SizedBox(height: 16), // Space between title and input field
          CustomTextFormField(
            hint: 'search_hint'.tr(),
            borderColor: colorScheme(context).outline.withOpacity(0.4),
            fillColor: colorScheme(context).surface,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SvgPicture.asset(AppIcons.filter),
            ),
            suffixConstraints: const BoxConstraints(minHeight: 20),
          ),
          const SizedBox(height: 16), // Space between input fields
          Text(
            'select_members'.tr(),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 16, color: colorScheme(context).onSurface),
          ),
          const SizedBox(height: 16), // Space before the member list

          // Members List with Cached Network Image and Checkbox
          SizedBox(
            height: 200, // Set fixed height for member list in the bottom sheet
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // Add space between items
                  child: ListTile(
                    contentPadding: EdgeInsets.zero, // Remove default padding
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 16), // Consistent padding for the image
                      child: CachedNetworkImage(
                        imageUrl: member.avatarUrl,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 35,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                    title: Text(member.name),
                    trailing: Checkbox(
                      value: member.isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          member.isSelected = value ?? false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10,),
          // Create Button
          CustomButton(
            height: 45,
            onTap: () {
              Navigator.pop(context);
            },
            text: 'confirm'.tr(),
          ),
        ],
      ),
    );
  }
}

class Member {
  String name;
  String avatarUrl;
  bool isSelected;

  Member({
    required this.name,
    required this.avatarUrl,
    required this.isSelected,
  });
}
