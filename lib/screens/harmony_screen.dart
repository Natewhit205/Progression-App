import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/styles.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/screens/saves_screen.dart';
import 'package:flutter_music_application/screens/chord_charts_screen.dart';
import 'package:flutter_music_application/widgets/dropdown.dart';
import 'package:flutter_music_application/widgets/button.dart';

class HarmonyScreen extends StatefulWidget {
  const HarmonyScreen({super.key});

  @override
  HarmonyScreenState createState() => HarmonyScreenState();
}

class HarmonyScreenState extends State<HarmonyScreen> with AutomaticKeepAliveClientMixin<HarmonyScreen> {
  @override
  bool get wantKeepAlive => true;

  bool _saved = false;
  bool _generated = false;
  bool _playing = false;

  String _image = '';

  final double _minFont = 16;
  final double _maxFont = 30;
  final int _minLimit = 4;
  final int _maxLimit = 32;

  late int _selectedKey;
  late List<int> _selectedChord;
  String _displayChordProgression = '';
  List<String> _chordProgression = [];
  late int _chordLimit;
  late int _lastChordLimit;

  double _calculateFontSize() => _maxFont - (_lastChordLimit - _minLimit) * (_maxFont - _minFont) / (_maxLimit - _minLimit);
  bool _checkPlayStatus() => _generated;
  bool _checkSaveStatus() => _generated && !_saved;

  String _getImage() => 'assets/chord_imgs/${keyValues.chords[_selectedKey - 1].first.label}/${_selectedChord[1]}.png';

  void _viewSaves(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SavesScreen()));

  void _generateProgression() {
    _saved = false;
    _lastChordLimit = _chordLimit;
    _displayChordProgression = '';
    _chordProgression = [];
    int limit = _chordLimit;
    int currentKey = _selectedKey;
    int currentChordId = _selectedChord[1];

    _displayChordProgression += keyValues.getChords(_selectedKey)[currentChordId - 1].label;
    _chordProgression.add(keyValues.getChords(_selectedKey)[currentChordId - 1].label);
    limit--;

    while (limit > 0) {
      Chord? chord = box.get('[$currentKey, $currentChordId]');
      List<int> nextChords = chord!.getPossibleChords();
      int index = Random().nextInt(nextChords.length);

      String newChordPair = '';

      if (nextChords[index] == -1) {
        newChordPair = chord.getModulation();
      } else {
        newChordPair = '[$currentKey, ${nextChords[index]}]';
      }

      List<String> keyChord = newChordPair.substring(1, newChordPair.length - 1).split(',');
      currentKey = int.parse(keyChord[0]);
      currentChordId = int.parse(keyChord[1]);

      String? chordName = box.get(newChordPair)!.chordName;

      _displayChordProgression += ' | $chordName';
      _chordProgression.add(chordName);
      limit--;
    }

    setState(() => _generated = true);
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
    _selectedKey = 1;
    _selectedChord = keyValues.getChords(_selectedKey).first.value;
    _chordLimit = _minLimit;
    _lastChordLimit = _minLimit;
    _image = 'assets/chord_imgs/${keyValues.chords[_selectedKey - 1].first.label}/${_selectedChord[1]}.png';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          transitionBuilder: (Widget child,
                            Animation<double> animation) => ScaleTransition(
                              scale: animation,
                              child: child
                            ),
                          child: _image.isNotEmpty
                            ? Image.asset(
                              _getImage(),
                              key: ValueKey('[$_selectedChord]'),
                              width: MediaQuery.of(context).size.width,
                            ) : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.0, -0.8),
                      child: SimpleActionButton(
                        onPressed: () => _showChordSymbols(context),
                        color: AppTheme.primary80,
                        child: Text(
                          'View Chord Charts',
                          style: AppTextStyle.standard(color: AppTheme.primary10),
                        ),
                      )
                    ),
                  ]
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.05),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text(
                    _displayChordProgression,
                    style: TextStyle(
                      fontSize: _calculateFontSize(),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    !_playing ? CustomMaterialButton(
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
                    !_saved ? CustomMaterialButton(
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
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.7),
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
                            int j = 0;
                            _selectedKey = index;
                            while (keyValues.getChords(_selectedKey)[j].enabled == false) {
                              j++;
                            }
                            _selectedChord = keyValues.getChords(_selectedKey)[j].value;
                          });
                        }
                      },
                    ),
                    MusicDropdownMenu(
                      dropdownMenuEntries: keyValues.getChords(_selectedKey),
                      initialSelection: _selectedChord,
                      label: const Text('Starting Chord'),
                      onSelected: (index) => setState(() { _selectedChord = index; }),
                    ),
                    NumberPicker(
                      value: _chordLimit,
                      minValue: _minLimit,
                      maxValue: _maxLimit,
                      onChanged: (value) => setState(() => _chordLimit = value),
                      textStyle: AppTextStyle.small(color: Colors.black),
                      selectedTextStyle: AppTextStyle.emphasised(color: Colors.black),
                      itemWidth: 40,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SimpleActionButton(
                      onPressed: _generateProgression,
                      color: AppTheme.primary10,
                      child: Text(
                        'Start',
                        style: AppTextStyle.standard(),
                      ),
                    ),
                    SimpleActionButton(
                      onPressed: () => _viewSaves(context),
                      color: AppTheme.primary80,
                      child: Text(
                        'View Saves',
                        style: AppTextStyle.standard(color: AppTheme.primary10),
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