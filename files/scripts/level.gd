extends Node2D

@onready var musicBusId = AudioServer.get_bus_index("Music")
@onready var sfxBusId = AudioServer.get_bus_index("SFX")
var user_prefs: UserPreferences

func _ready():
	Engine.time_scale = 1
	user_prefs = UserPreferences.load_or_create()
	
	if user_prefs.palette:
		self.material.shader = user_prefs.get_palette()
	if user_prefs.music_volume:
		AudioServer.set_bus_volume_db(musicBusId, linear_to_db(user_prefs.music_volume))
		AudioServer.set_bus_mute(musicBusId, user_prefs.music_volume < 0.05)
	if user_prefs.sfx_volume:
		AudioServer.set_bus_volume_db(sfxBusId, linear_to_db(user_prefs.sfx_volume))
		AudioServer.set_bus_mute(sfxBusId, user_prefs.sfx_volume < 0.05)
