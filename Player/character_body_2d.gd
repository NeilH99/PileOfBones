extends CharacterBody2D

# speed in pixels/sec
var speed = 500 

func _physics_process(_delta):
	# setup direction of movement
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")	

	#normalize the directional movement
	direction = direction.normalized()
	# setup the actual movement
	velocity = (direction * speed)
	move_and_slide()
