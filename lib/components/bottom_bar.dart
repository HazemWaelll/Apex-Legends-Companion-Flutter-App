import 'package:flutter/material.dart';
import 'package:apex_companion/views/home_page.dart';
import 'package:apex_companion/views/leaderboard_page.dart';
import 'package:apex_companion/views/player_stats_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> pages = [Home(), Leaderboard(), PlayerStats()];

  int selectedIndex = 0;

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
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 70),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(46),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.grey.shade800),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                onTap: (index) => setState(() {
                  selectedIndex = index;
                }),
                backgroundColor: Colors.grey.shade800,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.redAccent,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.view_column),
                    label: "Leaderboard",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Player Stats",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
