import 'package:flutter/material.dart';
import 'package:flutter_music_application/keys.dart';

class HarmonyScreen extends StatefulWidget {
  const HarmonyScreen({super.key});

  @override
  HarmonyScreenState createState() {
    return HarmonyScreenState();
  }
}

class HarmonyScreenState extends State<HarmonyScreen> with AutomaticKeepAliveClientMixin<HarmonyScreen> {
  @override
  bool get wantKeepAlive => true;

  Keys key = Keys();

  int selectedKey = 1;
  int selectedChord = 1;
  String chordProgression = "";

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownMenu(
                      dropdownMenuEntries: key.keys,
                      initialSelection: 1,
                      enableSearch: false,
                      enableFilter: false,
                      onSelected: (index) {
                        if (selectedKey != index) {
                          setState(() {
                            selectedKey = index;
                          });
                        }
                      },
                      label: const Text('Starting Key'),
                    ),
                    DropdownMenu(
                      dropdownMenuEntries: key.getChords(selectedKey),
                      initialSelection: selectedChord,
                      enableSearch: false,
                      enableFilter: false,
                      onSelected: (index) {
                        setState(() {
                          selectedChord = index;
                        });
                      },
                      label: const Text('Starting Chord'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.8),
                child: MaterialButton(
                  onPressed: () {},
                  color: const Color.fromARGB(255, 42, 85, 124),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 45,
                  minWidth: 130,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}