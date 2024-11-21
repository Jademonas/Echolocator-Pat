extends Sprite2D

var startPos
var mousePos
var aimPos = Vector2.ZERO
var screen_center

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	startPos = $".".position
	screen_center = Vector2(get_viewport().size) / 2

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _process(delta):
	
	# Controller input 
	var axis_x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	var axis_y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	var aim_vector = Vector2(axis_x, axis_y)

	if aim_vector.length() > 0.1:
		aim_vector = aim_vector.normalized() * 150
		aimPos = screen_center + aim_vector
		Input.warp_mouse(aimPos)
	aimPos = get_global_mouse_position()

	look_at(aimPos)
	
	
	
	
