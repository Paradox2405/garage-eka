import 'package:flutter/material.dart';
import 'package:garage_eka/services_center/appointments.dart';
import 'package:garage_eka/services_center/list.dart';
import 'package:garage_eka/shop/add.dart';
import 'package:garage_eka/shop/list.dart';
import 'package:garage_eka/user/assistant.dart';
import 'package:garage_eka/user/service.dart';
import 'package:garage_eka/user/vehicle.dart';
import 'package:garage_eka/user/workshop.dart';
import 'package:garage_eka/workshop/add.dart';
import 'package:garage_eka/workshop/list.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AdminNav extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<AdminNav> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        Workshop(),
        ServiceList(),
        Appointments(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.build),
          title: "Workshop",
          activeColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.car_repair),
          title: "Service Centers",
          activeColorPrimary: Colors.grey,
        ),
    PersistentBottomNavBarItem(
    icon: Icon(Icons.list_alt),
    title: "Appointments",
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
