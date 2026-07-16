import 'package:flutter/material.dart';
import 'package:apex_companion/pages/home_page.dart';
import 'package:apex_companion/pages/settings_page.dart';
import 'package:apex_companion/pages/profile_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List pages = [HomePage(), SettingsPage(), ProfilePage()];

  int selectedIndex = 0;

  void _onitemtapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 14),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset("assets/app-logo/apex-legends-logo.png"),
            ),
            title: Text(
              "Apex Companion",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      backgroundColor: Colors.grey.shade900,

      body: pages[selectedIndex],

      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.all(30),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(46),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: _onitemtapped,
              backgroundColor: Colors.grey.shade800,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.redAccent,

              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                  //
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings",
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
