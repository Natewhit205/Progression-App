import 'package:flutter_music_application/classes/key.dart';

class ChordMap {
  String mapName;
  List<Key> mapKeys;

  ChordMap(this.mapName, this.mapKeys);

  int addKey(Key? key) {
    if (key != null) {
      mapKeys.add(key);
    }
    return -1;
  }
}