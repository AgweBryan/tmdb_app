import 'package:flutter/material.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          pageIndex = index;
        }),
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: buttonColor,
        unselectedItemColor: Colors.white,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search'),
          BottomNavigationBarItem(icon: CustomIcon(), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                size: 30,
              ),
              label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile'),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
