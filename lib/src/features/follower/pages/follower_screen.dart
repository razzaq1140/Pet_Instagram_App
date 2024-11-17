import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pet_project/src/common/widget/custom_search_delegate.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_text_field.dart';

// Model Class
class PetFollower {
  final String name;
  final String subtitle;
  final String avatarUrl;

  PetFollower({
    required this.name,
    required this.subtitle,
    required this.avatarUrl,
  });
}

// class PetFollowerScreen extends StatefulWidget {
//     final bool? isFollowersTab;

//   const PetFollowerScreen({super.key, this.isFollowersTab});

//   @override
//   PetFollowerScreenState createState() => PetFollowerScreenState();
// }

// class PetFollowerScreenState extends State<PetFollowerScreen> {
//   bool isChatSelected = true; // Default selection is "Follower"
//   PageController _pageController =
//       PageController(initialPage: 0); // PageView controller

//   // List of Pet Followers (data handled through model class)
final List<PetFollower> followers = [
  PetFollower(
    name: 'Kathryn Murphy',
    subtitle: 'Darrell Steward',
    avatarUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
  ),
  PetFollower(
    name: 'Annette Black',
    subtitle: 'Esther Howard',
    avatarUrl:
        "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg",
  ),
  PetFollower(
    name: 'Eleanor Pena',
    subtitle: 'Cody Fisher',
    avatarUrl:
        "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg",
  ),
  PetFollower(
    name: 'Jerome Bell',
    subtitle: 'Wade Warren',
    avatarUrl:
        "https://as2.ftcdn.net/v2/jpg/01/99/00/79/1000_F_199007925_NolyRdRrdYqUAGdVZV38P4WX8pYfBaRP.jpg",
  ),
];

class PetFollowerScreen extends StatefulWidget {
  final Map<String, dynamic> queryParameters;

  const PetFollowerScreen({
    super.key,
    this.queryParameters = const {},
  });

  @override
  PetFollowerScreenState createState() => PetFollowerScreenState();
}

class PetFollowerScreenState extends State<PetFollowerScreen> {
  late int
      currentIndex; // Track the current tab index (0 for Followers, 1 for Following)
  late PageController _pageController; // Controller to handle PageView

  @override
  void initState() {
    super.initState();

    // Read tabIndex from queryParameters
    currentIndex =
        int.tryParse(widget.queryParameters['tabIndex']?.toString() ?? '0') ??
            0;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pet Follower',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 20, color: colorScheme(context).onSurface),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      searchTerms: ['Dogs', 'Cats', 'Birds', 'Fish', 'Pets'],
                    ),
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(AppIcons.outlineSearch),
                    ),
                    readOnly: true,
                    hint: 'Search here..',
                    borderColor: colorScheme(context).outline.withOpacity(0.4),
                    fillColor: colorScheme(context).surface,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(AppIcons.filter),
                    ),
                    suffixConstraints: const BoxConstraints(minHeight: 20),
                  ),
                ),
              ),
            ),

            // PageView to display Followers or Following list
            Expanded(
              child: PageView(
                controller: _pageController, // Link PageController to PageView
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index; // Update the index when page changes
                  });
                },
                children: [
                  buildFollowerList('Remove'), // For Followers screen
                  buildFollowerList('Following'), // For Following screen
                ],
              ),
            ),

            // Toggle buttons for Followers and Following
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme(context).onPrimary,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: colorScheme(context).outline.withOpacity(0.06),
                  ),
                ),
                child: Row(
                  children: [
                    // Followers Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                          _pageController.animateToPage(
                              0, // Go to Followers Page
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: currentIndex == 0
                                ? colorScheme(context).primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Followers',
                            style: TextStyle(
                              color: currentIndex == 0
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

                    // Following Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                          _pageController.animateToPage(
                              1, // Go to Following Page
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: currentIndex == 1
                                ? colorScheme(context).primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Following',
                            style: TextStyle(
                              color: currentIndex == 1
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

  // Build Follower/Following List based on screen (label is passed as a parameter)
  Widget buildFollowerList(String label) {
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
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
          ),
          subtitle: Text(
            follower.subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.4),
                ),
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme(context).onPrimary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: colorScheme(context).onSurface.withOpacity(0.3),
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
}
