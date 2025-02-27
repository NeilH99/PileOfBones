extends Node2D


# Called when the node enters the scene tree for the first time.
func handle_fight1_action(button_name: String):
	print("Handling fight action for: " + button_name)
	# Add your custom logic here
	
func handleFight(fight1: Button, fight2: Button, fight3: Button, fight4: Button):
	fight1.pressed.connect(_on_fight1_pressed)
	fight2.pressed.connect(_on_fight2_pressed)
	fight3.pressed.connect(_on_fight3_pressed)
	fight4.pressed.connect(_on_fight4_pressed)

func _on_fight1_pressed():
	print("fight 1 was clicked!")
func _on_fight2_pressed():
	print("fight 2 was clicked!")
func _on_fight3_pressed():
	print("fight 3 was clicked!")
func _on_fight4_pressed():
	print("fight 4 was clicked!")
