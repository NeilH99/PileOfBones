extends CharacterBody2D

const speed = 300.0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var tilemap: TileMap = $"LayerHolder/Bushes(For Battle)"  # Adjust this path to match your scene tree

@export var target_scene: String = "res://Scenes/Battlesim/BattleSimulator.tscn"
@export var encounter_chance: int = 10  # 10% chance of battle

var tempDirection = 3
var rng = RandomNumberGenerator.new()

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("move_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_up") or Input.is_action_pressed("move_up"):
		direction = Vector2.UP

	direction = direction.normalized()  # Prevents faster diagonal movement
	velocity = direction * speed

	move_and_slide()
	update_animation(direction)
	check_for_encounter()  # Check if the player triggers an encounter

func update_animation(direction: Vector2):
	if direction != Vector2.ZERO:
		if direction == Vector2.RIGHT:
			_animated_sprite.play("MoveRight")
			tempDirection = 1
		elif direction == Vector2.LEFT:
			_animated_sprite.play("MoveLeft")
			tempDirection = 2
		elif direction == Vector2.DOWN:
			_animated_sprite.play("MoveDown")
			tempDirection = 3
		elif direction == Vector2.UP:
			_animated_sprite.play("MoveUp")
			tempDirection = 4
	else:
		match tempDirection:
			1: _animated_sprite.play("IdleRight")
			2: _animated_sprite.play("IdleLeft")
			3: _animated_sprite.play("IdleDown")
			4: _animated_sprite.play("IdleUp")

func check_for_encounter():
	if not tilemap:
		print("TileMap node not found!")
		return  # Prevent errors

	var tile_pos = tilemap.local_to_map(global_position)  # Convert world position to tile position
	var tile_data = tilemap.get_cell_tile_data(0, tile_pos)  # 0 is the layer index

	if tile_data and tile_data.get_custom_data("battle"):
		print("Battle trigger possible!")
		if rng.randi_range(1, 100) <= encounter_chance:
			print("Battle starts!")
			get_tree().change_scene_to_file(target_scene)
