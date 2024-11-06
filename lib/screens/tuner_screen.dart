import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';


class TunerScreen extends StatefulWidget {
  const TunerScreen({super.key});

  @override
  TunerScreenState createState() {
    return TunerScreenState();
  }
}

class TunerScreenState extends State<TunerScreen> with AutomaticKeepAliveClientMixin<TunerScreen> {
  @override
  bool get wantKeepAlive => true;

  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(audioSampleRate: 44100, bufferSize: 2000);
  final pitchupDart = PitchHandler(InstrumentType.guitar);

  String _note = "C";
  String _status = "Press Start";

  Future<void> _startRecording() async {
    await _audioRecorder.start(listener, onError, sampleRate: 44100, bufferSize: 3000);
    setState(() {
      _status = "Recording";
    });
  }

  Future<void> _stopRecording() async {
    await _audioRecorder.stop();
    setState(() {
      _status = "Press Start";
    });
  }

  void listener(dynamic obj) {
    // Get audio from user
    Float64List buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();

    pitchDetectorDart.getPitchFromFloatBuffer(audioSample).then((result) {
      if (result.pitched) {
        pitchupDart.handlePitch(result.pitch).then((handledPitchResult) {
          if (handledPitchResult.note != '') {
            setState(() {
              _note = handledPitchResult.note;
            });
          }
        });
      }
    });
  }

  void onError(Object e) {
    print(e);
  }

  @override
  void initState() {
    super.initState();
    _audioRecorder.init();
  }

  @override
  void dispose() {
    _audioRecorder.stop();
    super.dispose();
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
                  'Tuner',
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
                alignment: const Alignment(0.0, -0.1),
                child: Text(
                  _note,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 96,
                    color: Color.fromARGB(255, 42, 85, 124),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.5),
                child: MaterialButton(
                  onPressed: _startRecording,
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
                    'Start',
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
                  onPressed: _stopRecording,
                  color: Colors.grey,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 8,
                  minWidth: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    'Stop',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.9),
                child: Text(
                  _status,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    color: Colors.black38,
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