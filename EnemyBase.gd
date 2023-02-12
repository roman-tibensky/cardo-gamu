extends MarginContainer

@onready var EnemiesData = preload("res://Assets/enemies/enemy_management.gd")
var enemyData
var enemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var poolCurrent = {}
var poolMax = {}
var poolModCurrent = {}

var actionStage = 0
var onoff = 0
var highlightColor

func _ready():
	enemyData = EnemiesData.new()
	pass


# Called when the node enters the scene tree for the first time.
func setup_enemy(enemySetup):
	enemy = enemySetup
	poolCurrent["RED"] = enemy.maxRedPool
	poolMax["RED"] = enemy.maxRedPool
	poolCurrent["GREEN"] = enemy.maxGreenPool
	poolMax["GREEN"] = enemy.maxGreenPool
	poolCurrent["BLUE"] = enemy.maxBluePool
	poolMax["BLUE"] = enemy.maxBluePool
	
	$VBoxContainer/DescWGaps/DescContainer/CenterContainer/Description.text = enemy.description
	$VBoxContainer/NameWGaps/NameContainer/CenterContainer/Name.text = enemy.name  
	
		
	$EnemyBackround.texture = load("res://Assets/enemies/images/enemy1.png")
	$EnemyBackround.scale *= size/$EnemyBackround.texture.get_size()
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.max_value = poolMax["RED"]
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.value = poolCurrent["RED"]
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Title.text = "HP"
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Number.text = str(poolCurrent["RED"])
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.set_tint_progress(Color(0.68,0.16,0.16,1))
		
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.max_value = poolMax["GREEN"]
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.value = poolCurrent["GREEN"]
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Title.text = "SP"
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Number.text = str(poolCurrent["GREEN"])
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.set_tint_progress(Color(0.16,0.68,0.16,1))
	
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.max_value = poolMax["BLUE"]
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.value = poolCurrent["BLUE"]
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Title.text = "MP"
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Number.text = str(poolCurrent["BLUE"])
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.set_tint_progress(Color(0.16,0.32,0.68,1))
	
	generateActions()
	pass
	
	
func switchToNextAction():
	actionStage += 1
	generateActions()
	
func highlightMangement(isHighlighted):
	if isHighlighted:
		onoff = 1
		highlightColor = Color(1, 0.39, 0.39, 255)
		$EnemyBackround.material.set_shader_parameter("onoff",onoff)
		$EnemyBackround.material.set_shader_parameter("color",highlightColor)
	else:
		onoff = 0
		$EnemyBackround.material.set_shader_parameter("onoff",onoff)
	
	
func generateActions():
	var poolsText = enemyData.preparePoolStrings(enemy.actions[actionStage])
	$VBoxContainer/StatsContainer/ActionContainer/RedActionWGap/RedActionContainer/CenterContainer/RedAction.text = poolsText.red
	$VBoxContainer/StatsContainer/ActionContainer/GreenActionWGap/GreenActionContainer/CenterContainer/GreenAction.text = poolsText.green
	$VBoxContainer/StatsContainer/ActionContainer/BlueActionWGap/BlueActionContainer/CenterContainer/BlueAction.text = poolsText.blue

func manageHealth(pool, alteration):
	alterHealthWLimitCheck(pool, alteration)
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/TextureProgressBar.value = poolCurrent["RED"]
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/TextureProgressBar.value = poolCurrent["GREEN"]
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/TextureProgressBar.value = poolCurrent["BLUE"]
	
	$VBoxContainer/StatsContainer/LifeContainer/RBarWGaps/RBar/Count/Background/Number.text = str(poolCurrent["RED"])
	$VBoxContainer/StatsContainer/LifeContainer/GBarWGaps/GBar/Count/Background/Number.text = str(poolCurrent["GREEN"])
	$VBoxContainer/StatsContainer/LifeContainer/BBarWGaps/BBar/Count/Background/Number.text = str(poolCurrent["BLUE"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_FocusButton_mouse_entered():
	$EnemyBackround.material.set_shader_parameter("onoff",onoff)
	$EnemyBackround.material.set_shader_parameter("color",Color(1, 0, 0, 255))


func _on_FocusButton_mouse_exited():
	$EnemyBackround.material.set_shader_parameter("onoff",onoff)
	$EnemyBackround.material.set_shader_parameter("color",highlightColor)
	
func alterHealthWLimitCheck(pool, alteration):
	if(poolCurrent[pool] + alteration <=0):
		#TODO: desu-troy
		pass
	elif((poolCurrent[pool] + alteration > poolMax[pool])):
		poolCurrent[pool] = poolMax[pool]
	else:
		poolCurrent[pool] += alteration
