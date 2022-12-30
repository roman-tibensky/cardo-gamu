extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rect_scale *= $"../..".CardSize/rect_size
	disabled = true
	pass # Replace with function body.

