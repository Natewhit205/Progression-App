import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chord.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'screens/home_screen.dart';

late Box<Chord> box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ChordAdapter());
  box = await Hive.openBox<Chord>('decisionMap');

  List<String> files = [
    'assets/chord_maps/f_maj.csv',
    'assets/chord_maps/c_min.csv',
    'assets/chord_maps/d_min.csv',
    'assets/chord_maps/f#_min.csv',
    'assets/chord_maps/e_maj.csv',
    'assets/chord_maps/a_maj.csv',
    'assets/chord_maps/b_maj.csv'
  ];

  for (int k = 1; k < files.length + 1; k++) {
    String csv = files[k - 1];
    String fileData = await rootBundle.loadString(csv);

    List<String> rows = fileData.split('\n');

    for (int i = 0; i < rows.length; i++) {
      String row = rows[i].trim(); //remove trailing whitespace or new lines
      if (row.isEmpty) continue; //skip empty rows
      List<String> itemInRow = row.split(',');

      int iD = 0;
      String chordName = '';
      List<int> nextChords = [];
      List<String> nextChordNames = [];
      bool modulates = false;
      Map<int, int> keyShifts = {};

      for (int j = 0; j < itemInRow.length; j++) {
        if (j == 0) {
          iD = int.parse(itemInRow[j]);
        } else if (j == 1) {
          chordName = itemInRow[j];
        } else {
          while (itemInRow[j] != '-1') {
            nextChords.add(int.parse(itemInRow[j]));
            j++;
          }
          j++; //skip the -1 entry

          while (itemInRow[j] != '0') {
            nextChordNames.add(itemInRow[j]);
            j++;
          }
          j++; //skip the 0 entry

          List<int> tempValues = [];
          while (itemInRow[j] != "None") {
            modulates = true;
            if (itemInRow[j] == "-") {
              j++;
              continue;
            }

            tempValues.add(int.parse(itemInRow[j]));

            if (tempValues.length == 2) {
              keyShifts[tempValues[0]] = tempValues[1];
              tempValues.clear();
            }
            j++;
          }
        }
      }
    
      Chord chord = Chord(iD, chordName, nextChords, nextChordNames, modulates, keyShifts);
      String key = '[$k, ${itemInRow[0]}]';

      try {
        box.put(key, chord);
        print('Stored chord: key=$key, ID=$iD, ChordName=$chordName NextChords=$nextChords, NextChordNames=$nextChordNames, Modulates=$modulates, KeyShifts=$keyShifts');
      } catch(e) {
        print('Error storing chord: $e');
      }
    }
  
  }

  runApp (
    const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyFlutterState();
  }
}

class MyFlutterState extends State<MyApp> {
  late int iD;
  late int nextID;
  String description = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      /*setState(() {
        Node? current = box.get(1);
        if (current != null) {
          iD = current.iD;
          nextID = current.nextID;
          description = current.description;
        }
      });*/
    });
  }

  void buttonHandler() {
    /*setState(() {
      Node? nextNode = box.get(nextID);
      if (nextNode != null) {
        iD = nextNode.iD;
        nextID = nextNode.nextID;
        description = nextNode.description;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3e87c5),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: MaterialButton(
                  onPressed: () { buttonHandler(); },
                  color: const Color(0xff3a21d9),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 40,
                  minWidth: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "Text Button",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.7),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 34,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}