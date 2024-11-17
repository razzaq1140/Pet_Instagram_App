import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../common/widget/custom_button.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final Color surfaceColor = Theme.of(context).colorScheme.surface;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Scaffold(
      // backgroundColor: surfaceColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            Theme.of(context).colorScheme.surface, // surfaceColor in your theme
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'payment'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(
            AppIcons.cartIcon,
            colorFilter:
                ColorFilter.mode(colorScheme(context).primary, BlendMode.srcIn),
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: () => context.pushNamed(AppRoute.notificationPage),
              child: SvgPicture.asset(AppIcons.notiIcon)),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            Image.asset(
              AppImages.payment,
              height: 200,
            ),
            const SizedBox(height: 24),
            Text(
              'thank_you_for_your_purchase'.tr(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'confirmation_email_text'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: colorScheme(context).outline.withOpacity(0.3)),
                color: onPrimaryColor, // White background for the container
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'order_detail'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context)
                              .onSurface, // White background for the container
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Order ID Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: colorScheme(context).surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'order_id'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '5648131584',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme(context)
                                        .outline
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Tracking ID Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: colorScheme(context).surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${'tracking_id'.tr()}:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '416841MS45358',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme(context)
                                        .outline
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Date & Time Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: colorScheme(context).surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'date_and_time'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '25 Sept, 2024 | 3:21 AM',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: colorScheme(context)
                                        .outline
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              text: 'finish'.tr(),
              onTap: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
