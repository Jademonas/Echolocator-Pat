extends Node

func button_press_confirm():
	$confirmclick.play()
	
func button_press_soft():
	$softCLick.play()

func _on_music_finished():
	$music.play()
