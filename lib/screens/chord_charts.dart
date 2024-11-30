import 'package:flutter/material.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/styles.dart';
import 'package:flutter_music_application/widgets/button.dart';

class ChordChartsScreen extends StatefulWidget {
  const ChordChartsScreen({super.key, selectedKey});

  @override
  ChordChartsScreenState createState() {
    return ChordChartsScreenState();
  }
}

class ChordChartsScreenState extends State<ChordChartsScreen> {

  String _getDisplayString(SavedChordProgression chordProgression) => chordProgression.chordProgression.join(' | ');

  double _calculateFontSize(int length) {
    double output;
    double minFont = 15;
    double maxFont = 18;
    int lowerBound = 8;
    int upperBound = 32;

    if (length <= 8) {
      output = maxFont;
    } else {
      output = maxFont - (length - lowerBound) * (maxFont - minFont) / (upperBound - lowerBound);
    }
    return output;
  }
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'I',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'ii',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'iii',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'IV',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'V',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'vi',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    'vii°',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold(context, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}