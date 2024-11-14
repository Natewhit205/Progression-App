import 'package:flutter/material.dart';

class Keys {
  List<DropdownMenuEntry> keys = [
    const DropdownMenuEntry(value: 1, label: 'F Major'),
    const DropdownMenuEntry(value: 2, label: 'C Minor'),
    const DropdownMenuEntry(value: 3, label: 'D Minor'),
    const DropdownMenuEntry(value: 4, label: 'F# Minor'),
    const DropdownMenuEntry(value: 5, label: 'E Major'),
    const DropdownMenuEntry(value: 6, label: 'A Major'),
    const DropdownMenuEntry(value: 7, label: 'B Major'),
  ];

  List<List<DropdownMenuEntry>> chords = [
    [
      const DropdownMenuEntry(value: 1, label: 'F'),
      const DropdownMenuEntry(value: 2, label: 'Gm'),
      const DropdownMenuEntry(value: 3, label: 'Am', enabled: false),
      const DropdownMenuEntry(value: 4, label: 'Bb'),
      const DropdownMenuEntry(value: 5, label: 'C'),
      const DropdownMenuEntry(value: 6, label: 'Dm'),
      const DropdownMenuEntry(value: 7, label: 'Edim', enabled: false),
    ],
    [
      const DropdownMenuEntry(value: 1, label: 'Cm'),
      const DropdownMenuEntry(value: 2, label: 'Ddim'),
      const DropdownMenuEntry(value: 3, label: 'Eb'),
      const DropdownMenuEntry(value: 4, label: 'Fm'),
      const DropdownMenuEntry(value: 5, label: 'Gm'),
      const DropdownMenuEntry(value: 6, label: 'Ab'),
      const DropdownMenuEntry(value: 7, label: 'Bb'),
    ],
    [
      const DropdownMenuEntry(value: 1, label: 'Dm'),
      const DropdownMenuEntry(value: 2, label: 'Edim', enabled: false),
      const DropdownMenuEntry(value: 3, label: 'F'),
      const DropdownMenuEntry(value: 4, label: 'Gm'),
      const DropdownMenuEntry(value: 5, label: 'Am', enabled: false),
      const DropdownMenuEntry(value: 6, label: 'Bb'),
      const DropdownMenuEntry(value: 7, label: 'C'),
    ],
    [
      const DropdownMenuEntry(value: 1, label: 'F#m'),
      const DropdownMenuEntry(value: 2, label: 'G#dim', enabled: false),
      const DropdownMenuEntry(value: 3, label: 'A'),
      const DropdownMenuEntry(value: 4, label: 'Bm'),
      const DropdownMenuEntry(value: 5, label: 'C#m'),
      const DropdownMenuEntry(value: 6, label: 'D'),
      const DropdownMenuEntry(value: 7, label: 'E'),
    ],
    [
      const DropdownMenuEntry(value: 1, label: 'E', enabled: false),
      const DropdownMenuEntry(value: 2, label: 'F#m', enabled: false),
      const DropdownMenuEntry(value: 3, label: 'G#m', enabled: false),
      const DropdownMenuEntry(value: 4, label: 'A', enabled: false),
      const DropdownMenuEntry(value: 5, label: 'B'),
      const DropdownMenuEntry(value: 6, label: 'C#m', enabled: false),
      const DropdownMenuEntry(value: 7, label: 'D#dim', enabled: false),
    ],
    [
      const DropdownMenuEntry(value: 1, label: 'A'),
      const DropdownMenuEntry(value: 2, label: 'Bm', enabled: false),
      const DropdownMenuEntry(value: 3, label: 'C#m'),
      const DropdownMenuEntry(value: 4, label: 'D'),
      const DropdownMenuEntry(value: 5, label: 'E'),
      const DropdownMenuEntry(value: 6, label: 'F#m'),
      const DropdownMenuEntry(value: 7, label: 'G#dim', enabled: false),
    ],
    [
      const DropdownMenuEntry(value: 1, label: 'B', enabled: false),
      const DropdownMenuEntry(value: 2, label: 'C#m', enabled: false),
      const DropdownMenuEntry(value: 3, label: 'D#m', enabled: false),
      const DropdownMenuEntry(value: 4, label: 'E', enabled: false),
      const DropdownMenuEntry(value: 5, label: 'F#'),
      const DropdownMenuEntry(value: 6, label: 'G#m', enabled: false),
      const DropdownMenuEntry(value: 7, label: 'A#dim', enabled: false),
    ],
  ];

  List<DropdownMenuEntry> getChords(selectedKey) {
    return chords[selectedKey - 1];
  }
}