import 'package:flutter/material.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/styles.dart';
import 'package:flutter_music_application/widgets/app_bar.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/widgets/button.dart';

class SavesScreen extends StatefulWidget {
  const SavesScreen({super.key});

  @override
  SavesScreenState createState() => SavesScreenState();
}

class SavesScreenState extends State<SavesScreen> {
  bool _playing = false;
  int _current = 0;

  String _getDisplayString(SavedChordProgression chordProgression) => chordProgression.chordProgression.join(' | ');

  void _clearSaves() => setState(() { saves.deleteAll(saves.keys); });

  Future<bool?> confirmDelete(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Deleting this will be permenant. Are you sure?'),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: AppTextStyle.standard(color: AppTheme.primaryAccent)
          ),
          onPressed: () => Navigator.of(context).pop(false)
        ),
        TextButton(
          child: Text(
            'Delete',
            style: AppTextStyle.standard(color: AppTheme.error),
          ),
          onPressed: () => Navigator.of(context).pop(true)
        ),
      ],
    )
  );

  void _removeSave(int index) {
    saves.delete(index);
    
    setState(() {
      for (int i = index; i <= saves.length; i++) {
        int oldKey = i + 1;
        int newKey = i;
        SavedChordProgression? oldValue = saves.get(oldKey);
        if (oldValue != null) {
          saves.delete(oldKey);
          saves.put(newKey, oldValue);
        }
      }
    });
  }

  void _deleteItem(Function function, {int? key}) async {
    bool? result = await confirmDelete(context);
    if (result != null) {
      if (result) {
        if (key == null) {
          function();
        } else {
          function(key);
        }
      }
    }
  }

  Future<void> _playChordProgression(List<String> chordProgression, int key) async {
    _current = key;
    bool finished = false;
    Duration duration = const Duration(seconds: 0);
    setState(() => _playing = true);

    duration  = await audioPlayback.playAudio(chordProgression);

    if (duration != const Duration(seconds: 0)) {
      finished = true;
      setState(() => _playing = !finished);
    }
  }

  void _stopChordProgression() {
    audioPlayback.stopAudio();
    setState(() => _playing = false);
  }

  bool _checkCurrent(int key) {
    if (!_playing) {
      return true;
    } else {
      if (_current == key) { return false; }
      return true;
    }
  }

  double _calculateFontSize(int length) {
    double output;
    double minFont = 16;
    double maxFont = 18;
    int lowerBound = 8;
    int upperBound = 32;

    if (length <= 8) {
      output = maxFont;
    } else {
      output = maxFont - (length - lowerBound) * (maxFont - minFont) / (upperBound - lowerBound);
    }
    return output;
  }

  List<Widget> _populateSaves(BuildContext context, double screenWidth) {
    List<Widget> output = [];
    for (int i = 0; i < saves.length; i++) {
      int key = i + 1;
      SavedChordProgression? currentProgression = saves.get(key)!;
      String displayedProgression = _getDisplayString(currentProgression);
      output.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 2 / 3,
                  height: 80,
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FadingEdgeScrollView.fromSingleChildScrollView(
                          gradientFractionOnStart: 0.8,
                          gradientFractionOnEnd: 0.8,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            controller: ScrollController(),
                            child: Text(
                              displayedProgression,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: _calculateFontSize(currentProgression.chordProgression.length),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        _checkCurrent(key) ? IconButton(
                          onPressed: () => _playChordProgression(currentProgression.chordProgression, key),
                          icon: const Icon(Icons.play_arrow),
                          color: AppTheme.primary40,
                        ) : IconButton(
                          onPressed: _stopChordProgression,
                          icon: const Icon(Icons.stop),
                          color: AppTheme.primary40,
                        ),
                        IconButton(
                          onPressed: () => _deleteItem(_removeSave, key: key),
                          icon: const Icon(Icons.delete),
                          color: AppTheme.error,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      ));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.customAppBar(title: 'Saved Progressions'),
      body: saves.isNotEmpty ? Stack(
        children: [
          FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.2,
            gradientFractionOnEnd: 0.2,
            child: ListView(
              controller: ScrollController(),
              children: _populateSaves(context, MediaQuery.sizeOf(context).width)
            ),
          ),
        ]
      ) : Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: const Align(
            alignment: Alignment(0.0, 0.0),
            child: Text(
              'No Saved Progressions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.surface,
      bottomNavigationBar: saves.isNotEmpty ? BottomAppBar(
        child: SimpleActionButton(
          onPressed: () => _deleteItem(_clearSaves),
          color: AppTheme.error,
          child: Text(
            'Clear Saves',
            style: AppTextStyle.standard(color: AppTheme.surface),
          ),
        ),
      ) : null,
    );
  }
}