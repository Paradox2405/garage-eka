import 'package:flutter/material.dart';
import 'package:garage_eka/services_center/list.dart';
import 'package:garage_eka/user/assistant.dart';
import 'package:garage_eka/user/location.dart';
import 'package:garage_eka/user/service.dart';
import 'package:garage_eka/user/shoplist.dart';
import 'package:garage_eka/user/vehicle.dart';
import 'package:garage_eka/user/workshop.dart';
import 'package:garage_eka/user_home_screens/home_screen.dart';
import 'package:garage_eka/workshop/list.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0,);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
       popAllScreensOnTapAnyTabs: true,
      context,
      controller: _controller,
      screens: [
        UserHomeScreen(),
        Shop(),
        Location(),
        Service(),
        VirtualAssistant(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_filled),
          title: "Home",
          activeColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: "Spare Parts",
          activeColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.car_crash),
          title: "SOS",
          activeColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.build),
          title: "Service",
          activeColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.chat),
          title: "Chats",
          activeColorPrimary: Colors.grey,
        ),
      ],
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
