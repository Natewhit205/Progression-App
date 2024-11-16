import 'package:flutter/material.dart';

class Keys {
  List<DropdownMenuEntry> keys = const [
    DropdownMenuEntry(value: 1, label: 'F Major'),
    DropdownMenuEntry(value: 2, label: 'C Minor'),
    DropdownMenuEntry(value: 3, label: 'D Minor'),
    DropdownMenuEntry(value: 4, label: 'F# Minor'),
    DropdownMenuEntry(value: 5, label: 'E Major'),
    DropdownMenuEntry(value: 6, label: 'A Major'),
    DropdownMenuEntry(value: 7, label: 'B Major'),
  ];

  List<List<DropdownMenuEntry>> chords = const [
    [
      DropdownMenuEntry(value: [1, 1], label: 'F'),
      DropdownMenuEntry(value: [1, 2], label: 'Gm'),
      DropdownMenuEntry(value: [1, 3], label: 'Am', enabled: false),
      DropdownMenuEntry(value: [1, 4], label: 'Bb'),
      DropdownMenuEntry(value: [1, 5], label: 'C'),
      DropdownMenuEntry(value: [1, 6], label: 'Dm'),
      DropdownMenuEntry(value: [1, 7], label: 'Edim', enabled: false),
    ],
    [
      DropdownMenuEntry(value: [2, 1], label: 'Cm'),
      DropdownMenuEntry(value: [2, 2], label: 'Ddim'),
      DropdownMenuEntry(value: [2, 3], label: 'Eb'),
      DropdownMenuEntry(value: [2, 4], label: 'Fm'),
      DropdownMenuEntry(value: [2, 5], label: 'Gm'),
      DropdownMenuEntry(value: [2, 6], label: 'Ab'),
      DropdownMenuEntry(value: [2, 7], label: 'Bb'),
    ],
    [
      DropdownMenuEntry(value: [3, 1], label: 'Dm'),
      DropdownMenuEntry(value: [3, 2], label: 'Edim', enabled: false),
      DropdownMenuEntry(value: [3, 3], label: 'F'),
      DropdownMenuEntry(value: [3, 4], label: 'Gm'),
      DropdownMenuEntry(value: [3, 5], label: 'Am', enabled: false),
      DropdownMenuEntry(value: [3, 6], label: 'Bb'),
      DropdownMenuEntry(value: [3, 7], label: 'C'),
    ],
    [
      DropdownMenuEntry(value: [4, 1], label: 'F#m'),
      DropdownMenuEntry(value: [4, 2], label: 'G#dim', enabled: false),
      DropdownMenuEntry(value: [4, 3], label: 'A'),
      DropdownMenuEntry(value: [4, 4], label: 'Bm'),
      DropdownMenuEntry(value: [4, 5], label: 'C#m'),
      DropdownMenuEntry(value: [4, 6], label: 'D'),
      DropdownMenuEntry(value: [4, 7], label: 'E'),
    ],
    [
      DropdownMenuEntry(value: [5, 1], label: 'E', enabled: false),
      DropdownMenuEntry(value: [5, 2], label: 'F#m', enabled: false),
      DropdownMenuEntry(value: [5, 3], label: 'G#m', enabled: false),
      DropdownMenuEntry(value: [5, 4], label: 'A', enabled: false),
      DropdownMenuEntry(value: [5, 5], label: 'B'),
      DropdownMenuEntry(value: [5, 6], label: 'C#m', enabled: false),
      DropdownMenuEntry(value: [5, 7], label: 'D#dim', enabled: false),
    ],
    [
      DropdownMenuEntry(value: [6, 1], label: 'A'),
      DropdownMenuEntry(value: [6, 2], label: 'Bm', enabled: false),
      DropdownMenuEntry(value: [6, 3], label: 'C#m'),
      DropdownMenuEntry(value: [6, 4], label: 'D'),
      DropdownMenuEntry(value: [6, 5], label: 'E'),
      DropdownMenuEntry(value: [6, 6], label: 'F#m'),
      DropdownMenuEntry(value: [6, 7], label: 'G#dim', enabled: false),
    ],
    [
      DropdownMenuEntry(value: [7, 1], label: 'B', enabled: false),
      DropdownMenuEntry(value: [7, 2], label: 'C#m', enabled: false),
      DropdownMenuEntry(value: [7, 3], label: 'D#m', enabled: false),
      DropdownMenuEntry(value: [7, 4], label: 'E', enabled: false),
      DropdownMenuEntry(value: [7, 5], label: 'F#'),
      DropdownMenuEntry(value: [7, 6], label: 'G#m', enabled: false),
      DropdownMenuEntry(value: [7, 7], label: 'A#dim', enabled: false),
    ],
  ];

  List<DropdownMenuEntry> getChords(selectedKey) => chords[selectedKey - 1];
}