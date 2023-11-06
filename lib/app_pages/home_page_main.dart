import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:petlink_flutter_app/app_pages/account_page_main.dart';
import 'package:petlink_flutter_app/app_pages/pets_page_main.dart';
import 'package:petlink_flutter_app/app_pages/user_home_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.fullName});

  final String fullName;

  @override
  State<MyHomePage> createState() => _MyHomePageState(fullName);
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 1;

  final String fullName;

  _MyHomePageState(this.fullName);

  void _navigateBottomBar(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      const PetsPage(),
      UserHomePage(fullName: fullName),
      const AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 25, 44),
      body: _pages[selectedPage],
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.pets,
              backgroundColor: Colors.white,
              extras: {"label": "pets"}),
          FluidNavBarIcon(
              icon: Icons.home,
              backgroundColor: Colors.white,
              extras: {"label": "home"}),
          FluidNavBarIcon(
              icon: Icons.person,
              backgroundColor: Colors.white,
              extras: {"label": "account"}),
        ],
        onChange: (index) => _navigateBottomBar(index),
        style: const FluidNavBarStyle(
            iconUnselectedForegroundColor: Color.fromARGB(255, 3, 25, 44),
            iconSelectedForegroundColor: Color.fromARGB(255, 3, 25, 44)),
        scaleFactor: 1.5,
        defaultIndex: 1,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }
}
