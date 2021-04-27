import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Admin/profile/editProfile.dart';
import 'package:team_gp/Screens/Admin/profile/settings.dart';
import 'package:team_gp/Screens/Admin/profile/showProfile.dart';

import '../Admin/dashboard.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key key}) : super(key: key);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  PageController _pageController = PageController();
  List<Widget> _screens = [
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? Colors.blue : Colors.grey[850],
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey[850],
                  fontSize: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _selectedIndex == 1 ? Colors.blue : Colors.grey[850],
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  color: _selectedIndex == 1 ? Colors.blue : Colors.grey[850],
                  fontSize: 20,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: _selectedIndex == 2 ? Colors.blue : Colors.grey[850],
              ),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: _selectedIndex == 2 ? Colors.blue : Colors.grey[850],
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ));
  }
}
