class Chord {
  String keyName;
  String displayName;
  bool enabled = true;
  Map<int, (Chord?, double?)> changes = {
    1: (Chord("Ab Major", "Eb"), 0.2),
    2: (Chord("D Minor", "Dm"), 0.4)
  };

  Chord(this.keyName, this.displayName);

  (List<Chord?>, List<double?>) getPossibleChords() {
    List<Chord?> options = [];
    List<double?> weights = [];

    for (int i = 0; i < changes.length; i++) {
      options.add(changes[i]?.$1);
      weights.add(changes[i]?.$2);
    }

    return (options, weights);
  }
}