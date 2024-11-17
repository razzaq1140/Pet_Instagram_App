import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:link_text/link_text.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/widget/custom_search_delegate.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../../common/widget/product_card.dart';
import '../../../../models/product_model.dart';

final List<ProductModel> featuredProducts = [
  ProductModel(
    imageUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    title: 'Pet House',
    price: 150,
  ),
  ProductModel(
    imageUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    title: 'Pet House',
    price: 150,
  ),
  ProductModel(
    imageUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    title: 'Pet House',
    price: 150,
  ),
  ProductModel(
    imageUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    title: 'Pet Food',
    price: 150,
  ),
  ProductModel(
    imageUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    title: 'Pet Toys',
    price: 150,
  ),
  ProductModel(
    imageUrl:
        'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
    title: 'Pet Housing',
    price: 150,
  ),
];

class SellerCenterPage extends StatefulWidget {
  const SellerCenterPage({super.key});

  @override
  State<SellerCenterPage> createState() => _SellerCenterPageState();
}

class _SellerCenterPageState extends State<SellerCenterPage> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    // Method to launch URL

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Main content inside a Stack
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'seller_center'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontSize: 20,
                                  color: colorScheme(context).onSurface),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => context.pushNamed(AppRoute.cartPage),
                          child: SvgPicture.asset(AppIcons.cartIcon),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () =>
                              context.pushNamed(AppRoute.notificationPage),
                          child: SvgPicture.asset(AppIcons.notiIcon),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme(context).onPrimary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              color: colorScheme(context).outlineVariant,
                              width: 1),
                        ),
                        child: TabBar(
                          labelStyle: textTheme(context).titleSmall,
                          labelColor: colorScheme(context).onPrimary,
                          unselectedLabelColor: colorScheme(context).outline,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: colorScheme(context).primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                          ),
                          tabs: [
                            Tab(
                              child: Text(
                                "dashboard".tr(),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "my_products".tr(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRoute.salesStatement);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                colorScheme(context).onPrimary,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(6)),
                                            border: Border.all(
                                              color: colorScheme(context)
                                                  .outline
                                                  .withOpacity(0.1),
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 35),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                AppImages.sales,
                                                height: 80,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                  "190K",
                                                  style: textTheme(context)
                                                      .headlineMedium,
                                                ),
                                              ),
                                              Text(
                                                "sales".tr(),
                                                style: textTheme(context)
                                                    .titleSmall
                                                    ?.copyWith(
                                                        color:
                                                            AppColor.hintText),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                                AppRoute.productStatement);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: colorScheme(context)
                                                  .onPrimary,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              border: Border.all(
                                                color: colorScheme(context)
                                                    .outline
                                                    .withOpacity(0.1),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.product,
                                                  height: 60,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          "150",
                                                          style: textTheme(
                                                                  context)
                                                              .headlineMedium,
                                                        ),
                                                      ),
                                                      Text(
                                                        "product".tr(),
                                                        style: textTheme(
                                                                context)
                                                            .titleSmall
                                                            ?.copyWith(
                                                                color: AppColor
                                                                    .hintText),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () => context.pushNamed(
                                              AppRoute.customerDetail),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: colorScheme(context)
                                                  .onPrimary,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(6)),
                                              border: Border.all(
                                                color: colorScheme(context)
                                                    .outline
                                                    .withOpacity(0.1),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(16),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  AppImages.deal,
                                                  height: 60,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10),
                                                        child: Text(
                                                          "5.6K",
                                                          style: textTheme(
                                                                  context)
                                                              .headlineMedium,
                                                        ),
                                                      ),
                                                      Text(
                                                        "customers".tr(),
                                                        style: textTheme(
                                                                context)
                                                            .titleSmall
                                                            ?.copyWith(
                                                                color: AppColor
                                                                    .hintText),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme(context).onPrimary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    border: Border.all(
                                      color: colorScheme(context)
                                          .outline
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'pet_house_business'.tr(),
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context.pushNamed(
                                                  AppRoute.bussinessProfile);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 7),
                                              decoration: BoxDecoration(
                                                color: colorScheme(context)
                                                    .primary,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(6)),
                                              ),
                                              child: Text(
                                                'edit'.tr(),
                                                style: textTheme(context)
                                                    .titleSmall
                                                    ?.copyWith(
                                                        color: AppColor
                                                            .whiteShade),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        overflow: TextOverflow.visible,
                                        'Lorem Ipsum has been the industry\'s standard dummy text ever since the',
                                        style: textTheme(context)
                                            .bodySmall
                                            ?.copyWith(),
                                      ),
                                      LinkText(
                                        shouldTrimParams: true,
                                        'https://github.com/zainirajpot',
                                        linkStyle:
                                            TextStyle(color: AppColor.appBlue),
                                        // textAlign: TextAlign.center,
                                        // You can optionally handle link tap event by yourself
                                        // onLinkTap: (url) => ...
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(AppRoute.orderHistory);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme(context).onPrimary,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6)),
                                      border: Border.all(
                                        color: colorScheme(context)
                                            .outline
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order History",
                                          style: textTheme(context)
                                              .titleSmall
                                              ?.copyWith(
                                                  color: AppColor.hintText),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_right,
                                          color: AppColor.hintText,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    "top_selling_categories".tr(),
                                    style: textTheme(context).titleSmall,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme(context).onPrimary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    border: Border.all(
                                      color: colorScheme(context)
                                          .outline
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 14),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pet Travel, Pet House",
                                        style: textTheme(context)
                                            .titleSmall
                                            ?.copyWith(
                                                color: AppColor.hintText),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "top_selling_categories".tr(),
                                    style: textTheme(context).titleSmall,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme(context).onPrimary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    border: Border.all(
                                      color: colorScheme(context)
                                          .outline
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 18),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Pet Travel, Pet House",
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    color: AppColor.hintText),
                                          ),
                                          Text(
                                            "584",
                                            style:
                                                textTheme(context).titleSmall,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                        color: AppColor.hintText,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Pet House",
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    color: AppColor.hintText),
                                          ),
                                          Text(
                                            "451",
                                            style:
                                                textTheme(context).titleSmall,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                        color: AppColor.hintText,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Pet Toys",
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    color: AppColor.hintText),
                                          ),
                                          Text("354",
                                              style: textTheme(context)
                                                  .titleSmall),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                        color: AppColor.hintText,
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Pet Accessories",
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    color: AppColor.hintText),
                                          ),
                                          Text(
                                            "245",
                                            style:
                                                textTheme(context).titleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                          // Second Tab Content
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Trigger the search delegate when the field is tapped
                                    showSearch(
                                      context: context,
                                      delegate: CustomSearchDelegate(
                                        searchTerms: [
                                          'dogs'.tr(),
                                          'cats'.tr(),
                                          'birds'.tr(),
                                          'fish'.tr(),
                                          'pets'.tr()
                                        ],
                                      ),
                                    );
                                  },
                                  child: AbsorbPointer(
                                    // AbsorbPointer will ensure the text field doesn't take direct input
                                    child: CustomTextFormField(
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SvgPicture.asset(
                                            AppIcons.outlineSearch),
                                      ),
                                      readOnly: true,
                                      hint: 'search_hint'.tr(),
                                      borderColor: colorScheme(context)
                                          .outline
                                          .withOpacity(0.4),
                                      fillColor: colorScheme(context).surface,
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        child:
                                            SvgPicture.asset(AppIcons.filter),
                                      ),
                                      suffixConstraints:
                                          const BoxConstraints(minHeight: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        context.pushNamed(
                                            AppRoute.productDetailPage);
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Floating button at bottom-right
              Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(
                        AppRoute.addProduct); // Navigate to the desired route
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme(context).primary.withOpacity(0.5),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme(context).primary,
                      ),
                      child: Icon(
                        Icons.add_box_outlined,
                        size: 24,
                        color: colorScheme(context).surface,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
