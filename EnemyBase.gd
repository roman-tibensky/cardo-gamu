extends MarginContainer

@onready var EnemiesData = preload("res://Assets/enemies/enemy_management.gd")
var enemyData
var enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rCurrent
var rMax

var gCurrent
var gMax

var bCurrent
var bMax

var actionStage = 0

func _ready():
	enemyData = EnemiesData.new()
	pass


# Called when the node enters the scene tree for the first time.
func setup_enemy(enemySetup):
	enemy = enemySetup
	rCurrent = enemy.maxRedPool
	rMax = enemy.maxRedPool
	gCurrent = enemy.maxGreenPool
	gMax = enemy.maxGreenPool
	bCurrent = enemy.maxBluePool
	bMax = enemy.maxBluePool
	
	$VBoxContainer/DescWGaps/DescContainer/CenterContainer/Description.text = enemy.description
	$VBoxContainer/NameWGaps/NameContainer/CenterContainer/Name.text = enemy.name  
	
		
	$EnemyBackround.texture = load("res://Assets/enemies/images/enemy1.png")
	$EnemyBackround.scale *= size/$EnemyBackround.texture.get_size()
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.max_value = rMax
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.value = rCurrent
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Title.text = "HP"
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Number.text = str(rCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.set_tint_progress(Color(0.68,0.16,0.16,1))
		
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.max_value = gMax
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.value = gCurrent
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Title.text = "SP"
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Number.text = str(gCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.set_tint_progress(Color(0.16,0.68,0.16,1))
	
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.max_value = bMax
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.value = bCurrent
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Title.text = "MP"
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Number.text = str(bCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.set_tint_progress(Color(0.16,0.32,0.68,1))
	
	generateActions()
	pass
	
	
func switchToNextAction():
	actionStage += 1
	generateActions()
	
func generateActions():
	var poolsText = enemyData.preparePoolStrings(enemy.actions[actionStage])
	$VBoxContainer/StatsContainer/ActionContainer/RedActionWGap/RedActionContainer/CenterContainer/RedAction.text = poolsText.red
	$VBoxContainer/StatsContainer/ActionContainer/GreenActionWGap/GreenActionContainer/CenterContainer/GreenAction.text = poolsText.green
	$VBoxContainer/StatsContainer/ActionContainer/BlueActionWGap/BlueActionContainer/CenterContainer/BlueAction.text = poolsText.blue

func manageHealth():
	
	rCurrent -= 5 
	gCurrent -= 5 
	bCurrent -= 5 
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.value = rCurrent
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.value = gCurrent
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.value = bCurrent
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Number.text = str(rCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Number.text = str(gCurrent)
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Number.text = str(bCurrent)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_FocusButton_mouse_entered():
	$EnemyBackround.material.set_shader_parameter("onoff",1)
	$EnemyBackround.material.set_shader_parameter("color",Color(1, 0.39, 0.39, 255))


func _on_FocusButton_mouse_exited():
	$EnemyBackround.material.set_shader_parameter("onoff",0)
