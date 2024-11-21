extends Node2D

@onready var player = $"../../Player"
var user_prefs: UserPreferences
var number

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.paletteCollectables:
		var node_name = self.name
		number = int(node_name.replace("jumpPickup", ""))
		if user_prefs.paletteCollectables[number] == true:
			$".".queue_free()
			
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if "player" in area.name:
		user_prefs = UserPreferences.load_or_create()
		user_prefs.paletteCollectables[number] = true
		user_prefs.palette = number
		user_prefs.save()
		var shaderPal = user_prefs.get_palette()
		$"../../".material.shader = shaderPal
		$"../../CanvasLayer/Pause Menu".material.shader = shaderPal
		$"../../CanvasLayer/Character UI/healthUI".palette = shaderPal
		$"../../Player".jumps = 0
		$"../../Player/effectRed".emitting = true
		$"../../Player/pickupNoise".play()
		$".".queue_free()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
