extends Container

var user_prefs: UserPreferences
var palette
var jumps = 0
const powerImg = preload("res://nodes/jumpIcon.tscn")
@onready var player = $"../../../Player"

# --------------------------------------------------- #

func _ready():
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.palette:
		palette = user_prefs.get_palette()
	if player.jumps != jumps:
		jumps = player.jumps
		for child in get_children():
			child.queue_free()
		for i in range(jumps):
			var tempImg = powerImg.instantiate()
			$".".add_child(tempImg)

# --------------------------------------------------- #

func _process(delta):
	if player.jumps < jumps:
		var diff = len(get_children()) - player.jumps
		var kids = get_children()
		kids.reverse()
		for i in range(diff):
			var lastKid = kids[i]
			lastKid.use_up()
		jumps = player.jumps
	elif player.jumps > jumps:
		var diff = player.jumps - jumps
		for i in range(diff):
			var tempImg = powerImg.instantiate()
			tempImg.material.shader = palette
			$".".add_child(tempImg)
			$".".move_child(tempImg, -1)
		jumps = player.jumps
