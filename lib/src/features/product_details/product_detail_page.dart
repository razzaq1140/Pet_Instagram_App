
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/utils/custom_snackbar.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLiked = false;
  double value = 0.0;
  int quantity = 1;
  bool isSeller = false; // To store whether the user is in Seller mode or not
  final PageController _pageController = PageController();
  int activeIndex = 0;
  final List<String> imageUrls = [
    "https://www.animalbehaviorcollege.com/wp-content/uploads/2015/03/siberian-husky.jpg",
    "https://i0.wp.com/www.adirondacklife.com/wp-content/uploads/2022/02/shutterstock_469403591-scaled.jpg?resize=1536%2C1061&ssl=1",
    "https://dogtime.com/wp-content/uploads/sites/12/2023/11/GettyImages-1454565264-e1701120522406.jpg?w=1024",
    "https://puccicafe.com/wp-content/uploads/2022/12/Siberian-Husky-PUCCI-Cafe-1536x1024.jpg"
  ];

  @override
  void initState() {
    super.initState();
    _loadUserMode();
  }

  // Function to load user mode (buyer/seller) from SharedPreferences
  Future<void> _loadUserMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSeller = prefs.getBool('isSeller') ?? false; // Default to buyer mode
    });
  }

  void showCustomDialog(BuildContext context, double initialValue,
      Function(double) onRatingChanged) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double tempValue = initialValue;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              backgroundColor: colorScheme(context).onPrimary,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onRatingChanged(0.0); // Reset the rating to 0
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Icon(
                        Icons.cancel,
                        color: colorScheme(context).error,
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: 8,
                      contentPadding: const EdgeInsets.all(0),
                      leading: CircleAvatar(
                        radius: 25,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 25,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) => CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[200],
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                      title: Text(
                        "Eleanor Park",
                        style: textTheme(context)
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Nov 7,2023",
                        style: textTheme(context).labelSmall?.copyWith(
                            color:
                                colorScheme(context).outline.withOpacity(0.7),
                            fontSize: 10),
                      ),
                      trailing: RatingStars(
                        value: tempValue,
                        onValueChanged: (v) {
                          setState(() {
                            tempValue = v; // Update the temporary local state
                          });
                        },
                        starCount: 5,
                        starSize: 20,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        valueLabelRadius: 10,
                        maxValue: 5.0,
                        starSpacing: 2,
                        maxValueVisibility: false,
                        valueLabelVisibility: false,
                        animationDuration: const Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: AppColor.appYellow,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      hint: "add_review_hint".tr(),
                      maxline: 5,
                      filled: true,
                      fillColor: colorScheme(context).surface,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        onTap: () {
                          if (tempValue == 0) {
                            showSnackbar(
                                message: "Please provide a rating.",
                                isError: true);
                          } else {
                            onRatingChanged(tempValue);
                            Navigator.of(context).pop();
                          }
                        },
                        text: "submit".tr()),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            // Image section
            SizedBox(
              height: height * 0.6,
              child: Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _pageController,
                    itemCount: imageUrls.length, // Display the image 4 times
                    onPageChanged: (index) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: imageUrls[index],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: colorScheme(context).outlineVariant,
                          highlightColor: colorScheme(context).outlineVariant,
                          child: Container(
                            color: colorScheme(context).surface,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    },
                  ),
                  Positioned(
                    top: height * 0.05,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colorScheme(context)
                                  .primary
                                  .withOpacity(0.4)),
                          child: Icon(
                            Icons.favorite,
                            color: isLiked == true
                                ? Theme.of(context).colorScheme.error
                                : colorScheme(context).onPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Custom vertical indicator
                  Positioned(
                    right: 20, // Position the indicator to the right
                    top: height * 0.22, // Adjust to position vertically
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: colorScheme(context).onPrimary,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: colorScheme(context)
                                        .outline
                                        .withOpacity(0.4)),
                                color: activeIndex == index
                                    ? colorScheme(context)
                                        .primary // Active indicator color
                                    : colorScheme(context)
                                        .onPrimary, // Inactive indicator color
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Details section
            Positioned(
              top: height * 0.59,
              left: 16,
              right: 16,
              child: Container(
                width: width,
                height: height * 0.4,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: colorScheme(context).onPrimary,
                    border: Border.all(color: colorScheme(context).outline)),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              "Pet House",
                              style: textTheme(context)
                                  .headlineMedium
                                  ?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                          // Conditionally showing widgets based on buyer/seller mode
                          if (!isSeller)
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index < value
                                            ? Icons.star
                                            : Icons.star_outline,
                                        size: 20,
                                        color: index < value
                                            ? AppColor.appYellow
                                            : colorScheme(context)
                                                .outline
                                                .withOpacity(0.7),
                                      );
                                    }),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showCustomDialog(context, value,
                                        (newValue) {
                                      setState(() {
                                        value = newValue;
                                      });
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.hintText),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        color: colorScheme(context).onPrimary),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 3),
                                    child: Text(
                                      "add_review".tr(),
                                      style: textTheme(context).labelLarge,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      // if (isSeller)
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 30,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) => CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[200],
                                  child: const CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[200],
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Brok Simmons",
                                  style: textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(letterSpacing: 0),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(
                                              Radius.circular(25)),
                                      color: colorScheme(context).primary),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 3),
                                  child: Text(
                                    "top_sellers".tr(),
                                    style: textTheme(context)
                                        .labelLarge
                                        ?.copyWith(
                                            color: colorScheme(context)
                                                .onPrimary),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (!isSeller)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            "description".tr(),
                            style: textTheme(context).titleSmall,
                          ),
                        ),
                      Text(
                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a. took a galley of type and scrambled it to make a.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a.",
                        style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).outline.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Only show "Add to Cart" for buyers
                      if (!isSeller)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: colorScheme(context).primary,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "150\$",
                                style: textTheme(context)
                                    .headlineSmall
                                    ?.copyWith(
                                        color: colorScheme(context).onPrimary),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  color: colorScheme(context).onPrimary,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (quantity > 1) {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        quantity.toString().padLeft(2, '0'),
                                        style: textTheme(context).bodyLarge,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed(AppRoute.cartPage);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: colorScheme(context).onPrimary,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text("add_to_cart".tr(),
                                            style:
                                                textTheme(context).bodyLarge),
                                      ),
                                      const Icon(Icons.shopping_cart_outlined)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: height * 0.55,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoute.ratingPage);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        color: colorScheme(context).onPrimary,
                        border:
                            Border.all(color: colorScheme(context).outline)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "4.8",
                          style: textTheme(context)
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.star,
                            color: AppColor.appYellow,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 25,
                          decoration:
                              BoxDecoration(color: AppColor.dividerColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "ratings".tr(),
                          style: textTheme(context)
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const Icon(
                          Icons.arrow_right,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
