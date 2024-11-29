import 'package:flutter/material.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter_music_application/colors.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';
import 'package:flutter_music_application/styles.dart';
import 'package:flutter_music_application/widgets/button.dart';

class SavesScreen extends StatefulWidget {
  const SavesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SavesScreenState();
  }
}

class SavesScreenState extends State<SavesScreen> {

  String _getDisplayString(SavedChordProgression chordProgression) => chordProgression.chordProgression.join(' | ');

  void _clearSaves() => setState(() { saves.deleteAll(saves.keys); });

  void _removeSave(int index) {
    saves.delete(index);
    
    setState(() {
      for (int i = index; i <= saves.length; i++) {
        int oldKey = i + 1;
        int newKey = i;
        SavedChordProgression? oldValue = saves.get(oldKey)!;
        saves.delete(oldKey);
        saves.put(newKey, oldValue);
      }
    });
  }

  void _playChordProgression() {
    
  }

  List<Widget> _populateSaves() {
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
                  width: MediaQuery.of(context).size.width * 2 / 3,
                  height: 60,
                  child: Align(
                    alignment: Alignment.center,
                    child: Flexible(
                      child: Text(
                        displayedProgression,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.clip,
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: _playChordProgression,
                          icon: const Icon(Icons.play_arrow),
                          color: AppTheme.primary,
                        ),
                        IconButton(
                          onPressed: () {_removeSave(key);},
                          icon: const Icon(Icons.delete),
                          color: AppTheme.delete,
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
  void initState() {
    super.initState();
    _populateSaves();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Music App Name'),
        backgroundColor: AppTheme.primary,
      ),
      body: saves.isNotEmpty ? Stack(
        children: [
          FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.2,
            gradientFractionOnEnd: 0.2,
            child: ListView(
              controller: ScrollController(),
              children: _populateSaves()
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
      bottomNavigationBar: saves.isNotEmpty ? BottomAppBar(
        child: SimpleActionButton(
          onPressed: _clearSaves,
          color: AppTheme.primaryAccent,
          child: Text(
            'Clear Saves',
            style: AppTextStyle.standard(context),
          ),
        ),
      ) : null,
    );
  }
}