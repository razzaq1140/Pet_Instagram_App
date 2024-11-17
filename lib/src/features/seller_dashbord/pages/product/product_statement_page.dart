import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../../common/constants/app_images.dart';
import '../widget/inputdata_of_sales.dart';

class ProductStatementPage extends StatefulWidget {
  const ProductStatementPage({super.key});

  @override
  State<ProductStatementPage> createState() => _ProductStatementPageState();
}

class _ProductStatementPageState extends State<ProductStatementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // backgroundColor: Colors.transparent,
        title: Row(
          children: [
              // GestureDetector(
              //   onTap: () {
              //     context.pop();
              //   },
              //   child: const Icon(Icons.arrow_back)),
            const SizedBox(width: 12),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Products Statement",
                  style: const TextTheme().bodyMedium,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.notificationPage);
                },
                child: SvgPicture.asset(AppIcons.notiIcon)),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme(context).onSecondary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: colorScheme(context).outline.withOpacity(0.3),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    InputDataOfSales(
                        label: "From"), // Independent Date Picker for "From"
                    SizedBox(height: 20),
                    InputDataOfSales(
                        label: "To"), // Independent Date Picker for "To"
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              onTap: () {
                context
                    .pushNamed(AppRoute.allProducts); // Navigate to report page
              },
              text: 'View Report',
            ),
          ],
        ),
      ),
    );
  }
}
