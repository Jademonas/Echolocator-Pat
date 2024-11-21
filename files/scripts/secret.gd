extends Area2D

var transparency = 1 # the multiplication amount, 1 equals "dont change transparency"

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if "echo" in area.name:
		area.get_parent().reverse_direction()
	elif "player" in area.name:
		transparency = 0.90
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _on_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if area:
		if "player" in area.name:
			transparency = 1.2
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _process(delta):
	if transparency != 1:
		$"../../SecretDeco".modulate.a *= transparency
		if $"../../SecretDeco".modulate.a >= 1:
			transparency = 1
			$"../../SecretDeco".modulate.a = 1
		elif $"../../SecretDeco".modulate.a <= 0:
			transparency = 1
			$"../../SecretDeco".modulate.a  = 0
