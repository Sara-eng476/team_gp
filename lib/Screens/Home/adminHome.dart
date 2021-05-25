import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Admin/profile/settings.dart';
import 'package:team_gp/Screens/Admin/profile/showProfile.dart';
import 'package:team_gp/Screens/Notification/addReviewNoti.dart';
import '../Admin/dashboard.dart';
import '../../static.dart';

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
    AddReviewNotification(),
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
          items:<BubbleBottomBarItem> [
            BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(Icons.home, color: Colors.black,),
            activeIcon: Icon(Icons.home, color: Colors.red[600],),
            title: Text('Home'),
          ),
           BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(Icons.person, color: Colors.black,),
            activeIcon: Icon(Icons.person, color: Colors.red[600],),
            title: Text('Profile'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: Icon(Icons.settings, color: Colors.black,),
            activeIcon: Icon(Icons.settings, color: Colors.red[600],),
            title: Text('Setting'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red[600],
            icon: buildCustomBadge
            (
              counter: ValueOfNotificatio.countFav,
              child: Icon(Icons.notifications, color: Colors.black,)
              ),
            activeIcon: Icon(Icons.notifications, color: Colors.red[600],),
            title: Text('Notifications'),
          ),
          ],
        ));
  }
}

Widget buildCustomBadge({
  @required int counter,
  @required Widget child,
}) {
  final text = counter.toString();
  final deltaFontSize = (text.length - 1) * 3.0;

  return Stack(
    overflow: Overflow.visible,
    children: [
      child,
      Positioned(
        top: -6,
        right: -20,
        child: CircleAvatar(
          backgroundColor: Colors.red,
          radius: 10,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 17 - deltaFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}