import pretty_midi
from typing import List
from pychord import ChordProgression
from pretty_midi import PrettyMIDI


class ChordMap:
    def __init__(self, chords: List[str]):
        self.chords = chords

    def create_audio(self):
        chord_progression = ChordProgression(self.chords)

        midi_data = PrettyMIDI()
        piano_program = pretty_midi.instrument_name_to_program('Acoustic Grand Piano')
        piano = pretty_midi.Instrument(program=piano_program)
        length = 1

        for n, chord in enumerate(chord_progression.chords):
            for note_name in chord.components_with_pitch(root_pitch=3):
                note_pitch = pretty_midi.note_name_to_number(note_name)
                note = pretty_midi.Note(velocity=100, pitch=note_pitch, start=n * length, end=(n + 1) * length)
                piano.notes.append(note)

        midi_data.instruments.append(piano)
        midi_data.write('chord.mid')
