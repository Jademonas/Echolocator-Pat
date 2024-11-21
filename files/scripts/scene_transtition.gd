extends CanvasGroup

# Pallete Stuff
var user_prefs: UserPreferences

# --------------------------------------------------- #

func _ready():
	user_prefs = UserPreferences.load_or_create()

# --------------------------------------------------- #

func load_material():
	$TextureRect.material.shader = null
	$TextureRect.material.shader = user_prefs.get_palette()
		
# --------------------------------------------------- #

func change_scene_to_file(target: String) -> void:
	$TextureRect.modulate.a = 1
	await load_material()
	$AnimationPlayer.play('enter')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play('leave')
	$Timer.start()
	
# --------------------------------------------------- #

func reload_cur_scene() -> void:
	$TextureRect.modulate.a = 1
	await load_material()
	$AnimationPlayer.play('enter')
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play('leave')

# --------------------------------------------------- #

func _on_timer_timeout():
	$TextureRect.modulate.a = 0
