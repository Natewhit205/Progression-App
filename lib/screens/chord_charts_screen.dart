import 'package:flutter/material.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/widgets/app_bar.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/widgets/chart_row.dart';

class ChordChartsScreen extends StatefulWidget {
  final int selectedKey;
  const ChordChartsScreen({super.key, required this.selectedKey});

  @override
  ChordChartsScreenState createState() => ChordChartsScreenState();
}

class ChordChartsScreenState extends State<ChordChartsScreen> {
  late String keySignature;
  late String tonality;

  List<Widget> _getCharts() {
    List<Widget> output = [];
    for (int i = 1; i <= 7; i++) {
      String chord = keyValues.chords[widget.selectedKey - 1][i - 1].label;
      if (keySignature.endsWith('m')) {
        tonality = 'minor';
      } else {
        tonality = 'major';
      }
      output.add(ChartRow(keySignature: keySignature, tonality: tonality, chord: chord, interval: i));
    }
    return output;
  }

  @override
  void initState() {
    super.initState();
    keySignature = keyValues.chords[widget.selectedKey - 1].first.label;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(title: 'Chord Charts'),
      body: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnStart: 0.3,
        gradientFractionOnEnd: 0.3,
        child: ListView(
          controller: ScrollController(),
          children: _getCharts(),
        ),
      ),
      backgroundColor: AppTheme.surface,
    );
  }
}