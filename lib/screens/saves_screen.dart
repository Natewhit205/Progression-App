import 'package:flutter/material.dart';
import 'package:flutter_music_application/main.dart';
import 'package:flutter_music_application/saved_chord_progression.dart';

class SavesScreen extends StatefulWidget {
  const SavesScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SavesScreenState();
  }
}

class SavesScreenState extends State<SavesScreen> {

  String _getDisplayString(SavedChordProgression chordProgression) => chordProgression.chordProgression.join(' | ');

  void _clearSaves() => setState((){ saves.deleteAll(saves.keys); });

  void _removeSave(int index) {
    saves.delete(index);
    
    setState((){
      for (int i = index; i <= saves.length; i++) {
        print(saves.keys);
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
              children: [
                Text(
                  '$key .  ',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Flexible(
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
                IconButton(
                  onPressed: _playChordProgression,
                  icon: const Icon(Icons.play_arrow),
                  color: const Color.fromARGB(255, 42, 85, 124),
                ),
                IconButton(
                  onPressed: () {_removeSave(key);},
                  icon: const Icon(Icons.delete),
                  color: const Color.fromARGB(255, 209, 52, 41),
                )
              ],
            )
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
        backgroundColor: const Color.fromARGB(255, 42, 85, 124),
      ),
      body: saves.isNotEmpty ? ListView(
        children: _populateSaves()
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
        child: MaterialButton(
          onPressed: _clearSaves,
          color: const Color.fromARGB(255, 204, 204, 204),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          textColor: Colors.black,
          height: 45,
          minWidth: 130,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: const Text(
            'Clear Saves',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ) : null,
    );
  }
}