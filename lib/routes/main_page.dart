import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:projectuas/pages/home.dart';
import 'package:projectuas/pages/profile.dart';
import 'package:projectuas/pages/qr_scanner.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _selectedNavbar = 0;

  void _changeSelectedNavbar(int idx) {
    setState(() {
      _selectedNavbar = idx;
    });
  }

  final List<Widget> page = [
    HomeScreen(),
    QRScannerScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.scan),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.profile),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedNavbar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kGreyColor1,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavbar,
      ),
    );
  }
}
