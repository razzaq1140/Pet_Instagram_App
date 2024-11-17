import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../common/widget/product_card.dart';
import '../../buyer_and_seller/seller/pages/seller_center_page.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'favourite'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 20,
                                        color: colorScheme(context).onSurface),
                              ),
                              const Spacer(),
                              // GestureDetector(
                              //     onTap: () =>
                              //         context.pushNamed(AppRoute.ChatPage),
                              //     child: SvgPicture.asset(AppIcons.chatIcon)),
                           //   const SizedBox(width: 15),
                              GestureDetector(
                                  onTap: () => context
                                      .pushNamed(AppRoute.notificationPage),
                                  child: SvgPicture.asset(AppIcons.notiIcon)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          CustomTextFormField(
                            hint: 'search_hint'.tr(),
                            borderColor:
                                colorScheme(context).outline.withOpacity(0.4),
                            fillColor: colorScheme(context).surface,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: SvgPicture.asset(AppIcons.filter),
                            ),
                            suffixConstraints:
                                const BoxConstraints(minHeight: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'favourite_products'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 20,
                                    color: colorScheme(context).onSurface),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 7,
                    mainAxisExtent: 240,
                  ),
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    final product = featuredProducts[index];
                    return ProductCard(
                      product: product,
                      onLike: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      onTap: () {
                        context.pushNamed(AppRoute.productDetailPage);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
