import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/widget/custom_comments.dart';
import 'package:pet_project/src/features/home/controller/home_controller.dart';
import 'package:pet_project/src/features/home/widget/show_full_screen_image.dart'; // Ensure you have this import for the FullScreenImageViewer
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/custom_snackbar.dart';
import '../../../common/widget/custom_shimmer.dart';
import '../../../router/routes.dart';
import '../model/post_model.dart';

class PostHomeWidget extends StatefulWidget {
  final PostModel post;
  final bool showDescription;
  final Widget? child;
  final String? customPostTime;

  const PostHomeWidget({
    super.key,
    required this.post,
    this.customPostTime,
    this.showDescription = true,
    this.child,
  });

  @override
  State<PostHomeWidget> createState() => _PostHomeWidgetState();
}

class _PostHomeWidgetState extends State<PostHomeWidget> {
  bool isFavorite = false;
  bool isBookmarked = false;
  VideoPlayerController? _videoController;
  final PageController _pageController = PageController();
  int currentIndex = 0;
  late HomeController _homeController;
  // late UserController _userController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController = Provider.of<HomeController>(context, listen: false);
      // _userController = Provider.of<UserController>(context, listen: false);
      isFavorite = widget.post.likedByUser;
      isBookmarked = widget.post.savedByUser;
      // isBookmarked = widget.post.s;
    });

    // Initialize video controller if the first media is a video
    // if (widget.post.postMedia.isNotEmpty &&
    //     _isVideo(widget.post.postMedia[0])) {
    //   _initializeVideo(widget.post.postMedia[0]);
    // }

    //   _pageController.addListener(() {
    //     setState(() {
    //       currentIndex = _pageController.page?.round() ?? 0;

    //       // If the new media is a video, initialize the controller
    //       if (_isVideo(widget.post.postMedia[currentIndex])) {
    //         _initializeVideo(widget.post.postMedia[currentIndex]);
    //       } else {
    //         // Dispose video controller if current media is not a video
    //         _videoController?.dispose();
    //         _videoController = null;
    //       }
    //     });
    //   });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // bool _isVideo(String url) {
  //   return url.endsWith('.mp4') || url.endsWith('.avi') || url.endsWith('.mov');
  // }

  // void _initializeVideo(String videoUrl) {
  //   _videoController?.dispose();
  //   _videoController = VideoPlayerController.network(videoUrl)
  //     ..initialize().then((_) {
  //       setState(() {}); // Rebuild to show video when initialized
  //       _videoController
  //           ?.play(); // Automatically play the video once initialized
  //     }).catchError((error) {
  //       log('Error initializing video: $error');
  //     });
  // }

  String changeToTimeAgo(DateTime date) {
    String timeAgo = timeago.format(date);

    return timeAgo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme(context).onSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.myProfile);
                },
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipOval(
                      child: Image.network(
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    widget.post.user.profileImage,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      AppImages.pinkDog,
                    ),
                  )),
                ),
              ),
              title: Text(
                widget.post.user.username,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: colorScheme(context).outline),
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Report') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reported this post')),
                    );
                  } else if (value == 'Block') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Blocked this user')),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Report', 'Block'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ),
          // Media section with PageView and indicator
          // if (widget.post.postMedia.any((media) => _isVideo(media)))
          //   _buildVideoPageView()
          // else
          _buildStaggeredImages(),
          _buildActionBar(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 26,
                  leading: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(50.0),
                      //   child: CachedNetworkImage(
                      //     imageUrl: widget.post.mediaPaths.isEmpty
                      //         ? ''
                      //         : widget.post.mediaPaths.first,
                      //     width: 36,
                      //     height: 36,
                      //     fit: BoxFit.cover,
                      //     placeholder: (context, url) =>
                      //         const CircularProgressIndicator(),
                      //     errorWidget: (context, url, error) =>
                      //         const Icon(Icons.error),
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoute.myProfile);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.network(
                            widget.post.user.profileImage,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const CustomShimmer(
                                width: 36,
                                height: 36,
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox(
                              width: 36,
                              height: 36,
                              child: Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                            width: 36,
                            height: 36,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRoute.myProfile);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              widget.post.user.profileImage,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return const CustomShimmer(
                                  width: 36,
                                  height: 36,
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox(
                                width: 36,
                                height: 36,
                                child: Center(
                                  child: Icon(Icons.error),
                                ),
                              ),
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: RichText(
                      text: TextSpan(
                          text: 'liked_by'.tr(),
                          style: textTheme(context).bodySmall,
                          children: [
                        TextSpan(
                          text: 'Furry',
                          style: textTheme(context).bodyMedium,
                        ),
                        TextSpan(text: 'and_others'.tr())
                      ])),
                ),
                if (widget.showDescription)
                  Text(
                    widget.post.caption, // Show description
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    softWrap: true,
                  )
                else if (widget.child != null) ...[
                  widget.child!,
                ],
                Text(
                  widget.customPostTime ??
                      changeToTimeAgo(
                          DateTime.parse(widget.post.createdAt.toString())),
                  style: const TextStyle(
                    color: AppColor.hintText,
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildVideoPageView() {
  //   return Stack(
  //     alignment: Alignment.bottomCenter,
  //     children: [
  //       SizedBox(
  //         height: 350,
  //         child: PageView.builder(
  //           controller: _pageController,
  //           itemCount: widget.post.postMedia.length,
  //           itemBuilder: (context, index) {
  //             final mediaUrl = widget.post.postMedia[index];
  //             return _isVideo(mediaUrl)
  //                 ? _buildVideoContent()
  //                 : _buildImageContent(mediaUrl);
  //           },
  //         ),
  //       ),
  //       Positioned(
  //         bottom: 10,
  //         child: SmoothPageIndicator(
  //           controller: _pageController,
  //           count: widget.post.postMedia.length,
  //           effect: ScrollingDotsEffect(
  //             activeDotColor: Theme.of(context).colorScheme.onPrimary,
  //             dotColor: AppColor.hintText,
  //             dotHeight: 8,
  //             dotWidth: 8,
  //             spacing: 8,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildStaggeredImages() {
    final imageUrls = widget.post.mediaPaths;
    // widget.post.postMedia.where((url) => !_isVideo(url)).toList();

    // Handle cases for 1 to 4 images
    if (imageUrls.length == 1) {
      // If there is only one image, show it full screen
      return GestureDetector(
        onTap: () => _showFullScreenImage(imageUrls[0]),
        child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 350,
            child: Image.network(
              imageUrls[0],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  child;
                }
                return const CustomShimmer(
                  height: 350,
                );
              },
              errorBuilder: (context, object, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
      );
    } else if (imageUrls.length == 2) {
      // If there are 2 images, show them side by side
      return GestureDetector(
        child: Row(
          children: imageUrls.map((imageUrl) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 350,
                  child: GestureDetector(
                    onTap: () => _showFullScreenImage(imageUrl),
                    child: Image.network(
                      widget.post.user.profileImage,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const CustomShimmer(
                          height: 350,
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(
                        width: double.infinity,
                        height: 350,
                        child: Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    } else if (imageUrls.length == 3) {
      // If there are 3 images, staggered layout
      return Padding(
        padding: EdgeInsets.zero,
        child: SizedBox(
          height: 300,
          child: StaggeredGrid.count(
            crossAxisCount: 3, // Number of columns in the grid
            children: List.generate(imageUrls.length, (index) {
              return GestureDetector(
                onTap: () => _showFullScreenImage(imageUrls[index]),
                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.cover,
                  height: 300,
                  placeholder: (context, url) => const CustomShimmer(
                    height: 350,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            }),
          ),
        ),
      );
    } else if (imageUrls.length == 4) {
      // If there are 4 images, show them in a 2x2 grid
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2x2 grid
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showFullScreenImage(imageUrls[index]),
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => const CustomShimmer(
                height: 350,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      );
    } else if (imageUrls.length == 5) {
      // For 5 images, show them in a scrollable PageView with an indicator
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 350,
            child: PageView.builder(
              controller: _pageController,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CustomShimmer(
                    height: 350,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              },
            ),
          ),
          Positioned(
            bottom: 10,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: imageUrls.length, // Show indicator for all 5 images
              effect: ScrollingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.onPrimary,
                dotColor: AppColor.hintText,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 8,
              ),
            ),
          ),
        ],
      );
    } else if (imageUrls.isNotEmpty) {
      return GestureDetector(
        onTap: () => _showFullScreenImage(imageUrls[0]),
        child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 350,
            child: Image.network(
              imageUrls[0],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  child;
                }
                return const CustomShimmer(
                  height: 350,
                );
              },
              errorBuilder: (context, object, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
      );
    }

    return Container(); // Fallback in case there are no images
  }

  // Widget _buildImageContent(String imageUrl) {
  //   return SizedBox(
  //     height: 350,
  //     child: CachedNetworkImage(
  //       imageUrl: imageUrl,
  //       height: 300,
  //       width: double.infinity,
  //       fit: BoxFit.cover,
  //       placeholder: (context, url) => Shimmer.fromColors(
  //         baseColor: AppColor.hintText,
  //         highlightColor: AppColor.hintText,
  //         child: Container(color: AppColor.hintText),
  //       ),
  //       errorWidget: (context, url, error) => const Icon(Icons.error),
  //     ),
  //   );
  // }

  void _showFullScreenImage(String imageUrl) {
    // Check if the URL is a valid file path or a network image
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      // It's a network image
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenImageViewer(imageUrl: imageUrl),
        ),
      );
    } else {
      // It's a local file
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => FullScreenImageViewer(imageFile: File(imageUrl)),
        ),
      );
    }
  }

  // Widget _buildVideoContent() {
  //   if (_videoController != null && _videoController!.value.isInitialized) {
  //     return GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           _videoController!.value.isPlaying
  //               ? _videoController!.pause()
  //               : _videoController!.play();
  //         });
  //       },
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           AspectRatio(
  //             aspectRatio: 39 / 32,
  //             child: VideoPlayer(_videoController!),
  //           ),
  //           if (!_videoController!.value.isPlaying)
  //             Icon(
  //               Icons.play_arrow,
  //               size: 60,
  //               color: Theme.of(context).colorScheme.onPrimary,
  //             ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return const Center(child: CircularProgressIndicator());
  //   }
  // }

  Widget _buildActionBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _homeController.toggleLike(
                    context: context,
                    postId: widget.post.id,
                    onSuccess: (_) {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    onError: (error) {
                      showSnackbar(message: error, isError: true);
                    },
                  );
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                  (widget.post.likes.length + (isFavorite ? 1 : 0)).toString()),
              const SizedBox(width: 17),
              GestureDetector(
                onTap: () {
                  showCommentsModal(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.commentIcon),
                    const SizedBox(width: 5),
                    Text('${widget.post.comments.length}'),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  Share.share(widget.post.caption);
                },
                child: SvgPicture.asset(AppIcons.sendIcon),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _homeController.toggleSave(
                context: context,
                postId: widget.post.id,
                onSuccess: (_) {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                },
                onError: (error) {
                  showSnackbar(message: error, isError: true);
                },
              );
            },
            child: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void showCommentsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromWindowPadding(
              WidgetsBinding.instance.window.viewInsets,
              WidgetsBinding.instance.window.devicePixelRatio),
          child: CustomComment(
            postUserId: widget.post.userId,
            comments: widget.post.comments,
            onSendComment: (newComment) {
              // setState(() {
              //   comments.add({
              //     "user": "current_user",
              //     "comment": newComment,
              //     "timeAgo": "Just now",
              //     "likes": 0,
              //     "isLiked": false,
              //   });
              // });
            },
            onLikeTapped: (int index) {
              // setState(() {
              //   comments[index]['isLiked'] = !comments[index]['isLiked'];
              //   if (comments[index]['isLiked']) {
              //     comments[index]['likes'] += 1;
              //   } else {
              //     comments[index]['likes'] -= 1;
              //   }
              // });
            },
          ),
        );
      },
    );
  }
}
