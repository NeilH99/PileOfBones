extends Node2D

var fightBtnHandler = preload("res://Scenes/Battlesim/fightBtnHandler.gd").new()

func _ready():
	# Connect Button1's pressed signal
	$CanvasLayer/PanelContainer/HomeButtons/Fight.pressed.connect(_on_fight_pressed)

func _on_fight_pressed():

	var btn = $CanvasLayer/PanelContainer/HomeButtons/Fight.duplicate()
	var fightBtn = $CanvasLayer/PanelContainer/HomeButtons/Fight.duplicate()
	var bagBtn = $CanvasLayer/PanelContainer/HomeButtons/Bag.duplicate()
	var pokemonBtn = $CanvasLayer/PanelContainer/HomeButtons/Pokemon.duplicate()
	var runBtn = $CanvasLayer/PanelContainer/HomeButtons/Run.duplicate()

	$CanvasLayer/PanelContainer/HomeButtons/Fight.queue_free()
	$CanvasLayer/PanelContainer/HomeButtons/Bag.queue_free()
	$CanvasLayer/PanelContainer/HomeButtons/Pokemon.queue_free()
	$CanvasLayer/PanelContainer/HomeButtons/Run.queue_free()

	# Create a new button
	var fight1 = btn.duplicate()
	fight1.text = "Fight 1 Move"
	var fight2 = btn.duplicate()
	fight2.text = "Fight 2 Move"
	var fight3 = btn.duplicate()
	fight3.text = "Fight 3 Move"
	var fight4 = btn.duplicate()
	fight4.text = "Fight 4 Move"
	
	var backBtn = btn.duplicate()
	backBtn.text = "Back"
	backBtn.pressed.connect(backBtnPressed.bind(fightBtn, bagBtn, pokemonBtn, runBtn))
	
	$CanvasLayer/PanelContainer/HomeButtons.add_child(fight1)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(fight2)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(fight3)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(fight4)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(backBtn)

	
	fightBtnHandler.handleFight(fight1, fight2, fight3, fight4)
	
func backBtnPressed(fightBtn, bagBtn, pokemonBtn, runBtn):
	for kid in $CanvasLayer/PanelContainer/HomeButtons.get_children():
		kid.queue_free()
		
	$CanvasLayer/PanelContainer/HomeButtons.add_child(fightBtn)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(bagBtn)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(pokemonBtn)
	$CanvasLayer/PanelContainer/HomeButtons.add_child(runBtn)
	$CanvasLayer/PanelContainer/HomeButtons/Fight.pressed.connect(_on_fight_pressed)

		
	
