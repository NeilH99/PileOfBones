extends Node2D

	
func handleFight(fight1: Button, fight2: Button, fight3: Button, fight4: Button):
	fight1.pressed.connect(_on_fight1_pressed.bind(fight1))
	fight2.pressed.connect(_on_fight2_pressed)
	fight3.pressed.connect(_on_fight3_pressed)
	fight4.pressed.connect(_on_fight4_pressed)

func _on_fight1_pressed(fight1):
	print("fight 1 was clicked!")
	fight1.pressed.disconnect(_on_fight1_pressed)
func _on_fight2_pressed():
	print("fight 2 was clicked!")
func _on_fight3_pressed():
	print("fight 3 was clicked!")
func _on_fight4_pressed():
	print("fight 4 was clicked!")
