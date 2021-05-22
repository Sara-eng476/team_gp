import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Admin/category/view.dart';
import 'package:team_gp/Screens/Admin/product/view.dart';
import 'package:team_gp/Screens/Admin/profile/editProfile.dart';
import 'package:team_gp/Screens/Admin/profile/settings.dart';
import 'package:team_gp/Screens/Admin/profile/showProfile.dart';

import '../Admin/dashboard.dart';

class ProductHome extends StatefulWidget {
  ProductHome({Key key}) : super(key: key);
  @override
  _ProductHomeState createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
    ViewProduct(),
    Dashboard(),
    ShowProfile(),
    SettingsPage(),
  ];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        currentIndex: _selectedIndex,
        hasInk: true,
        inkColor: Colors.black12,
        hasNotch: true,
       // fabLocation: BubbleBottomBarFabLocation.end,
        onTap: _onItemTapped,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(
              Icons.view_list_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.view_list_outlined,
              color: Colors.red[600],
            ),
            title: Text('Product'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.red[600],
            ),
            title: Text('Home'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person,
              color: Colors.red[600],
            ),
            title: Text('Profile'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.red[600],
            ),
            title: Text('Setting'),
          )
        ],
      ),);
  }
}