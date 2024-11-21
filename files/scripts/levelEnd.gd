extends Node2D

var user_prefs: UserPreferences
var finalTime = 0.0

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	$finalRichText.hide()
	$TextureRect.hide()
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.speedrunTimer:
		finalTime = user_prefs.speedrunTimer

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_goal_area_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	
	if "player" in area.name:
		$"../Player".won = true
		$finalRichText.show()
		$TextureRect.show()
		
		finalTime += $"../CanvasLayer/Pause Menu".time_elapsed
		
		var finalCollect = user_prefs.paletteCollectables.count(true) + user_prefs.jumpCollectables.count(true) + user_prefs.canDash + user_prefs.canEcho
		finalCollect -= 1 # original pallete doesnt count
		
		var pitouette = "???? not found"
		if user_prefs.pitouette:
			pitouette = "Pitouette found!"
			
		var finalText = "Pat got out of the cave!\n\n" + str(finalCollect) + "/14 Collectables found\n"
		finalText += pitouette + "\n\nTotal time: \n" + ("%0.2f" % finalTime) + " seconds"
		$finalRichText.text = finalText
	
		$"../Player/Camera2D".position.y -= 120
		
