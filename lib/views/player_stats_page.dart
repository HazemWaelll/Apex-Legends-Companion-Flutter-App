import 'package:flutter/material.dart';

class PlayerStats extends StatefulWidget {
  const PlayerStats({super.key});

  @override
  State<PlayerStats> createState() => _PlayerStatsState();
}

class _PlayerStatsState extends State<PlayerStats> {
  final TextEditingController usernameController = TextEditingController();

  String? selectedPlatform;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10),

            // username textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: usernameController,
                autofocus: false,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  hintText: "In game username",
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),

            SizedBox(height: 20),

            // platform dropdown list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(14),
                child: DropdownMenu(
                  width: MediaQuery.sizeOf(context).width,
                  hintText: "Choose platform",
                  inputDecorationTheme: InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  textStyle: TextStyle(color: Colors.black),
                  menuStyle: MenuStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  dropdownMenuEntries: [
                    // pc
                    DropdownMenuEntry(
                      value: "PC",
                      label: "PC                       ",
                    ),

                    // ps
                    DropdownMenuEntry(
                      value: "PS4",
                      label: "PS4/5",
                      //
                    ),

                    // xbox
                    DropdownMenuEntry(
                      value: "X1",
                      label: "Xbox",
                      //
                    ),
                  ],

                  onSelected: (value) {
                    setState(() {
                      selectedPlatform = value;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: 60),

            // get player stats button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "Get Player Stats",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
