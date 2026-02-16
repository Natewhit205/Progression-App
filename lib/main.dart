import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music_application/audio_playback.dart';
import 'package:flutter_music_application/classes/chord.dart';
import 'package:flutter_music_application/classes/music_key.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_music_application/classes/chord_map.dart';
import 'package:flutter_music_application/keys.dart';
import 'package:flutter_music_application/permissions.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/screens/home_screen.dart';

late Box<SavedChordProgression> saves;

late Box<ChordMap> chordMaps;

final Keys keyValues = Keys();
final AudioPlayback audioPlayback = AudioPlayback();

bool checkEnabledStatus(List<int> nextChords, Map<int, int> keyShifts) => nextChords.isNotEmpty || keyShifts.isNotEmpty;

Future<Map<String, dynamic>> readJsonFile(String filePath) async {
  try {
    final jsonString = await rootBundle.loadString(filePath);
    return json.decode(jsonString) as Map<String, dynamic>;
  } catch (e, stackTrace) {
    debugPrint("Load Error: $e");
    debugPrintStack(stackTrace: stackTrace);
    return {};
  }
}

Future<List<ChordMap>> _loadDecisionMap() async {
  List<String> jsonFiles = [
    'assets/chord_maps/chord_map.json'
  ];

  List<ChordMap> maps = [];

  int mapIndex = 0;

  for (String jsonFile in jsonFiles) {
    final fileData = await readJsonFile(jsonFile);
    final keys = (fileData["keys"] as List).map((e) => Map<String, dynamic>.from(e)).toList();

    final keyIndex = Map<String, int>.from(fileData["keyIndex"]);
    ChordMap chordMap = ChordMap(fileData["mapName"], keyIndex);
    chordMap.mapKeys = chordMap.populateKeys(keys);
    maps.add(chordMap);

    int index = 0;

    for (final Map<String, dynamic> key in keys) {
      String keyName = key["keyName"];
      final chords = (key["chords"] as List).map((e) => Map<String, dynamic>.from(e)).toList();

      keyValues.addKeys(index, keyName);
      keyValues.chords.add([]);

      for (final currentChord in chords) {
        String chordName = currentChord["chordName"];

        int iD = currentChord["chordId"];
        bool enabled = currentChord["enabled"];
        
        keyValues.addChords(index, iD, chordName, enabled);
      }
      index += 1;
    }

    try {
      chordMaps.put(mapIndex, chordMap);
    } catch (e) {
      debugPrint('Error storing chord map: $e');
    }

    mapIndex += 1;
  }

  return maps;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedChordProgressionAdapter());
  Hive.registerAdapter(ChordMapAdapter());
  Hive.registerAdapter(MusicKeyAdapter());
  Hive.registerAdapter(ChordAdapter());
  Hive.registerAdapter(TransitionAdapter());
  Hive.registerAdapter(ModulationAdapter());
  saves = await Hive.openBox<SavedChordProgression>('savedChords');
  chordMaps = await Hive.openBox<ChordMap>('chordMaps');

  final List<ChordMap> maps = await _loadDecisionMap();
  requestPermissions();

  runApp (
    MaterialApp(
      home: HomeScreen(chordMap: maps.first),
      debugShowCheckedModeBanner: false,
    ),
  );
}