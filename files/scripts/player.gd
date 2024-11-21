extends CharacterBody2D

# --------------------------------------------------- #

const SPEED = 300.0
const DASH_SPEED = 600.0
const JUMP_VELOCITY = -400.0
var alreadyLanded = false
var maxJumps = 3
var jumps = 0
var dashing = false
var lastDirection = 1

# Ability upgrades
var canDash = false
var dashed = false
var canEcho = false
var echoed = false

const echo = preload("res://nodes/echo.tscn")

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var user_prefs: UserPreferences

var won = false

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _ready():
	
	$aim.hide()
	$"prompts echo".hide()
	$"prompts dash".hide()
	
	user_prefs = UserPreferences.load_or_create()
	if user_prefs.jumpCollectables:
		maxJumps = user_prefs.jumpCollectables.count(true)
	if user_prefs.canDash:
		canDash = user_prefs.canDash
		dashed = true
	if user_prefs.canEcho:
		canEcho = user_prefs.canEcho
		echoed = true
		$aim.show()
	

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _process(_delta):
	
	var floored = is_on_floor()
	var anim = $AnimatedSprite2D.get_animation() 
	
	# --------------------------------- #
	
	# Echolocate
	if !won and canEcho:
		if !echoed:
			$"prompts echo".show()
			$aim.show()
		else:
			$"prompts echo".hide()
			
		if Input.is_action_just_pressed("action") and jumps > 0:
			jumps -= 1
			var tempEcho = echo.instantiate()
			tempEcho.position = $".".position
			$".".add_child(tempEcho)
			$EcholocateNoise.play()
			$"reloadTimer".stop()
			$"reloadTimer".wait_time = 1.2
			$"reloadTimer".start()
			echoed = true
		
	# --------------------------------- #	
		
	# Dash
	if !won and canDash:
		if !dashed:
			$"prompts dash".show()
		else:
			$"prompts dash".hide()
			
		if Input.is_action_just_pressed("dash") and jumps > 0 and not dashing:
			jumps -= 1
			dashing = true
			$dashTimer.start()
			$DashNoise.play()
			lastDirection = sign(lastDirection)
			if lastDirection == 0:
				lastDirection = 1
			$"effectRed".gravity.x = lastDirection*lastDirection
			$"effectRed".emitting = true
			$"reloadTimer".stop()
			$"reloadTimer".wait_time = 1.2
			$"reloadTimer".start()
			dashed = true

	# --------------------------------------------------- #
	
	# make sprite face correct direction
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x < 0:		
		$AnimatedSprite2D.flip_h = false
	
	# --------------------------------- #
	
	# animation handling
	if not floored and anim != "jump":
		$AnimatedSprite2D.play("fall")
	if floored and anim != "run":
		$AnimatedSprite2D.play("idle")
		
	# --------------------------------- #
	
	if jumps < maxJumps:
			
		# Reload jump instanlty when landing
		if not alreadyLanded and floored:
			jumps += 1
			alreadyLanded = true
			$"reloadTimer".start()
		
		# prevents a softlock
		elif floored and $"reloadTimer".is_stopped():
			jumps += 1
			$"reloadTimer".start()
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _physics_process(delta):
	
	# apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		$"reloadTimer".stop()
		
	# --------------------------------- #

	# Jump		
	if !won and Input.is_action_just_pressed("jump") and jumps > 0:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("jump")	
		$WingFlap.play()
		$"effectRed".emitting = true
		velocity.y = JUMP_VELOCITY
		jumps -= 1
		alreadyLanded = false

	# --------------------------------------------------- #
	
	# forces you into the dash
	if dashing:
		velocity.x = lastDirection * DASH_SPEED
		
	# left/right movement
	else:
		var direction = Input.get_axis("left", "right")
		if !won and direction:
			if velocity.x != lastDirection * DASH_SPEED or is_on_floor():
				velocity.x = direction * SPEED
				if $AnimatedSprite2D.get_animation() == "run" and !$WalkNoise.playing:
					$WalkNoise.play()
			if $AnimatedSprite2D.get_animation() == "idle":
				$AnimatedSprite2D.play("run")
			lastDirection = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if $AnimatedSprite2D.get_animation() != "jump":
				$AnimatedSprite2D.play("idle")

	move_and_slide()

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("idle") # aka default to this animation

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

# recharge jumps
func _on_timer_timeout():
	if jumps < maxJumps:
		jumps += 1
	$"reloadTimer".wait_time = 0.5
	$"reloadTimer".start()
		
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #
		
func _on_dash_timer_timeout():
	dashing = false
	$"effectRed".gravity.x = 0

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= #

