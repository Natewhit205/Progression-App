import 'dart:typed_data';
import 'dart:async';
import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:pitch_detector_dart/pitch_detector.dart';
import 'package:pitchupdart/instrument_type.dart';
import 'package:pitchupdart/pitch_handler.dart';

class Recording {
  final _audioRecorder = FlutterAudioCapture();
  final pitchDetectorDart = PitchDetector(audioSampleRate: 44100, bufferSize: 2000);
  final pitchupDart = PitchHandler(InstrumentType.guitar);

  Function(String)? onUpdatedNote;
  
  Future<void> startRecording(Function(String) onStart, Function(String) newNote) async {
    onUpdatedNote = newNote;
    await _audioRecorder.start(listener, onError, sampleRate: 44100, bufferSize: 3000);
    onStart("Recording");
  }

  void init() {
    _audioRecorder.init();
  }

  Future<void> stopRecording(Function(String) onStop) async {
    await _audioRecorder.stop();
    onStop("Press Start");
  }

  void listener(dynamic obj) {
    // Get audio from user
    Float64List buffer = Float64List.fromList(obj.cast<double>());
    final List<double> audioSample = buffer.toList();

    pitchDetectorDart.getPitchFromFloatBuffer(audioSample).then((result) {
      if (result.pitched) {
        pitchupDart.handlePitch(result.pitch).then((handledPitchResult) {
          if (handledPitchResult.note != '') {
            onUpdatedNote?.call(handledPitchResult.note);
          }
        });
      }
    });
  }

  void onError(Object e) {
    print(e);
  }
}