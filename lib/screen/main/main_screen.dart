import 'package:flutter/material.dart';
import 'package:food_express/generated/assets.dart';
import 'package:food_express/models/bottom_navigation_model.dart';
import 'package:food_express/screen/main/cart/cart_screen.dart';
import 'package:food_express/screen/main/home/home_screen.dart';
import 'package:food_express/screen/main/map/map_screen.dart';
import 'package:food_express/screen/main/profile/profile_screen.dart';
import 'package:food_express/utils/utils.dart';

import '../../utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var currentPage = 0;
  var screenList = [
    HomeScreen(),
    MapScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: backgroundGradiet()),
      child: Scaffold(
        backgroundColor: AppColors.TRANSPARENT,
        appBar: AppBar(
          backgroundColor: AppColors.TRANSPARENT,
          elevation: 0,
          title: Image.asset(
            Assets.imagesLogo,
            width: 120,
            height: 40,
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Image.asset(
              Assets.imagesMenu,
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          ),
          leadingWidth: 52,
          actions: [
            InkWell(
              child: Image.asset(
                Assets.imagesProfile,
                color: Colors.white,
                width: 22,
                height: 22,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: screenList[currentPage],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColors.TRANSPARENT,
            elevation: 0,
            iconSize: 24,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme: IconThemeData(color: AppColors.ICON_COLOR),
            selectedItemColor: AppColors.ICON_COLOR,
            selectedLabelStyle: TextStyle(color: AppColors.ICON_COLOR),
            unselectedIconTheme: IconThemeData(color: AppColors.TEXTFILED_COLOR2),
            unselectedItemColor: AppColors.TEXTFILED_COLOR2,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            currentIndex: currentPage,
            items: [
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage(Assets.imagesHome),
                  ),
                  label: "Main",
                  backgroundColor: AppColors.TRANSPARENT),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage(Assets.imagesMap),
                  ),
                  label: "Map",
                  backgroundColor: AppColors.TRANSPARENT),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage(Assets.imagesCart),
                  ),
                  label: "Cart",
                  backgroundColor: AppColors.TRANSPARENT),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage(Assets.imagesProfile,),
                  ),
                  label: "Profile",
                  backgroundColor: AppColors.TRANSPARENT),
            ]),
      ),
    );
  }
}
