import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';

import '../../../common/utils/custom_snackbar.dart';
import '../model/notification_user_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  NotificationPageState createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  int _selectedTabIndex = 0;

  List<NotificationUserModel> followers = [
    NotificationUserModel(
      name: 'Kathryn Murphy',
      subtitle: 'Darrell Steward',
      avatarUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    ),
    NotificationUserModel(
      name: 'Annette Black',
      subtitle: 'Esther Howard',
      avatarUrl:
          "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg",
    ),
    NotificationUserModel(
      name: 'Eleanor Pena',
      subtitle: 'Cody Fisher',
      avatarUrl:
          "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg",
    ),
    NotificationUserModel(
      name: 'Jerome Bell',
      subtitle: 'Wade Warren',
      avatarUrl:
          "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 4,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'notifications'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildTab('all'.tr(), 0, width: 100), // "All" tab
                const SizedBox(width: 15),
                _buildTab('follow_request'.tr(), 1, width: 180),
              ],
            ),
          ),
          Divider(color: colorScheme(context).outline.withOpacity(0.1)),
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildNotificationList('following'.tr()) // "All" tab content
                : _buildNotificationListWithButtons(), // "Follow Request" tab content
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, {double width = 120}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index
              ? colorScheme(context).primary
              : colorScheme(context).onPrimary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.hintText),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: _selectedTabIndex == index
                ? colorScheme(context).onPrimary
                : colorScheme(context).onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(String label) {
    return ListView.builder(
      itemCount: followers.length,
      itemBuilder: (context, index) {
        final follower = followers[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(follower.avatarUrl),
          ),
          title: Text(
            follower.name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: colorScheme(context).onSurface),
          ),
          subtitle: Text(
            follower.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.hintText,
                ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme(context).onPrimary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.hintText,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationListWithButtons() {
    return ListView.builder(
      itemCount: followers.length,
      itemBuilder: (context, index) {
        final follower = followers[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(follower.avatarUrl),
          ),
          title: Text(
            follower.name,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: colorScheme(context).onSurface),
          ),
          subtitle: Text(
            follower.subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.hintText,
                ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    followers.removeAt(index); // Remove the item from the list
                  });
                  showSnackbar(
                    message: 'User confirmed successfully', // Snackbar message
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme(context).primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'confirm'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme(context).onPrimary,
                      ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  showSnackbar(
                    message: 'User request deleted', // Snackbar message
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: colorScheme(context).onSurface,
                  backgroundColor: colorScheme(context).onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'delete'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme(context).onSurface,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
