extends Node2D

@onready var player = $"../../Player"
var user_prefs: UserPreferences

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _ready():
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.canDash:
		if user_prefs.canDash == 1:
			$".".queue_free()
			
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if "player" in area.name:
		user_prefs = UserPreferences.load_or_create()
		user_prefs.canDash = 1 
		user_prefs.save()
		player.canDash = true
		$"../../Player/effectRed".emitting = true
		$"../../Player/pickupNoise".play()
		$".".queue_free()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
