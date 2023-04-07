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
var highlightColor = Color(1, 0.39, 0.39, 255)
var selectedColor = Color(1, 0, 0, 255)
var backgroundColor = Color(1, 1, 1, 255)
signal charSelected

# Called when the node enters the scene tree for the first time.
func _ready():
	playerManagement = PlayerManagement.new()
	buttonKeys = playerManagement.characterData.keys()
	buttonsSelected = [false, false]
	selectCharacter(1)
	
	pass # Replace with function body.

func selectCharacter(index):
	selectedChar = buttonKeys[index]
	for i in range(buttonsSelected.size()):
		print(i, selectedColor if index == i else backgroundColor, buttonKeys[i], int(index == i))
		buttonsSelected[i] = index == i
		var bump = $VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[i])
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[i]).material.set_shader_parameter("onoff", 1) #int(index == i)
		$VBoxContainer/HBoxContainer/VBaseBody/Characters.get_node(buttonKeys[i]).material.set_shader_parameter("color", selectedColor if index == i else backgroundColor )

	
#background to same color as button -testing
func _on_FocusButton_mouse_exited():
	if !isSelected:
		material.set_shader_parameter("color",backgroundColor)
		

func deselect():
	isSelected = false
	material.set_shader_parameter("color",backgroundColor)

func _on_button_down():
	isSelected = true
	material.set_shader_parameter("color",selectedColor)
	charSelected.emit(selectedChar)

