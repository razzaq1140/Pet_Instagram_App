import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/widget/custom_search_delegate.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/features/categories/pages/pet_categories_page.dart';
import 'package:pet_project/src/features/categories/pages/top_sellers.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../../common/constants/global_variables.dart';
import '../../../../common/widget/product_card.dart';
import '../../../../models/product_model.dart';

class PetShoppingPage extends StatefulWidget {
  const PetShoppingPage({super.key});

  @override
  PetShoppingPageState createState() => PetShoppingPageState();
}

class PetShoppingPageState extends State<PetShoppingPage> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = [
      CategoryModel(
          imagePath: AppImages.accessories, title: "accessories".tr()),
      CategoryModel(imagePath: AppImages.food, title: "food".tr()),
      CategoryModel(imagePath: AppImages.toys, title: "toys".tr()),
      CategoryModel(imagePath: AppImages.house, title: "housing".tr()),
      CategoryModel(imagePath: AppImages.food, title: "travel".tr()),
      CategoryModel(imagePath: AppImages.food, title: "Clothing".tr()),
    ];

    final List<SellerModels> topSellers = [
      SellerModels(
        imageUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
        name: 'Brok Simmons',
      ),
      SellerModels(
        imageUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
        name: 'Carn William',
      ),
      SellerModels(
        imageUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
        name: 'Lie Alexandra',
      ),
    ];

    final List<ProductModel> featuredProducts = [
      //pet House start

      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/files/551E4E54-BA00-4473-844D-E0D8BD52DC21.jpg?v=1708297217&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/products/WhatsAppImage2021-02-11at1.21.29AM.jpg?v=1614636061&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/products/image_2e5c6385-b97b-4af7-b89d-e38fe4251d13.jpg?v=1673475274&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://www.buyon.pk/image/cachewebp/data/members/bleralspot/pethouse-1718040778-386x386.webp',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/files/551E4E54-BA00-4473-844D-E0D8BD52DC21.jpg?v=1708297217&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/products/image_2e5c6385-b97b-4af7-b89d-e38fe4251d13.jpg?v=1673475274&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/files/551E4E54-BA00-4473-844D-E0D8BD52DC21.jpg?v=1708297217&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/files/551E4E54-BA00-4473-844D-E0D8BD52DC21.jpg?v=1708297217&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/files/551E4E54-BA00-4473-844D-E0D8BD52DC21.jpg?v=1708297217&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://thebowpoint.pk/cdn/shop/files/551E4E54-BA00-4473-844D-E0D8BD52DC21.jpg?v=1708297217&width=713',
        title: 'Pet House',
        price: 150,
        category: 'housing'.tr(),
      ),
      //pet House End
      ProductModel(
        imageUrl:
            "https://img.freepik.com/free-photo/still-life-pet-food-composition_23-2148982347.jpg?w=360&t=st=1727687479~exp=1727688079~hmac=fc99e9bf7be28a8eacf8b98d542a5f48223aac30dc43496c382e2feb7a4b81cd",
        title: 'Pet Food',
        price: 150,
        category: 'food'.tr(),
      ),
      ProductModel(
        imageUrl:
            "https://img.freepik.com/free-photo/still-life-pet-food-composition_23-2148982347.jpg?w=360&t=st=1727687479~exp=1727688079~hmac=fc99e9bf7be28a8eacf8b98d542a5f48223aac30dc43496c382e2feb7a4b81cd",
        title: 'Pet Food',
        price: 150,
        category: 'food'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://royalcaninpetfood.pk/wp-content/uploads/2023/10/royal-canin-maxi-starter-2.jpg',
        title: 'Pet Food',
        price: 150,
        category: 'food'.tr(),
      ),
      ProductModel(
        imageUrl:
            "https://img.freepik.com/free-vector/mascots-bags-food-set_24877-51205.jpg?w=740&t=st=1727687667~exp=1727688267~hmac=5006193cde56516135a4b155b856b9d158c99328f14309c925641e19663dadb5",
        title: 'Pet Food',
        price: 150,
        category: 'food'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
        title: 'Pet Toys',
        price: 100,
        category: 'toys'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://img.freepik.com/free-photo/colorful-pet-accessories-still-life-concept_23-2148949591.jpg?t=st=1727687914~exp=1727691514~hmac=e7544c4cbedf90668a014bb94ff9da3c14042254e4ff33b001a5ccdae97ea31d&w=360',
        title: 'Pet Accessories',
        price: 200,
        category: 'accessories'.tr(),
      ),
      ProductModel(
        imageUrl:
            'https://img.freepik.com/free-photo/close-up-pet-accessories_23-2150960027.jpg?t=st=1727687855~exp=1727691455~hmac=2912a205ab5079cdbebd7340d2a85eb7cf316b8fb9013b0ff5b6428d08c2d8db&w=740',
        title: 'Pet Accessories',
        price: 200,
        category: 'accessories'.tr(),
      ),
      ProductModel(
        imageUrl:
            // https://www.petshub.pk/wp-content/uploads/2019/06/cat-carrier-bag-2.jpg.webp
            'https://www.petset.com.pk/wp-content/uploads/2024/06/d3b3571a-9779-4939-a3db-a349f5a63a62.jpg',
        title: 'Pet Travel',
        price: 200,
        category: 'travel'.tr(),
      ),
      ProductModel(
        imageUrl:
            // " https://i.ebayimg.com/images/g/Y2AAAOSwPQ5ihfqQ/s-l1600.webp",
            'https://www.petset.com.pk/wp-content/uploads/2024/06/d3b3571a-9779-4939-a3db-a349f5a63a62.jpg',
        title: 'Pet Travel',
        price: 200,
        category: 'travel'.tr(),
      ),
      ProductModel(
        imageUrl:
            // https://catsandtails.com.pk/wp-content/uploads/2023/08/1692635824_Pet20Carrying20Bag20Printed-600x600.jpg,
            'https://www.petset.com.pk/wp-content/uploads/2024/06/d3b3571a-9779-4939-a3db-a349f5a63a62.jpg',
        title: 'Pet Travel',
        price: 200,
        category: 'travel'.tr(),
      ),
      ProductModel(
        imageUrl:
            // https://catsandtails.com.pk/wp-content/uploads/2023/08/1692635824_Pet20Carrying20Bag20Printed-600x600.jpg,
            'https://www.petindiaonline.com/story_images/248_dog%20apparel.jpg',
        title: 'Pet Cloth',
        price: 200,
        category: 'cloth'.tr(),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'shopping'.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 20,
                              color: colorScheme(context).onSurface,
                            ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed(AppRoute.cartPage),
                    child: SvgPicture.asset(AppIcons.cartIcon),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.setting);
                      },
                      child: SvgPicture.asset(
                        AppIcons.personIcon,
                        width: 19,
                        height: 19,
                      )),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => context.pushNamed(AppRoute.notificationPage),
                    child: SvgPicture.asset(AppIcons.notiIcon),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      searchTerms: [
                        'dogs'.tr(),
                        'cats'.tr(),
                        'birds'.tr(),
                        'fish'.tr(),
                      ],
                    ),
                  );
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(AppIcons.outlineSearch),
                    ),
                    readOnly: true,
                    hint: 'search_hint'.tr(),
                    borderColor: colorScheme(context).outline.withOpacity(0.4),
                    fillColor: colorScheme(context).surface,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SvgPicture.asset(AppIcons.filter),
                    ),
                    suffixConstraints: const BoxConstraints(minHeight: 20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 110),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(AppImages.petOffImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'categories'.tr(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 20, color: colorScheme(context).onSurface),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          // Filter the products based on the selected category
                          final filteredProducts = featuredProducts
                              .where((product) =>
                                  product.category == category.title)
                              .toList();

                          // Use PersistentNavBarNavigator to navigate to PetCategoriesPage with parameters
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: PetCategoriesPage(
                              category:
                                  category.title, // Pass the category title
                              products:
                                  filteredProducts, // Pass the filtered products list
                              searchController:
                                  TextEditingController(), // Pass a new search controller
                              sellerName: "", // Pass the seller name
                            ),
                            withNavBar:
                                true, // Ensure the bottom nav bar remains visible
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },

                        // onTap: () {
                        //   final filteredProducts = featuredProducts
                        //       .where((product) =>
                        //           product.category == category.title)
                        //       .toList();
                        //   context.pushNamed(
                        //     AppRoute.categoriesPage,
                        //     extra: {
                        //       'category': category.title,
                        //       'products': filteredProducts,
                        //       'searchController': TextEditingController(),
                        //     },
                        //   );
                        // },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.hintText,
                                ),
                                child: Image.asset(category.imagePath),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: colorScheme(context).onSurface,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'top_sellers'.tr(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 20, color: colorScheme(context).onSurface),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Combine GoRouter push with PersistentNavBarNavigator to navigate with parameters
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: TopSellersPage(),
                        withNavBar: true,
                        pageTransitionAnimation: PageTransitionAnimation.fade,
                      );
                    },
                    // onTap: () {
                    //   context.pushNamed(AppRoute.topSeller);
                    // },
                    child: Text(
                      'see_all'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.5),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topSellers.length,
                  itemBuilder: (context, index) {
                    final seller = topSellers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          final filteredProducts = featuredProducts
                              .where((product) => product.category == 'Housing')
                              .toList();

                          // Use PersistentNavBarNavigator to navigate to PetCategoriesPage with parameters
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: PetCategoriesPage(
                              category: 'Housing', // Pass the category title
                              products:
                                  filteredProducts, // Pass the filtered products list
                              searchController:
                                  TextEditingController(), // Pass a new search controller
                              sellerName: seller.name, // Pass the seller name
                            ),
                            withNavBar:
                                true, // Ensure the bottom nav bar remains visible
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade,
                          );
                        },

                        // onTap: () {
                        //   // Filter the products for this seller or category
                        //   final filteredProducts = featuredProducts
                        //       .where((product) => product.category == 'Housing')
                        //       .toList();

                        //   // Pass seller's name along with the category and products
                        //   context.pushNamed(
                        //     AppRoute.categoriesPage,
                        //     extra: {
                        //       'category': 'Housing', // Pass the category
                        //       'products':
                        //           filteredProducts, // Pass filtered products
                        //       'searchController':
                        //           TextEditingController(), // Pass search controller
                        //       'sellerName': seller.name, // Pass seller's name
                        //     },
                        //   );
                        // },
                        child: Container(
                          width: 170,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[300]!),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  seller.imageUrl,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  seller.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "featured_products".tr(),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 20, color: colorScheme(context).onSurface),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add logic for See All
                    },
                    child: Text(
                      'See All',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.5),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
                      log('${product.isFavorite}');
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
    );
  }
}
