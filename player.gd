extends CharacterBody2D


const SPEED = 100.0
const ACCELERTAION = 600.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D


func _physics_process(delta):
	
	animation()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():

		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:

		velocity.x =  move_toward(velocity.x, SPEED * direction, ACCELERTAION * delta)
	else:

		velocity.x =  move_toward(velocity.x, 0, FRICTION * delta)

	move_and_slide()
func animation():
	if  not is_on_floor():
		animated_sprite_2d.play("jump")
	elif velocity.x < 0:
		scale.x = scale.y * -1
		animated_sprite_2d.play("walk")
	elif velocity.x > 0:
		scale.x = scale.y * 1
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")
