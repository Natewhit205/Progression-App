import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_application/audio_playback.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_music_application/chord.dart';
import 'package:flutter_music_application/keys.dart';
import 'package:flutter_music_application/permissions.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/screens/home_screen.dart';

late Box<Chord> box;
late Box<SavedChordProgression> saves;
final Keys keyValues = Keys();
final AudioPlayback audioPlayback = AudioPlayback();

bool checkEnabledStatus(List<int> nextChords, Map<int, int> keyShifts) => nextChords.isNotEmpty || keyShifts.isNotEmpty;

Future<void> _populateDecisionMap() async {
  List<String> files = [
    'assets/chord_maps/f_maj.csv',
    'assets/chord_maps/c_min.csv',
    'assets/chord_maps/d_min.csv',
    'assets/chord_maps/f#_min.csv',
    'assets/chord_maps/e_maj.csv',
    'assets/chord_maps/a_maj.csv',
    'assets/chord_maps/b_maj.csv'
  ];

  for (int k = 1; k < files.length + 1; k++) {
    String csv = files[k - 1];
    String fileData = await rootBundle.loadString(csv);
    String name;

    List<String> rows = fileData.split('\n');

    String keyChordName = rows[0].split(',')[1];
    if (keyChordName.length == 1) {
      name = keyChordName[0];
    } else {
      name = keyChordName.substring(0, keyChordName.length - 1);
    }

    if (keyChordName.endsWith('m')) {
      name += ' Minor';
    } else {
      name += ' Major';
    }
    keyValues.addKeys(k, name);
    keyValues.chords.add([]);

    for (int i = 0; i < rows.length; i++) {
      String row = rows[i].trim(); //remove trailing whitespace or new lines
      if (row.isEmpty) continue; //skip empty rows
      List<String> itemInRow = row.split(',');

      int iD = 0;
      String chordName = '';
      List<int> nextChords = [];
      List<String> nextChordNames = [];
      bool modulates = false;
      Map<int, int> keyShifts = {};

      for (int j = 0; j < itemInRow.length; j++) {
        if (j == 0) {
          iD = int.parse(itemInRow[j]);
        } else if (j == 1) {
          chordName = itemInRow[j];
        } else {
          while (itemInRow[j] != '-1') {
            nextChords.add(int.parse(itemInRow[j]));
            j++;
          }
          j++; //skip the -1 entry

          while (itemInRow[j] != '0') {
            nextChordNames.add(itemInRow[j]);
            j++;
          }
          j++; //skip the 0 entry

          List<int> tempValues = [];
          while (itemInRow[j] != "None") {
            modulates = true;
            if (itemInRow[j] == "-") {
              j++;
              continue;
            }

            tempValues.add(int.parse(itemInRow[j]));

            if (tempValues.length == 2) {
              keyShifts[tempValues[0]] = tempValues[1];
              tempValues.clear();
            }
            j++;
          }
        }
      }
    
      Chord chord = Chord(iD, chordName, nextChords, nextChordNames, modulates, keyShifts);
      String key = '[$k, ${itemInRow[0]}]';
      keyValues.addChords(k, iD, chordName, checkEnabledStatus(nextChords, keyShifts));

      try {
        box.put(key, chord);
      } catch(e) {
        print('Error storing chord: $e');
      }
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChordAdapter());
  Hive.registerAdapter(SavedChordProgressionAdapter());
  box = await Hive.openBox<Chord>('decisionMap');
  saves = await Hive.openBox<SavedChordProgression>('savedChords');

  await _populateDecisionMap();
  requestPermissions();

  runApp (
    const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}