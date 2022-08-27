extends TextureButton
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var deckSize = INF

# Called when the node enters the scene tree for the first time.
func _ready():
	rect_scale *= $"../..".CardSize/rect_size


func _input(event):
	print(event)
	#TODO: buggy if combined with parent? convert to signal, see if it helps
	#if Input.is_action_just_released("left_click"):
	if Input.is_action_just_pressed("left_click"):
		print("INIT MAYBE")
		if deckSize > 0:
			print("INIT DRAW")
		#	deckSize = $"../..".draw_card()
			print(deckSize)
			if(deckSize == 0):
				disabled = true
			
