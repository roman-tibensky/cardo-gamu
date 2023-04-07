extends TextureButton

var id = "1"
var isSelected  = false
var highlightColor = Color(1, 0.39, 0.39, 255)
var selectedColor = Color(1, 0, 0, 255)
var backgroundColor = Color(0, 0, 0, 255)
signal charSelected

# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_parameter("onoff",1)
	material.set_shader_parameter("color",backgroundColor)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

			
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
	charSelected.emit(id)

