class_name UserPreferences extends Resource

@export_range(0, 6, 1) var palette: int = 0
@export_range(0, 1, 0.05) var music_volume: float = 1.0
@export_range(0, 1, 0.05) var sfx_volume: float = 1.0

@export_range(0, 1, 1) var canDash: int = 0
@export_range(0, 1, 1) var canEcho: int = 0
@export var jumpCollectables: Array[bool] = [false, false, false, false, false, false, false]
@export var paletteCollectables: Array[bool] = [true, false, false, false, false, false, false]
@export var pitouette: bool = false
@export var speedrunTimer: float = 0.0

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func save() -> void:
	ResourceSaver.save(self, "user://user_prefs.tres")
	
# --------------------------------------------------- #

static func load_or_create() -> UserPreferences:
	var res: UserPreferences = load("user://user_prefs.tres") as UserPreferences
	if !res:
		res = UserPreferences.new()
	return res
	
# --------------------------------------------------- #

func clear_all():
	palette = 0
	canDash = 0
	canEcho = 0
	jumpCollectables = [false, false, false, false, false, false, false, false]
	paletteCollectables = [true, false, false, false, false, false, false]
	pitouette = false
	speedrunTimer = 0.0
	save()
	
# --------------------------------------------------- #
	
static func get_palette():
	const palValues = [
	preload("res://shaders/original.gdshader"), 
	preload("res://shaders/hicontrast.gdshader"),
	preload("res://shaders/littleboy.gdshader"), 
	preload("res://shaders/chocolate.gdshader"),  
	preload("res://shaders/aqua.gdshader"),  
	preload("res://shaders/bubblegum.gdshader"),  
	preload("res://shaders/whitemode.gdshader")
	]
	var res: UserPreferences = load("user://user_prefs.tres") as UserPreferences
	return palValues[res.palette]
	
# --------------------------------------------------- #
	
static func can_palette(value):
	var res: UserPreferences = load("user://user_prefs.tres") as UserPreferences
	return res.paletteCollectables[value]
