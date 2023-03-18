extends TextureButton

#signal draw_card

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var deckSize = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= $"../..".CardSize/size


func _gui_input(_event):
	if Input.is_action_just_released("left_click"):
	#if Input.is_action_just_pressed("left_click"):
		if deckSize > 0:
			deckSize = $"../..".draw_card()
			#emit_signal("draw_card")
			if(deckSize == 0):
				disabled = true
			
