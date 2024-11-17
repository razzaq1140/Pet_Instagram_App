import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../common/constants/global_variables.dart';
import '../../../common/utils/custom_snackbar.dart';

class CartItem {
  final String name;
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  PaymentCheckOutScreenState createState() => PaymentCheckOutScreenState();
}

class PaymentCheckOutScreenState extends State<CartPage> {
  final List<CartItem> cartItems = [
    CartItem(
      name: 'Pet House',
      imageUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      price: 150,
    ),
    CartItem(
      name: 'Pet House',
      imageUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      price: 150,
    ),
    CartItem(
      name: 'Pet House',
      imageUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      price: 150,
    ),
    CartItem(
      name: 'Pet House',
      imageUrl:
          'https://as2.ftcdn.net/v2/jpg/05/78/79/17/1000_F_578791746_yleX4RjodpO0cIfhTAHI6KlgWq1Szows.jpg',
      price: 150,
    ),
  ];

  final List<String> addresses = [
    "California Street #3 Apt #4 #4451",
    "Bay Area Avenue #10 Apt #7 #1121",
    "Central Park West #5 Apt #9 #2233"
  ];

  String selectedAddress = "California Street #3 Apt #4 #4451";
  bool isExpanded = false;

  void _incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      setState(() {
        cartItems[index].quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'cart'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(
            AppIcons.cartIcon,
            color: colorScheme(context).primary,
          ),
          const SizedBox(width: 15),
          GestureDetector(
              onTap: () => context.pushNamed(AppRoute.notificationPage),
              child: SvgPicture.asset(AppIcons.notiIcon)),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: colorScheme(context).onPrimary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.4)),
              ),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme(context).onPrimary,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withOpacity(0.4)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.imageUrl,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.price}\$',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary, // Counter background color
                                  borderRadius: BorderRadius.circular(
                                      24), // Rounded counter container
                                ),
                                child: Row(children: [
                                  // Decrement Button
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove,
                                      color: colorScheme(context).onSecondary,
                                      //  Colors
                                      //     .white, // Icon color inside counter
                                      size: 16, // Icon size
                                    ),
                                    onPressed: () => _decrementQuantity(index),
                                  ),

                                  // Quantity Display
                                  Text(
                                    item.quantity.toString().padLeft(2, '0'),
                                    style: TextStyle(
                                      color: colorScheme(context).onSecondary,
                                      // Quantity text color
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // Increment Button
                                  IconButton(
                                    icon: Icon(
                                      Icons.add,
                                      color: colorScheme(context).onSecondary,
                                      // Icon color inside counter
                                      size: 16, // Icon size
                                    ),
                                    onPressed: () => _incrementQuantity(index),
                                  )
                                ]))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "select_shipping_address".tr(),
                  style: textTheme(context).titleMedium,
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoute.addressPage);
                    },
                    child: Text(
                      "add_new".tr(),
                      style: textTheme(context).titleSmall?.copyWith(
                          color: colorScheme(context).primary,
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedAddress,
                          style: textTheme(context).titleSmall?.copyWith(
                                color: AppColor.hintText,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                        ),
                        Icon(
                          isExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: colorScheme(context).primary,
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded)
                    Column(
                      children: addresses.map((address) {
                        return RadioListTile<String>(
                          value: address,
                          groupValue: selectedAddress,
                          title: Text(
                            address,
                            style: textTheme(context)
                                .bodyMedium
                                ?.copyWith(color: AppColor.hintText),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              selectedAddress = value!;
                              isExpanded = false; // Collapse on selection
                            });
                          },
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              hint: 'enter_promo_code'.tr(),
              filled: true,
              borderColor: colorScheme(context).outline.withOpacity(0.2),
              fillColor: colorScheme(context).onPrimary,
              focusBorderColor: colorScheme(context).surface,
              keyboardType: TextInputType.number,
              suffixConstraints:
                  const BoxConstraints(maxHeight: 40, maxWidth: 120),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CustomButton(
                  onTap: () {
                    showSnackbar(
                      message:'Promo code applied successfully!',
                      backgroundColor: AppColor.appGreen,
                      label: 'UNDO',
                      
                    );
                  
                  },
                  text: 'apply'.tr(),
                  textSize: 14,
                  borderRadius: 8,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.2)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'payment'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'subtotal'.tr(),
                        style: const TextStyle(
                          color: AppColor.hintText,
                        ),
                      ),
                      const Text(
                        '250\$',
                        style: TextStyle(
                          color: AppColor.hintText,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColor.dividerColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'discount'.tr(),
                        style: const TextStyle(
                          color: AppColor.hintText,
                        ),
                      ),
                      const Text(
                        '35\$',
                        style: TextStyle(
                          color: AppColor.hintText,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColor.dividerColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'shipping'.tr(),
                        style: const TextStyle(
                          color: AppColor.hintText,
                        ),
                      ),
                      const Text(
                        '25\$',
                        style: TextStyle(
                          color: AppColor.hintText,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColor.dividerColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'total'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Text('450\$'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
                onTap: () {
                  context.pushNamed(AppRoute.paymentDetail);
                },
                text: 'check_out'.tr())
          ],
        ),
      ),
    );
  }
}
