import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../common/widget/product_card.dart';
import '../../../models/product_model.dart';

class PetCategoriesPage extends StatefulWidget {
  final String category;
  final List<ProductModel> products;
  final String sellerName; // Accept seller name
  final TextEditingController searchController;

  const PetCategoriesPage({
    super.key,
    required this.products,
    required this.searchController,
    required this.category,
    required this.sellerName,
  });

  @override
  State<PetCategoriesPage> createState() => _PetCategoriesPageState();
}

class _PetCategoriesPageState extends State<PetCategoriesPage> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.category,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 20,
                                      color: colorScheme(context).onSurface),
                            ),
                            const Spacer(),
                            GestureDetector(
                                onTap: () =>
                                    context.pushNamed(AppRoute.cartPage),
                                child: SvgPicture.asset(AppIcons.cartIcon)),
                            const SizedBox(width: 15),
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
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(AppIcons.outlineSearch),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Text(
                              '${widget.category} ${'product'.tr()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 20,
                                      color: colorScheme(context).onSurface),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.sellerName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: 16,
                                      color: colorScheme(context)
                                          .outline
                                          .withOpacity(0.5)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 7,
                  mainAxisExtent: 240,
                ),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
