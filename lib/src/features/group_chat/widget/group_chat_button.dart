import 'package:flutter/material.dart';

class GroupChatButton extends StatefulWidget {
  final String btText;
  const GroupChatButton({super.key,required this.btText});

  @override
  State<GroupChatButton> createState() => _GroupChatButtonState();
}

class _GroupChatButtonState extends State<GroupChatButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Center(
        child: Text(
          widget.btText,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context)
                  .colorScheme
                  .onPrimary),
        ),
      ),
    );
  }
}
