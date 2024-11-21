extends TextureRect

# --------------------------------------------------- #

func _ready():
	$"popIn".emitting = true

# --------------------------------------------------- #

func use_up():
	$"popIn".emitting = false
	$"popIn".emitting = true
	await get_tree().create_timer(0.2).timeout
	$".".queue_free()
	
