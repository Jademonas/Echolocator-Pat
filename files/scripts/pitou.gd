extends Node2D

var listOfTalks = [
	"Welcome to my secret hideout! My name is Pitou",
	"Find my secret chocolate pallete and i'll give you a prize..!",
	"...",	
	"... Did you find my pallete yet?",
	"Thank you for finding my colors! Here, I'll put my most prized possession at the top of the mountain for you"
]
var talkIndex = 0
var playerInside = false
var gotChoco = false
var user_prefs: UserPreferences

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	$pitouette.hide()
	$pitouDialogue.hide()
	user_prefs = UserPreferences.load_or_create()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _process(delta):
	$pitouDialogue.text = listOfTalks[talkIndex]
	gotChoco = (user_prefs.palette == 3)
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if "player" in area.name:
		$pitouDialogue.show()
		playerInside = true
		$pitouDialogueTimer.start()
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #		

func _on_area_2d_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if "player" in area.name:
		playerInside = false
		$pitouDialogue.hide()
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_pitou_dialogue_timer_timeout():
	if talkIndex < 2:
		talkIndex += 1
	elif gotChoco:
		talkIndex = 4
		$pitouette.show()
		user_prefs.pitouette = true
		user_prefs.save()
	elif not gotChoco:
		talkIndex = 3
		user_prefs.pitouette = true
		user_prefs.save()
	if playerInside:
		$pitouDialogueTimer.start()
		

