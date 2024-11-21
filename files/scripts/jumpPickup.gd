extends Node2D

@onready var player = $"../../Player"
var user_prefs: UserPreferences
var number

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.jumpCollectables:
		var node_name = self.name
		number = int(node_name.replace("jumpPickup", ""))
		if user_prefs.jumpCollectables[number] == true:
			$".".queue_free()
			
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if "player" in area.name:
		user_prefs = UserPreferences.load_or_create()
		user_prefs.jumpCollectables[number] = true
		user_prefs.save()
		player.maxJumps = user_prefs.jumpCollectables.count(true)
		$"../../Player/effectRed".emitting = true
		$"../../Player/pickupNoise".play()
		$".".queue_free()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
