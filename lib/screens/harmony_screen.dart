import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/keys.dart';
import 'package:flutter_music_application/main.dart';

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

  bool saved = false;
  bool generated = false;

  Keys key = Keys();

  int selectedKey = 1;
  late List<int> selectedChord;
  String chordProgression = '';
  int chordLimit = 8;

  void generateProgression() {
    chordProgression = '';
    int limit = chordLimit;
    int currentKey = selectedKey;
    int currentChordId = selectedChord[1];

    setState(() {
      chordProgression += key.getChords(selectedKey)[currentChordId - 1].label;
    });

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

      setState(() {
        chordProgression += ' | $chordName';
      });

      limit--;
    }

    setState(() {
      generated = true;
    });
  }

  bool _checkPlayStatus() {
    if (generated) {
      return true;
    }
    return false;
  }

  bool _checkSaveStatus() {
    if (generated && saved == false) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    selectedChord = key.getChords(selectedKey).first.value;
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
                alignment: const Alignment(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Text(
                    chordProgression,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    softWrap: true,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.27),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: _checkPlayStatus() ? () {} : null,
                      color: const Color.fromARGB(255, 42, 85, 124),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      textColor: const Color(0xfffffdfd),
                      height: 40,
                      minWidth: 110,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: _checkSaveStatus() ? () {} : null,
                      color: const Color.fromARGB(255, 42, 85, 124),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      textColor: const Color(0xfffffdfd),
                      height: 40,
                      minWidth: 110,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                alignment: const Alignment(0.0, 0.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownMenu(
                      dropdownMenuEntries: key.keys,
                      initialSelection: 1,
                      enableSearch: false,
                      enableFilter: false,
                      onSelected: (index) {
                        if (selectedKey != index) {
                          setState(() {
                            selectedKey = index;
                            selectedChord = key.getChords(selectedKey).first.value;
                          });
                        }
                      },
                      label: const Text('Starting Key'),
                    ),
                    DropdownMenu(
                      dropdownMenuEntries: key.getChords(selectedKey),
                      initialSelection: selectedChord,
                      enableSearch: false,
                      enableFilter: false,
                      onSelected: (index) {
                        setState(() {
                          selectedChord = index;
                        });
                      },
                      label: const Text('Starting Chord'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.8),
                child: MaterialButton(
                  onPressed: generateProgression,
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