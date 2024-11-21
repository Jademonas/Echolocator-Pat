extends Node2D

var speed = 7

var mousePos 
var direction
var startPos

var user_prefs: UserPreferences

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	mousePos = get_global_mouse_position()
	startPos = $".".position
	var x = mousePos.x - startPos.x
	var y = mousePos.y - startPos.y
	direction = Vector2(x, y).normalized()
	look_at(mousePos)
	
	user_prefs = UserPreferences.load_or_create()
	$Sprite2D.material.shader = user_prefs.get_palette()
	
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _process(_delta):
	var pos = $".".position
	$".".position.x = pos.x + direction.x * speed
	$".".position.y = pos.y + direction.y * speed
	$"Sprite2D".modulate.a *= 0.96

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_timer_timeout():
	$".".queue_free()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func reverse_direction():
	$EcholocateNoise.play()
	direction = -direction
	look_at(startPos)
	$"Sprite2D".modulate.a = 1
