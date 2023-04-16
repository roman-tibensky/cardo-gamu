extends TextureButton

#signal draw_card

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var deckSize = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	scale *= $"../..".CardSize/size

#action moved up to Playspace
#func _gui_input(_event):
#	if Input.is_action_just_released("left_click"):
#		deckSize = $"../..".draw_card()
		#do not disable, deck automatically refills
		#if(deckSize == 0):
		#	disabled = true
			
