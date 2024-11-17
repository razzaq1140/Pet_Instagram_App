import 'dart:io';

import 'package:avatar_stack/avatar_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/features/group_chat/provider/create_group_provider.dart';
import 'package:pet_project/src/features/group_chat/widget/group_chat_button.dart';
import 'package:pet_project/src/router/routes.dart';
import 'package:provider/provider.dart';

class GroupChatWidget extends StatefulWidget {
  final String image;
  final String name;
  final String status;
  final String message;
  const GroupChatWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.status,
      required this.message});

  @override
  State<GroupChatWidget> createState() => _GroupChatWidgetState();
}

class _GroupChatWidgetState extends State<GroupChatWidget> {
  bool favouriteValue = false;
  bool pinValue = false;
  String btText = 'Join Group Chat';
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupChatProvider>(
      builder: (context, groupChatProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () {
              setState(() {
                if (btText == 'Join Group Chat') {
                  btText = 'Chat';
                } else {
                  context.pushNamed(AppRoute.groupChat);
                }
              });
            },
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.01,
                    blurRadius: 3,
                    offset: const Offset(-4, 7),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Group Image
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.image.startsWith(
                                'http') // Checking if it's a network image
                            ? CachedNetworkImage(
                                imageUrl: widget.image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Image.file(
                                File(widget.image),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  // Group Details
                  Positioned(
                    left: 110,
                    top: 10,
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width - 130,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: widget.status == 'Public'
                            ?  const Color.fromARGB(255, 255, 220, 232)
                            : colorScheme(context).surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Group name and members count
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.name}(${widget.status})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: colorScheme(context)
                                                  .onSurface),
                                    ),
                                    Text(
                                      '12k Members',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize: 10,
                                              color: colorScheme(context)
                                                  .onSurface),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                // Favourite Icon
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      favouriteValue = !favouriteValue;
                                    });
                                  },
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: colorScheme(context)
                                              .primary
                                              .withOpacity(0.4)),
                                      child: Icon(
                                        favouriteValue
                                            ? Icons.favorite
                                            : Icons.favorite,
                                        color: favouriteValue
                                            ? Theme.of(context)
                                                .colorScheme
                                                .error
                                            : colorScheme(context).onPrimary,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      pinValue = !pinValue;
                                    });
                                  },
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: colorScheme(context)
                                              .primary
                                              .withOpacity(0.4)),
                                      child: Transform.rotate(
                                        angle: 26,
                                        child: Icon(
                                          pinValue
                                              ? Icons.push_pin
                                              : Icons.push_pin_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.message,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 10,
                                        color: colorScheme(context).onSurface),
                              ),
                              AvatarStack(
                                height: 25,
                                width: 70,
                                avatars: [
                                  for (var n = 0; n < 4; n++)
                                    const CachedNetworkImageProvider(
                                      'https://images.unsplash.com/photo-1518378188025-22bd89516ee2?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                    ),
                                ],
                              ),
                            ],
                          ),
                          // Join Group Chat Button

                          GroupChatButton(
                            btText: btText,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
