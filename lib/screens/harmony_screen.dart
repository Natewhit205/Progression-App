import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/main.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_music_application/widgets/dropdown.dart';
import 'package:flutter_music_application/widgets/button.dart';

class HarmonyScreen extends StatefulWidget {
  const HarmonyScreen({super.key});

  @override
  HarmonyScreenState createState() {
    return HarmonyScreenState();
  }
}

class HarmonyScreenState extends State<HarmonyScreen> with AutomaticKeepAliveClientMixin<HarmonyScreen> {
  @override
  bool get wantKeepAlive => true;

  bool _saved = false;
  bool _generated = false;

  String _image = '';

  final double _minFont = 22;
  final double _maxFont = 30;
  final int _minLimit = 4;
  final int _maxLimit = 32;

  late int _selectedKey;
  late List<int> _selectedChord;
  String _chordProgression = '';
  late int _chordLimit;
  late int _lastChordLimit;

  double _calculateFontSize() => _maxFont - (_lastChordLimit - _minLimit) * (_maxFont - _minFont) / (_maxLimit - _minLimit);
  bool _checkPlayStatus() => _generated;
  bool _checkSaveStatus() => _generated && !_saved;

  String _getImage() => 'assets/chord_maps/img/$_selectedKey/${_selectedChord[1]}.png';

  void _generateProgression() {
    _lastChordLimit = _chordLimit;
    _chordProgression = '';
    int limit = _chordLimit;
    int currentKey = _selectedKey;
    int currentChordId = _selectedChord[1];

    _chordProgression += keyValues.getChords(_selectedKey)[currentChordId - 1].label;
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

      _chordProgression += ' | $chordName';
      limit--;
    }

    setState(() {
      _generated = true;
    });
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
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: _image.isNotEmpty
                      ? Image.asset(
                        _getImage(),
                        width: MediaQuery.of(context).size.width,
                    ) : const SizedBox.shrink(),
                  )
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text(
                    _chordProgression,
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
                alignment: const Alignment(0.0, 0.36),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomMaterialButton(
                      onPressed: _checkPlayStatus() ? () {} : null,
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    CustomMaterialButton(
                      onPressed: _checkSaveStatus() ? () {} : null,
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
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
                      itemWidth: 40,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.9),
                child: MaterialButton(
                  onPressed: _generateProgression,
                  color: const Color.fromARGB(255, 42, 85, 124),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 45,
                  minWidth: 130,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}