import 'package:evently/tabs/home/home_tab.dart';
import 'package:evently/tabs/love/love_tab.dart';
import 'package:evently/tabs/map/map_tab.dart';
import 'package:evently/tabs/profile/profile_tab.dart';
import 'package:evently/widges/nav_bar_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    LoveTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: NavBarItem(imageName: 'unActiveHome'),
                activeIcon: NavBarItem(imageName: 'unActiveHome'),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: NavBarItem(imageName: 'unactiveMap'),
                activeIcon: NavBarItem(imageName: 'activeMap'),
                label: 'Map'),
            BottomNavigationBarItem(
                icon: NavBarItem(imageName: 'unactiveLove'),
                activeIcon: NavBarItem(imageName: 'activeLove'),
                label: 'Love'),
            BottomNavigationBarItem(
                icon: NavBarItem(imageName: 'unActiveUser'),
                activeIcon: NavBarItem(imageName: 'ActiveUser'),
                label: 'Profile'),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
