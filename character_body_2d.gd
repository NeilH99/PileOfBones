extends CharacterBody2D

# speed in pixels/sec
var speed = 500 

func _physics_process(_delta):
	# setup direction of movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	# stop diagonal movement by listening for input then setting axis to zero
	if Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left"):
		direction.y = 0
	elif Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down"):
		direction.x = 0
	else:
		direction = Vector2.ZERO
	
	#normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * speed)
	move_and_slide()
