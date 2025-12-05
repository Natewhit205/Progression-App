import 'package:flutter/material.dart';

class ChordMapScreen extends StatelessWidget {
  const ChordMapScreen({ super.key });

  List<Widget> _getChordMaps() {
    List<Widget> chordMaps = [];
    return chordMaps;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getChordMaps(),
    );
  }
}