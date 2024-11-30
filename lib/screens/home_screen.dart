import 'package:flutter/material.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/screens/bpm_screen.dart';
import 'package:flutter_music_application/screens/tuner_screen.dart';
import 'package:flutter_music_application/screens/harmony_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  // Page Controller
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  
  final List<Widget> _pages = [
    const BpmScreen(),
    const HarmonyScreen(),
    const TunerScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.timer),
      label: 'BPM Clicker',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.audiotrack_outlined),
      label: 'Tuner',
    ),
  ];

  void onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.animateToPage(
      index, 
      duration: const Duration(milliseconds: 750),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Music App Name'),
        backgroundColor: AppTheme.primary,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primaryAccent,
        currentIndex: _selectedIndex,
        onTap: onTapHandler,
        items: _bottomNavigationBarItems,
      ),
    );
  }
}