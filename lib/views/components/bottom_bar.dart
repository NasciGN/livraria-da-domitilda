import 'package:flutter/material.dart';
import 'constants.dart';

class MyBottomNavigatorBar extends StatefulWidget {
  MyBottomNavigatorBar({super.key});

  @override
  State<MyBottomNavigatorBar> createState() => _MyBottomNavigatorBar();
}

class _MyBottomNavigatorBar extends State<MyBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    void _onTabTapped(int index) {
      setState(() {
        currentIndex = index;
        print("Index: $currentIndex");
      });
    }

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
                color: bgColor,
              )),
          BottomNavigationBarItem(
            label: "Swap",
            icon: Icon(
              Icons.swap_horizontal_circle,
              color: bgColor,
            ),
          ),
          BottomNavigationBarItem(
            label: "My Library",
            icon: Icon(
              Icons.bookmarks,
              color: bgColor,
            ),
          ),
        ]);
  }
}
