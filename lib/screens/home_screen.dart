import 'package:flutter/material.dart';
import 'bpm_screen.dart';
import 'tuner_screen.dart';
import 'harmony_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
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

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.timer),
      label: 'BPM Clicker',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
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
  void initState() {
    super.initState();
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
        title: const Text(
          'Music App Name',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 85, 124),
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
        selectedItemColor: const Color.fromARGB(255, 42, 85, 124),
        currentIndex: _selectedIndex,
        onTap: onTapHandler,
        items: _bottomNavigationBarItems,
      ),
    );
  }
}