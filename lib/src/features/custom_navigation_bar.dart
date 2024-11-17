 
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/features/individual_chat/pages/chat_page.dart';
import 'package:pet_project/src/features/profile/pages/my_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants/app_images.dart';
import 'buyer_and_seller/buyer/pages/shopping_page.dart';
import 'buyer_and_seller/seller/pages/seller_center_page.dart';
import 'feed_and_recipe/feed/feed_page.dart';
import 'home/pages/home_page.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  CustomBottomNavigationBarState createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late PersistentTabController _controller;
  int _currentIndex = 0;
  bool isSeller = false; // Initialize with a default value

  final List<Widget> _buyerPages = [
    const HomePage(),
    const FeedPage(),
    const ChatPage(),
    const PetShoppingPage(),
    const MyProfilePage(),
  ];

  final List<Widget> _sellerPages = [
    const HomePage(),
    const FeedPage(),
    const ChatPage(),
    const SellerCenterPage(),
    const MyProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _loadUserType();
  }

  Future<void> _loadUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isSeller = prefs.getBool('isSeller') ?? false;
    });
  }

  List<PersistentBottomNavBarItem> _buildNavBarItems() {
    return [
      _createNavBarItem(AppIcons.homeIcon, "",0),
      _createNavBarItem(AppIcons.petFoodIcon, "",1),
      _createNavBarItem(AppIcons.bunnyIcon, "",2),
      _createNavBarItem(
        isSeller ? AppIcons.petShopIcon : AppIcons.petShopIcon,
        isSeller ? "" : "",3
      ),
      _createNavBarItem(AppIcons.profileIcon, "",4),
    ];
  }

  PersistentBottomNavBarItem _createNavBarItem(String iconPath, String title,int index) {
    return PersistentBottomNavBarItem(
      icon: CircleAvatar(
        // if selected
        backgroundColor: _currentIndex == index
         ?colorScheme(context).primary
         :Colors.transparent,
        // if not selected
        // backgroundColor: Colors.transparent
        child: Image.asset(iconPath, height: 35)),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    );
  }

  List<Widget> _buildScreens() {
    return isSeller ? _sellerPages : _buyerPages;
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _buildNavBarItems(),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.simple, // Customize as needed
      onItemSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
