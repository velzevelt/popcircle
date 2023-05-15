class_name Spectrum
extends Node2D

const MIN_DB = 60
const MAX_FREQ = 11050.0
const MIN_FREQ = 0.0

var spectrum


func _ready():
	var music_bus_id = AudioServer.get_bus_index("Music")
	spectrum = AudioServer.get_bus_effect_instance(music_bus_id, 0)


## Get Music energy
func get_energy(spectrum: AudioEffectSpectrumAnalyzerInstance = self.spectrum) -> float:
	var magnitude: float = spectrum.get_magnitude_for_frequency_range(MIN_FREQ, MAX_FREQ, spectrum.MAGNITUDE_MAX).length()
	var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
	return energy

