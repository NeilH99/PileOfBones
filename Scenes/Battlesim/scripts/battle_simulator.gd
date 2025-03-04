extends Node2D

var fightBtnHandler = preload("res://Scenes/Battlesim/scripts/fightBtnHandler.gd").new()
var myPokemon
var enemyPokemon
var home = true
@onready var btn1 = $CanvasLayer/VBoxContainer/PanelContainer/HomeButtons/Fight
@onready var btn2 = $CanvasLayer/VBoxContainer/PanelContainer/HomeButtons/Bag
@onready var btn3 = $CanvasLayer/VBoxContainer/PanelContainer/HomeButtons/Pokemon
@onready var btn4 = $CanvasLayer/VBoxContainer/PanelContainer/HomeButtons/Run
@onready var backBtn = $CanvasLayer/VBoxContainer/PanelContainer/HomeButtons/BackBtn

func _ready():
	backBtn.pressed.connect(backBtnPressed)
	if(home):
		$CanvasLayer/VBoxContainer/PanelContainer/HomeButtons/Fight.pressed.connect(_on_fight_pressed)
	generatePokemon()
	


func _on_fight_pressed():

	if(home):
		

		btn1.text = myPokemon.moveset[0]
		btn2.text = "Fight 2 Move"
		btn3.text = "Fight 3 Move"
		btn4.text = "Fight 4 Move"
		
		backBtn.visible = true
		fightBtnHandler.handleFight(btn1, btn2, btn3, btn4)
		home = false
	
func backBtnPressed():
		
	btn1.text = "Fight"
	btn2.text = "Bag"
	btn3.text = "Pokemon"
	btn4.text = "Run"
	home = true
	backBtn.visible = false

func generatePokemon():
	var pokemonFolder =  get_files_in_folder("res://Assets/Monsterpool/", "scripts")
	#myPokemon = load("res://Assets/Monsterpool/" + pokemonFolder.pick_random())
	myPokemon = load("res://Assets/Monsterpool/alfinitree.tres")
	print(myPokemon.name)
	$CanvasLayer/VBoxContainer/PlaceHolder.texture = load("res://Assets/Drawables/Pokemon Images/With Backgrounds/" + myPokemon.name + ".jpg")
	$CanvasLayer/VBoxContainer/PlayerHealthBar.value = myPokemon.hp
	
	enemyPokemon = load("res://Assets/Monsterpool/" + pokemonFolder.pick_random())
	$CanvasLayer/VBoxContainer2/PlaceHolder.texture = load("res://Assets/Drawables/Pokemon Images/With Backgrounds/" + enemyPokemon.name + ".jpg")
	$CanvasLayer/VBoxContainer2/PlayerHealthBar.value = enemyPokemon.hp

func get_files_in_folder(path: String , exlude: String) -> Array:
	var dir := DirAccess.open(path)
	var imgs = []
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if exlude not in file_name:
				imgs.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return imgs
