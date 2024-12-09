import 'package:flutter/material.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/widgets/chart_row.dart';

class ChordChartsScreen extends StatefulWidget {
  const ChordChartsScreen({super.key, selectedKey});

  @override
  ChordChartsScreenState createState() {
    return ChordChartsScreenState();
  }
}

class ChordChartsScreenState extends State<ChordChartsScreen> {

  List<Widget> _getCharts() {
    List<Widget> output = [];
    for (int i = 1; i <= 7; i++) {
      output.add(ChartRow(interval: i));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Music App Name'),
        backgroundColor: AppTheme.primary,
      ),
      body: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnStart: 0.3,
        gradientFractionOnEnd: 0.3,
        child: ListView(
          controller: ScrollController(),
          children: _getCharts(),
        ),
      ),
    );
  }
}