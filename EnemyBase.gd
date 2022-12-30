extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rCurrent
var rMax

var gCurrent
var gMax

var bCurrent
var bMax


# Called when the node enters the scene tree for the first time.
func _ready():
	rCurrent = 20
	rMax = 20
	gCurrent = 20
	gMax = 20
	bCurrent = 20
	bMax = 20
	
		
	$CardFront.texture = load("res://Assets/cards/images/card0.png")
	$CardFront.scale *= rect_size/$CardFront.texture.get_size()
	
	$VBoxContainer/RBarWGaps/RBar/TextureProgress.max_value = rMax
	$VBoxContainer/RBarWGaps/RBar/TextureProgress.value = rCurrent
	$VBoxContainer/RBarWGaps/RBar/Count/Background/Title.text = "HP"
	$VBoxContainer/RBarWGaps/RBar/Count/Background/Number.text = str(rCurrent)
	$VBoxContainer/RBarWGaps/RBar/TextureProgress.set_tint_progress(Color(0.68,0.16,0.16,1))
		
	$VBoxContainer/GBarWGaps/GBar/TextureProgress.max_value = gMax
	$VBoxContainer/GBarWGaps/GBar/TextureProgress.value = gCurrent
	$VBoxContainer/GBarWGaps/GBar/Count/Background/Title.text = "SP"
	$VBoxContainer/GBarWGaps/GBar/Count/Background/Number.text = str(gCurrent)
	$VBoxContainer/GBarWGaps/GBar/TextureProgress.set_tint_progress(Color(0.16,0.68,0.16,1))
	
	$VBoxContainer/BBarWGaps/BBar/TextureProgress.max_value = bMax
	$VBoxContainer/BBarWGaps/BBar/TextureProgress.value = bCurrent
	$VBoxContainer/BBarWGaps/BBar/Count/Background/Title.text = "MP"
	$VBoxContainer/BBarWGaps/BBar/Count/Background/Number.text = str(bCurrent)
	$VBoxContainer/BBarWGaps/BBar/TextureProgress.set_tint_progress(Color(0.16,0.32,0.68,1))
	
	
	pass # Replace with function body.

func manageHealth():
	
	rCurrent -= 5 
	gCurrent -= 5 
	bCurrent -= 5 
	$VBoxContainer/RBarWGaps/RBar/TextureProgress.value = rCurrent
	$VBoxContainer/GBarWGaps/GBar/TextureProgress.value = gCurrent
	$VBoxContainer/BBarWGaps/BBar/TextureProgress.value = bCurrent
	
	$VBoxContainer/RBarWGaps/RBar/Count/Background/Number.text = str(rCurrent)
	$VBoxContainer/GBarWGaps/GBar/Count/Background/Number.text = str(gCurrent)
	$VBoxContainer/BBarWGaps/BBar/Count/Background/Number.text = str(bCurrent)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
