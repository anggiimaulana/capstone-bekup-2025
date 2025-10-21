import 'package:capstone/screen/home/home_screen.dart';
import 'package:capstone/screen/favorite/favorite_page.dart';
import 'package:capstone/screen/setting/setting_screen.dart';
import 'package:capstone/style/colors.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  String? userName;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeScreen(),
      const FavoritePage(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5FF),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.navy,
          // borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          unselectedItemColor: Colors.white60,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 22),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 22),
              label: "Favorit",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 22),
              label: "Pengaturan",
            ),
          ],
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}
