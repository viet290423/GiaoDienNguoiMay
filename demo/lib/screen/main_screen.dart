import 'package:demo/screen/account_screen.dart';
import 'package:demo/screen/add_screen.dart';
import 'package:demo/screen/chat_screen.dart';
import 'package:demo/screen/home_screen.dart';
import 'package:demo/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final screens = [
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    ChatScreen(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              selectedIndex: _currentIndex,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.black,
              tabBackgroundColor: Colors.white,
              gap: 5,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                GButton(
                  icon: Icons.add,
                  text: 'Add',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                GButton(
                  icon: Icons.message,
                  text: 'Chat',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Account',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ],
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
