import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pet_project/src/common/utils/custom_snackbar.dart';
import 'package:pet_project/src/features/_user_data/controllers/user_controller.dart';
import 'package:pet_project/src/features/home/controller/home_controller.dart';
import 'package:pet_project/src/features/home/model/story_model.dart';
import 'package:pet_project/src/features/search/search_page.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../router/routes.dart';
import '../widget/post_home_widget.dart';
import '../widget/show_full_screen_image.dart';
import "package:story_view/story_view.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  List<File> _pickedImages = []; // To store picked image files
  late HomeController _homeController;
  // late HomeStoryController _homeStoryController;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController = Provider.of<HomeController>(context, listen: false);
      // _homeStoryController =
      //     Provider.of<HomeStoryController>(context, listen: false);
      _homeController.fetchPostFeed();
      // _homeStoryController.fetchOwnStory();
    });
  }

  // Updated stories list with seen status
  final List<StoryModelss> stories = [
    StoryModelss(title: 'Tales', imagePath: AppImages.pinkCat, seen: false),
    StoryModelss(title: 'Furry', imagePath: AppImages.pinkDog, seen: false),
    StoryModelss(title: 'Tales', imagePath: AppImages.whiteDog, seen: false),
    StoryModelss(title: 'Pals', imagePath: AppImages.pinkDog, seen: false),
    StoryModelss(title: 'Whiskers', imagePath: AppImages.pinkCat, seen: false),
    StoryModelss(title: 'Tales', imagePath: AppImages.whiteDog, seen: false),
  ];

  // Function to handle adding a story (Picking an image or video)
  Future<void> _addStory() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      log(pickedFiles.first.path);
      _pickedImages = pickedFiles
          .map((pickedFile) => File(pickedFile.path))
          .toList(); // Store the picked image files
    });
    _homeController.submitAPost(
      context: context,
      files: _pickedImages,
      onError: (error) {
        showSnackbar(message: error, isError: true);
      },
      onSuccess: (message) {
        log('success');
      },
    );
  }

  // Function to view full-screen image
  void _viewImageFullScreen(File image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenImageViewer(imageFile: image),
      ),
    );
  }

  // Function to handle story view
  void _viewStory(int index) {
    setState(() {
      stories[index].seen = true;
    });
    context.pushNamed(AppRoute.statusStory);
  }

  StoryController storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'home'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 20,
                                  color: colorScheme(context).onSurface),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const SearchPage(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade,
                            );
                          },
                          child: SvgPicture.asset(
                            AppIcons.outlineSearch,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoute.notificationPage);
                            },
                            child: SvgPicture.asset(AppIcons.notiIcon)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 120,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // First item as your profile story

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (_pickedImages.isNotEmpty) {
                                    _viewImageFullScreen(_pickedImages.first);
                                  } else {
                                    _addStory();
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Consumer<UserController>(builder:
                                        (context, userController, widget) {
                                      return CircleAvatar(
                                        radius: 35,
                                        child: ClipOval(
                                          child: Image(
                                            height: 70,
                                            width: 70,
                                            image: _pickedImages.isNotEmpty
                                                ? FileImage(_pickedImages.first)
                                                : NetworkImage(
                                                    userController
                                                        .user!.profileImage,
                                                  ),
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child; // Return the image when fully loaded
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: colorScheme(context)
                                                      .surface,
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Icon(Icons.pets,
                                                    size: 50,
                                                    color: colorScheme(context)
                                                        .surface
                                                        .withOpacity(0.8)),
                                          ),
                                        ),
                                      );
                                    }),
                                    GestureDetector(
                                      onTap: _addStory,
                                      child: Container(
                                        height: 25,
                                        width: 26,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'your_story'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                        color: colorScheme(context).onSurface),
                              ),
                            ],
                          ),
                        ),
                        // Other stories
                        ...stories.asMap().entries.map((entry) {
                          int index = entry.key;
                          StoryModelss story = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    GestureDetector(
                                      onTap: () => _viewStory(index),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            AssetImage(story.imagePath),
                                      ),
                                    ),
                                    if (!story.seen)
                                      Positioned(
                                        bottom: 4,
                                        right: 0,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            color: AppColor.appGreen,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  story.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color:
                                              colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  // Posts Section
                  Consumer<HomeController>(
                      builder: (context, homeController, widget) {
                    if (homeController.postList.isEmpty) {
                      return const Center(
                        child: Text('No Posts Found'),
                      );
                    }
                    return ListView.builder(
                      itemCount: homeController.postList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PostHomeWidget(
                            post: homeController.postList[index]);
                      },
                    );
                  }),
                  const SizedBox(height: 15),
                  // ListView.builder(
                  //   itemCount: postss.length,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return PostHomeWidget(post: postss[index]);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//