import 'package:flutter/material.dart';
import 'package:flutter_music_application/classes/chord.dart';
import 'package:flutter_music_application/classes/chord_map.dart';
import 'package:flutter_music_application/classes/chord_progression.dart';
import 'package:flutter_music_application/managers/chord_display.dart';
import 'package:flutter_music_application/managers/harmony_manager.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/constants.dart';
import 'package:flutter_music_application/classes/utilities.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/styles.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/screens/saves_screen.dart';
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

  bool haltedGeneration = false;

  late int _selectedKey;
  late List<int> _selectedChord;
  String _displayChordProgression = '';
  List<String> _chordProgression = [];
  late int _chordLimit;
  late int _lastChordLimit;

  bool _checkPlayStatus() => _generated;
  bool _checkSaveStatus() => _generated && !_saved;

  void _viewSaves(context) => Navigator.push(context, MaterialPageRoute(builder: (context) => const SavesScreen()));

  void _generateProgression() {
    final int limit = _chordLimit;
    haltedGeneration = false;

    if (_selectedChord.length <= 1 || _selectedChord[1] < 0) return;

    chordDisplay.clearDisplay();

    final ChordData startingChord =
      harmonyManager.getChordDataObj(_selectedKey, _selectedChord[1]);

    final ChordProgression chordProgression =
      harmonyManager.generateChordProgression(startingChord, limit, chordDisplay);
    
    if (chordProgression.chords.length < limit) haltedGeneration = true;

    _chordProgression =
      chordProgression.chords.map((c) => c.chordName).toList();
    
    _displayChordProgression = _chordProgression.join(' | ');

    setState(() {
      _saved = false;
      _lastChordLimit = _chordLimit;
      _generated = true;
    });
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
                alignment: const Alignment(0.0, -0.8),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: haltedGeneration ? Text(
                    "Halted Generation - No further connected chords",
                    style: AppTextStyle.large(color: AppTheme.error)
                  ) : const SizedBox(),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.5),
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
                alignment: const Alignment(0.0, 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomMaterialButton(
                        onPressed: null,
                        child: Text(
                          'Play',
                          style: AppTextStyle.standard(color: _checkPlayStatus() ? AppTheme.secondary10 : AppTheme.surface),
                        ),
                      )
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