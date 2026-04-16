import 'package:flutter/material.dart';
import 'package:flutter_music_application/classes/chord_map.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/constants.dart';
import 'package:flutter_music_application/widgets/app_bar.dart';
import 'package:flutter_music_application/screens/harmony_screen.dart';

class HomeScreen extends StatefulWidget {
  final ChordMap chordMap;
  const HomeScreen({super.key, required this.chordMap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(title: Constants.appName),
      body: HarmonyScreen(chordMap: widget.chordMap),
      backgroundColor: AppTheme.surface,
    );
  }
}