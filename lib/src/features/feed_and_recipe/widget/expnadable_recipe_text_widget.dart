
// Widget for the expandable text
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/global_variables.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String initialText;
  final String fullText;

  const ExpandableTextWidget({
    super.key,
    required this.initialText,
    required this.fullText,
  });

  @override
  ExpandableTextWidgetState createState() => ExpandableTextWidgetState();
}

class ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            widget.initialText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          secondChild: Text(
            widget.fullText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Show less'.tr() : 'See all Steps'.tr(),
            style: TextStyle(
              fontSize: 14,
              color: colorScheme(context).primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

}