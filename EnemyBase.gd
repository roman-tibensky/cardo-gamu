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
	
		
	$CardFront.texture = load("res://Assets/enemies/images/enemy1.png")
	$CardFront.scale *= rect_size/$CardFront.texture.get_size()
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgress.max_value = rMax
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgress.value = rCurrent
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Title.text = "HP"
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Number.text = str(rCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgress.set_tint_progress(Color(0.68,0.16,0.16,1))
		
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgress.max_value = gMax
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgress.value = gCurrent
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Title.text = "SP"
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Number.text = str(gCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgress.set_tint_progress(Color(0.16,0.68,0.16,1))
	
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgress.max_value = bMax
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgress.value = bCurrent
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Title.text = "MP"
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Number.text = str(bCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgress.set_tint_progress(Color(0.16,0.32,0.68,1))
	
	
	pass # Replace with function body.

func manageHealth():
	
	rCurrent -= 5 
	gCurrent -= 5 
	bCurrent -= 5 
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgress.value = rCurrent
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgress.value = gCurrent
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgress.value = bCurrent
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Number.text = str(rCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Number.text = str(gCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Number.text = str(bCurrent)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_FocusButton_mouse_entered():
	$CardFront.material.set_shader_param("onoff",1)
	$CardFront.material.set_shader_param("color",Color(0,255, 255, 255))


func _on_FocusButton_mouse_exited():
	$CardFront.material.set_shader_param("onoff",0)
