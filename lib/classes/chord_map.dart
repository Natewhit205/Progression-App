import 'package:flutter_music_application/classes/chord.dart';
import 'package:flutter_music_application/classes/music_key.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class ChordMap {
  @HiveField(0)
  String mapName;

  @HiveField(1)
  Map<String, int> keyIndex;

  @HiveField(2)
  List<MusicKey> mapKeys = [];

  ChordMap(this.mapName, this.keyIndex);

  List<MusicKey> populateKeys(List<Map> keys) {
    List<MusicKey> output = [];

    for (final musicKey in keys) {
      String keyName = musicKey["keyName"];
      List<Map> chords = musicKey["chords"];
      MusicKey currentKey = MusicKey(keyName, chords);
      output.add(currentKey);
    }

    return output;
  }

  Chord getChordObj(String keyName, String chordName) {
    if (mapKeys.isEmpty) {
      throw Exception("ChordMap not populated");
    }

    final int? keyId = keyIndex[keyName];

    if (keyId == null) {
      throw Exception("Key not found: $keyName");
    }

    Chord chordObj = mapKeys[keyId].getChordObj(chordName);
    return chordObj;
  }
}