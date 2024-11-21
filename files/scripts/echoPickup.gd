extends Node2D

@onready var player = $"../../Player"
var user_prefs: UserPreferences

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.canEcho:
		if user_prefs.canEcho == 1:
			$".".queue_free()
			
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if "player" in area.name:
		user_prefs = UserPreferences.load_or_create()
		user_prefs.canEcho = 1 
		user_prefs.save()
		player.canEcho = true
		$"../../Player/effectRed".emitting = true
		$"../../Player/pickupNoise".play()
		$".".queue_free()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
