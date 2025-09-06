import 'package:flutter/material.dart';
import 'package:infosphere/view/discover_screen.dart';
import 'package:infosphere/view/home_screen.dart';
import 'package:infosphere/view/saved_screen.dart';
import 'package:infosphere/view/profile_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currIndx = 0;

  List<Widget> pages = [
    HomeScreen(),
    DiscoverScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(currIndx),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              currentIndex: currIndx,
              selectedItemColor: Colors.blue[700],
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              onTap: (value) {
                setState(() {
                  currIndx = value;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.home),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.explore),
                  ),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_border),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.bookmark),
                  ),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.person),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
