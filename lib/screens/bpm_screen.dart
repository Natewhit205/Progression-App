import 'package:flutter/material.dart';

class BpmScreen extends StatefulWidget {
  const BpmScreen({super.key});

  @override
  BpmScreenState createState() {
    return BpmScreenState();
  }
}

class BpmScreenState extends State<BpmScreen> with AutomaticKeepAliveClientMixin<BpmScreen> {
  @override
  bool get wantKeepAlive => true;
  // BPM Variables
  int _beatsPerMinute = 0;
  int _numOfTaps = 0;
  DateTime _startTime = DateTime.now();
  DateTime _lastTap = DateTime.now();

  void _setBpm() {
    if (_numOfTaps == 0) {
      _startTime = DateTime.now();
    }

    if (DateTime.now().difference(_lastTap).inMilliseconds > 5000) {
      _resetBPM();
    }

    _numOfTaps += 1;
    DateTime currentTime = DateTime.now();
    int timeElapsed = currentTime.difference(_startTime).inMilliseconds;
    _lastTap = DateTime.now();

    if (timeElapsed == 0) {
      timeElapsed = 400;
    }

    setState(() {
      _beatsPerMinute = (60000 * _numOfTaps) ~/ timeElapsed;
    });
  }

  void _resetBPM() {
    _numOfTaps = 0;
    _startTime = DateTime.now();
    _lastTap = DateTime.now();
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
              const Align(
                alignment: Alignment(0.0, -0.85),
                child: Text(
                  'BPM Clicker',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 36,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.4),
                child: Text(
                  '$_beatsPerMinute BPM',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 34,
                    color: Colors.grey,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: MaterialButton(
                  onPressed: _setBpm,
                  color: const Color.fromARGB(255, 42, 85, 124),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 10,
                  minWidth: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Tap',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.7),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      _resetBPM();
                      _beatsPerMinute = 0;
                    });
                  },
                  color: Colors.grey,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 8,
                  minWidth: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}