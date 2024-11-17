// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/app_colors.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/features/settings/controller/settings_controller.dart';
import 'package:provider/provider.dart';
import '../../../common/utils/shared_preferences_helper.dart';
import '../../../common/widget/custom_search_delegate.dart';
import '../../../common/widget/custom_settings_tile.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../router/routes.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: false,
        title: Text("profile".tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        searchTerms: [
                          'account'.tr(),
                          'order_tracking'.tr(),
                          'notifications'.tr(),
                          'favourite_products'.tr(),
                          'language'.tr(),
                          'privacy_policy'.tr(),
                          'terms_conditions'.tr(),
                          'faqs'.tr(),
                          'about'.tr(),
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
                      borderColor:
                          colorScheme(context).outline.withOpacity(0.4),
                      fillColor: colorScheme(context).surface,
                    ),
                  ),
                ),
                CustomSettingsTile(
                  icon: SvgPicture.asset(AppIcons.personIcon),
                  title: "account".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.accountPage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: Image.asset(AppIcons.trackingIcon),
                  title: "order_tracking".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.orderTrackingPage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: SvgPicture.asset(AppIcons.notiIcon),
                  title: "notifications".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.notificationPage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: AppColor.hintText,
                  ),
                  title: "favourite_products".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.favoritePage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: const Icon(
                    Icons.other_houses,
                    color: AppColor.hintText,
                  ),
                  title: "my_order".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.myOrder);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                Consumer<SettingsController>(
                  builder: (context, value, child) => CustomSettingsTile(
                    icon: const Icon(
                      Icons.switch_account_outlined,
                      color: AppColor.hintText,
                    ),
                    title: value.isSeller
                        ? "switch_to_buyer_account".tr()
                        : "switch_to_seller_account".tr(),
                    onTap: () async {
                      await value.switchProfile(context);

                      final nextPage = value.isSeller
                          ? AppRoute.bussinessProfile
                          : AppRoute.navigationBar;
                      context.goNamed(nextPage);
                      // showSnackbar(
                      //   message: value.isSeller
                      //       ? "switch_to_buyer_account".tr()
                      //       : "switch_to_seller_account".tr(),
                      // );
                    },
                  ),
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: SvgPicture.asset(AppIcons.languageIcon),
                  title: "language".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.languagePage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: SvgPicture.asset(AppIcons.policyIcon),
                  title: "privacy_policy".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.privcyPolicy);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: Image.asset(
                    AppImages.iconDcoument,
                    height: 23,
                  ),
                  title: "terms_conditions".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.termsAndCondition);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: Image.asset(AppIcons.faqIcon),
                  title: "faqs".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.faqsPage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: SvgPicture.asset(AppIcons.aboutIcon),
                  title: "about".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.aboutPage);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
                CustomSettingsTile(
                  icon: const Icon(
                    Icons.list_alt_rounded,
                    color: AppColor.hintText,
                  ),
                  title: "order_history".tr(),
                  onTap: () {
                    context.pushNamed(AppRoute.orderHistory);
                  },
                ),
                Divider(color: AppColor.dividerColor, height: 0),
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            ListTile(
              onTap: () {
                SharedPrefHelper.saveBool(isLoggedInText, false);
                SharedPrefHelper.saveBool(isBuyerText, true);
                MyAppRouter.clearAndNavigate(context, AppRoute.welcomeScreen);
              },
              contentPadding: const EdgeInsets.all(0),
              leading: SvgPicture.asset(AppIcons.logoutIcon),
              title: Text(
                "logout".tr(),
                style: textTheme(context).titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
