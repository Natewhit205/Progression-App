import 'package:flutter/material.dart';

class Keys {
  List<DropdownMenuEntry> keys = [];

  List<List<DropdownMenuEntry>> chords = [];

  List<DropdownMenuEntry> getChords(selectedKey) => chords[selectedKey - 1];

  void addKeys(int key, String name) => keys.add(DropdownMenuEntry(value: key, label: name));
  void addChords(int key, int index, String label, bool enabled) => chords[key - 1].add(DropdownMenuEntry(value: [key, index], label: label, enabled: enabled));
}