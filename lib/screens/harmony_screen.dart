import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_application/classes/chord.dart';
import 'package:flutter_music_application/classes/chord_map.dart';
import 'package:flutter_music_application/classes/chord_progression.dart';
import 'package:flutter_music_application/managers/chord_display.dart';
import 'package:flutter_music_application/managers/harmony_manager.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/constants.dart';
//import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/classes/utilities.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/styles.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/screens/saves_screen.dart';
import 'package:flutter_music_application/screens/chord_charts_screen.dart';
import 'package:flutter_music_application/widgets/dropdown.dart';
import 'package:flutter_music_application/widgets/button.dart';

class HarmonyScreen extends StatefulWidget {
  final ChordMap chordMap;
  const HarmonyScreen({super.key, required this.chordMap});

  @override
  State<HarmonyScreen> createState() => _HarmonyScreenState();
}

class _HarmonyScreenState extends State<HarmonyScreen> with AutomaticKeepAliveClientMixin<HarmonyScreen> {
  @override
  bool get wantKeepAlive => true;

  late final HarmonyManager harmonyManager;
  ChordDisplay chordDisplay = ChordDisplay();

  bool _saved = false;
  bool _generated = false;
  bool _playing = false;


  late int _selectedKey;
  late List<int> _selectedChord;
  String _displayChordProgression = '';
  List<String> _chordProgression = [];
  late int _chordLimit;
  late int _lastChordLimit;

  bool _checkPlayStatus() => _generated;
  bool _checkSaveStatus() => _generated && !_saved;

  Future checkAsset(String path) async {
    try {
      return await rootBundle.loadString(path);
    } catch (_) {
      return null;
    }
  }

  void _viewSaves(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SavesScreen()));

  void _generateProgression() {
    debugPrint("_generateProgression function call");
    final int limit = _chordLimit;
    debugPrint("Selected Chord: $_selectedChord");

    if (_selectedChord.length <= 1 || _selectedChord[1] < 0) return;

    debugPrint("About to Clear Display");
    chordDisplay.clearDisplay();
    debugPrint("Display Cleared");

    final ChordData startingChord =
      harmonyManager.getChordDataObj(_selectedKey, _selectedChord[1]);

    debugPrint("Starting ChordData: $startingChord");

    final ChordProgression chordProgression =
      harmonyManager.generateChordProgression(startingChord, limit, chordDisplay);

    _chordProgression =
      chordProgression.chords.map((c) => c.chordName).toList();
    
    _displayChordProgression = _chordProgression.join(' | ');

    setState(() {
      _saved = false;
      _lastChordLimit = _chordLimit;
      _generated = true;
    });
  }

  Future<void> _playChordProgression() async {
    bool finished = false;
    Duration duration = const Duration(seconds: 0);
    setState(() => _playing = true);

    duration  = await audioPlayback.playAudio(_chordProgression);

    if (duration != const Duration(seconds: 0)) {
      finished = true;
      setState(() => _playing = !finished);
    }
  }

  void _stopPlayback() {
    audioPlayback.stopAudio();
    setState(() => _playing = false);
  }

  void _showChordSymbols(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChordChartsScreen(selectedKey: _selectedKey)));
  }

  void _saveChordProgression() {
    SavedChordProgression newSave = SavedChordProgression(_chordProgression);
    int key = 1;
    while (saves.containsKey(key)) { key++; }
    saves.put(key, newSave);
    setState(() => _saved = true);
  }

  @override
  void initState() {
    super.initState();
    harmonyManager = HarmonyManager(chordMap: widget.chordMap);
    chordDisplay.init();
    _selectedKey = 0;
    int j = 0;
    while (keyValues.getChords(_selectedKey)[j].enabled == false) {
      j++;
    }
    _selectedChord = keyValues.getChords(_selectedKey)[j].value;
    _chordLimit = Constants.minChordLimit;
    _lastChordLimit = Constants.minChordLimit;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = MediaQuery.of(context).size;
    double chordDisplayHeight = size.height / 4;

    return Center(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, -1),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: chordDisplayHeight,
                        decoration: BoxDecoration(
                          color: AppTheme.secondary10,
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          transitionBuilder: (Widget child,
                            Animation<double> animation) => ScaleTransition(
                              scale: animation,
                              child: child
                            ),
                            child: GridView.count(
                              mainAxisSpacing: 2.0,
                              crossAxisSpacing: 2.0,
                              crossAxisCount: Constants.chordsPerLine,
                              childAspectRatio: 1.75,
                              children: chordDisplay.getDisplay(),
                            ),
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: const Alignment(0.0, -0.8),
                    //   child: SimpleActionButton(
                    //     onPressed: () => _showChordSymbols(context),
                    //     color: AppTheme.primary80,
                    //     child: Text(
                    //       'View Chord Charts',
                    //       style: AppTextStyle.standard(color: AppTheme.primary10),
                    //     ),
                    //   )
                    // ),
                  ]
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.1),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text(
                    _displayChordProgression,
                    style: TextStyle(
                      fontSize: Utilities.calculateFontSize(_lastChordLimit),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: !_playing ? CustomMaterialButton(
                        onPressed: _checkPlayStatus() ? _playChordProgression : null,
                        child: Text(
                          'Play',
                          style: AppTextStyle.standard(color: _checkPlayStatus() ? AppTheme.secondary10 : AppTheme.surface),
                        ),
                      ) : CustomMaterialButton(
                        onPressed: _stopPlayback,
                        child: Text(
                          'Stop',
                          style: AppTextStyle.standard(color: AppTheme.secondary10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: !_saved ? CustomMaterialButton(
                        onPressed: _checkSaveStatus() ? _saveChordProgression : null,
                        child: Text(
                          'Save',
                          style: AppTextStyle.standard(color: _checkSaveStatus() ? AppTheme.secondary10 : AppTheme.surface),
                        ),
                      ) : SizedBox(
                        width: 110,
                        child: Text(
                          'Saved!',textAlign: TextAlign.center,
                          style: AppTextStyle.bold(color: Colors.black),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MusicDropdownMenu(
                      dropdownMenuEntries: keyValues.keys,
                      initialSelection: _selectedKey,
                      label: const Text('Starting Key'),
                      onSelected: (index) {
                        if (_selectedKey != index) {
                          setState(() {
                            _selectedKey = index;
                            final chords = keyValues.getChords(_selectedKey);
                            int j = chords.indexWhere((c) => c.enabled);
                            if (j == -1) {
                              debugPrint("No enabled chords in this key");
                              return;
                            }
                            
                            while (keyValues.getChords(_selectedKey)[j].enabled == false) {
                              j++;
                            }
                            _selectedChord = keyValues.getChords(_selectedKey)[j].value;
                          });
                        }
                      },
                    ),
                    NumberPicker(
                      value: _chordLimit,
                      minValue: Constants.minChordLimit,
                      maxValue: Constants.maxChordLimit,
                      onChanged: (value) => setState(() => _chordLimit = value),
                      textStyle: AppTextStyle.small(color: Colors.black),
                      selectedTextStyle: AppTextStyle.emphasised(color: Colors.black),
                      itemWidth: 40,
                    ),
                    MusicDropdownMenu(
                      dropdownMenuEntries: keyValues.getChords(_selectedKey),
                      initialSelection: _selectedChord,
                      label: const Text('Starting Chord'),
                      onSelected: (index) => setState(() { _selectedChord = index; }),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SimpleActionButton(
                        onPressed: _generateProgression,
                        color: AppTheme.primary10,
                        child: Text(
                          'Generate',
                          style: AppTextStyle.standard(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SimpleActionButton(
                        onPressed: () => _viewSaves(context),
                        color: AppTheme.primary80,
                        child: Text(
                          'View Saves',
                          style: AppTextStyle.standard(color: AppTheme.primary10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}