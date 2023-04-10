extends MarginContainer

const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum = constants.new().targetEnum

var PlayerManagement = preload("res://Assets/player/player_management.gd")
var playerManagement

var buttonsSelected
var buttonKeys
var selectedChar

var isSelected  = false
var highlightColor = Color(1, 0.5, 0.5, 155)
var selectedColor = Color(1, 0, 0, 255)
var backgroundColor = Color(1, 1, 1, 255)
signal startNewGAme

# Called when the node enters the scene tree for the first time.
func _ready():
	playerManagement = PlayerManagement.new()
	buttonKeys = playerManagement.characterData.keys()
	buttonsSelected = [false, false]
	$VBoxContainer/HBoxContainer/VBaseBody/Characters/Character1/CenterContainer/Label.text = playerManagement.characterData[buttonKeys[0]].name
	$VBoxContainer/HBoxContainer/VBaseBody/Characters/Character2/CenterContainer/Label.text = playerManagement.characterData[buttonKeys[1]].name
	selectCharacter(1)
	
	pass # Replace with function body.

func selectCharacter(index):
	selectedChar = buttonKeys[index]
	var char = playerManagement.characterData[selectedChar]
	for i in range(buttonsSelected.size()):
		buttonsSelected[i] = index == i
		var bump = $VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[i])
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[i]).material.set_shader_parameter("onoff", 1) #int(index == i)
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[i]).material.set_shader_parameter("color", selectedColor if index == i else backgroundColor )
	
	$VBoxContainer/HBoxContainer/VBaseBody/HandSize/Label.text = str(char.handSizeDefault) + " / " + str(char.handSizeMax)
	$VBoxContainer/HBoxContainer/VBaseBody/Stats/InitStats/RedLifeInfo/CenterContainer/InitVMax.text = str(char.redStarting) + " / " + str(char.redMaxPool)
	$VBoxContainer/HBoxContainer/VBaseBody/Stats/InitStats/GreenLifeInfo/CenterContainer/InitVMax.text = str(char.greenStarting) + " / " + str(char.greenMaxPool)
	$VBoxContainer/HBoxContainer/VBaseBody/Stats/InitStats/BlueLifeInfo/CenterContainer/InitVMax.text = str(char.blueStarting) + " / " + str(char.blueMaxPool)
	$VBoxContainer/HBoxContainer/VBaseBody/Stats/MModifierStats/RedModInfo/CenterContainer/StartVMod.text = str(char.redModifierStarting) + " / " + str(char.redModifierAction)
	$VBoxContainer/HBoxContainer/VBaseBody/Stats/MModifierStats/GreenModInfo/CenterContainer/StartVMod.text = str(char.greenModifierStarting) + " / " + str(char.greenModifierAction)
	$VBoxContainer/HBoxContainer/VBaseBody/Stats/MModifierStats/BlueModInfo/CenterContainer/StartVMod.text = str(char.blueModifierStarting) + " / " + str(char.blueModifierAction)
	
	$VBoxContainer/HBoxContainer/VBaseBody/CharacterDescription/Label.text = char.description
	

func _on_character_1_button_down():
	selectCharacter(0)


func _on_character_1_mouse_entered():
	if !buttonsSelected[0]:
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[0]).material.set_shader_parameter("color", highlightColor)


func _on_character_1_mouse_exited():
	if !buttonsSelected[0]:
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[0]).material.set_shader_parameter("color", backgroundColor)


func _on_character_2_button_down():
	selectCharacter(1)

func _on_character_2_mouse_entered():
	if !buttonsSelected[1]:
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[1]).material.set_shader_parameter("color", highlightColor)

func _on_character_2_mouse_exited():
	if !buttonsSelected[1]:
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[1]).material.set_shader_parameter("color", backgroundColor)


func _on_new_game_button_button_down():
	print("staaaart")
	pass # Replace with function body.


func _on_quit_button_button_down():
	print("quiiiiiit")
	get_tree().quit()
	pass # Replace with function body.


func _on_quit_button_pressed():
	print("bah")
	pass # Replace with function body.
