import 'package:flutter/material.dart';
import 'package:flutter_music_application/classes/chord_map.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/constants.dart';
import 'package:flutter_music_application/widgets/app_bar.dart';
import 'package:flutter_music_application/screens/bpm_screen.dart';
import 'package:flutter_music_application/screens/tuner_screen.dart';
import 'package:flutter_music_application/screens/harmony_screen.dart';

class HomeScreen extends StatefulWidget {
  final ChordMap chordMap;
  const HomeScreen({super.key, required this.chordMap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Page Controller
  int _selectedIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  
  late final List<Widget> _pages;

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Maps',
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
    setState(() => _selectedIndex = index);

    _pageController.animateToPage(
      index, 
      duration: const Duration(milliseconds: 750),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      const BpmScreen(),
      HarmonyScreen(chordMap: widget.chordMap),
      const TunerScreen(),
    ];
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(title: Constants.appName),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _pages,
      ),
      backgroundColor: AppTheme.surface,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppTheme.primary40,
        currentIndex: _selectedIndex,
        onTap: onTapHandler,
        items: _bottomNavigationBarItems,
      ),
    );
  }
}