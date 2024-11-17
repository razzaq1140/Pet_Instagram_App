import 'package:flutter/material.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/features/home/model/post_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../router/routes.dart';
import '../constants/app_colors.dart';
import '../constants/app_images.dart';
import 'package:go_router/go_router.dart';

class CustomComment extends StatefulWidget {
  final int postUserId;
  final List<CommentModel> comments;
  final Function(int index) onLikeTapped;
  final Function(String comment) onSendComment;

  const CustomComment({
    super.key,
    required this.postUserId,
    required this.comments,
    required this.onLikeTapped,
    required this.onSendComment,
  });

  @override
  CustomCommentState createState() => CustomCommentState();
}

class CustomCommentState extends State<CustomComment> {
  final TextEditingController _commentController = TextEditingController();

  String changeToTimeAgo(DateTime date) {
    String timeAgo = timeago.format(date);
    return timeAgo;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColor.hintText,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Comments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller:
                      scrollController, // Use the provided scrollController
                  itemCount: widget.comments.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final comment = widget.comments[index];
                    return ListTile(
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
                            comment.user.profileImage,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              AppImages.pinkDog,
                            ),
                          )),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(comment.user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          if (comment.user.id == widget.postUserId)
                            const Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Author',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.hintText,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.content),
                          Row(
                            children: [
                              Text(
                                  changeToTimeAgo(DateTime.parse(
                                      comment.createdAt.toString())),
                                  style: const TextStyle(
                                      color: AppColor.hintText, fontSize: 12)),
                              const SizedBox(width: 8),
                              const Text(
                                'Reply',
                                style: TextStyle(
                                    color: AppColor.hintText, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // trailing: Column(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         setState(() {
                      //           widget.onLikeTapped(index);
                      //         });
                      //       },
                      //       child: Icon(
                      //         comment['isLiked']
                      //             ? Icons.favorite
                      //             : Icons.favorite_border,
                      //         color: comment['isLiked']
                      //             ? AppColor.appRed
                      //             : AppColor.hintText,
                      //       ),
                      //     ),
                      //     Text("${comment['likes']}"),
                      //   ],
                      // ),
                    );
                  },
                ),
              ),
              const Divider(),
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(AppImages.whiteDog),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextFormField(
                      controller: _commentController,
                      hint: 'Add a comment...',
                      borderColor:
                          colorScheme(context).outline.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (_commentController.text.isNotEmpty) {
                        setState(() {
                          widget.onSendComment(_commentController.text);
                        });
                        _commentController.clear(); // Clear the input field
                      }
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
