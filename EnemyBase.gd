extends MarginContainer

const constants = preload("res://constants.gd")
var life_pools = constants.new().life_pools

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
	poolCurrent[life_pools.RED] = enemy.maxRedPool
	poolMax[life_pools.RED] = enemy.maxRedPool
	poolCurrent[life_pools.GREEN] = enemy.maxGreenPool
	poolMax[life_pools.GREEN] = enemy.maxGreenPool
	poolCurrent[life_pools.BLUE] = enemy.maxBluePool
	poolMax[life_pools.BLUE] = enemy.maxBluePool
	
	$VBoxContainer/DescWGaps/DescContainer/CenterContainer/Description.text = enemy.description
	$VBoxContainer/NameWGaps/NameContainer/CenterContainer/Name.text = enemy.name  
	
		
	$EnemyBackround.texture = load("res://Assets/enemies/images/enemy1.png")
	$EnemyBackround.scale *= size/$EnemyBackround.texture.get_size()
	
	$VBoxContainer/StatsContainer/LifeContainer/RedBarWGaps/Bar/TextureProgressBar.max_value = poolMax[life_pools.RED]
	$VBoxContainer/StatsContainer/LifeContainer/RedBarWGaps/Bar/TextureProgressBar.value = poolCurrent[life_pools.RED]
	$VBoxContainer/StatsContainer/LifeContainer/RedBarWGaps/Bar/Count/Background/Title.text = "HP"
	$VBoxContainer/StatsContainer/LifeContainer/RedBarWGaps/Bar/Count/Background/Number.text = str(poolCurrent[life_pools.RED])
	$VBoxContainer/StatsContainer/LifeContainer/RedBarWGaps/Bar/TextureProgressBar.set_tint_progress(Color(0.68,0.16,0.16,1))
		
	$VBoxContainer/StatsContainer/LifeContainer/GreenBarWGaps/Bar/TextureProgressBar.max_value = poolMax[life_pools.GREEN]
	$VBoxContainer/StatsContainer/LifeContainer/GreenBarWGaps/Bar/TextureProgressBar.value = poolCurrent[life_pools.GREEN]
	$VBoxContainer/StatsContainer/LifeContainer/GreenBarWGaps/Bar/Count/Background/Title.text = "SP"
	$VBoxContainer/StatsContainer/LifeContainer/GreenBarWGaps/Bar/Count/Background/Number.text = str(poolCurrent[life_pools.GREEN])
	$VBoxContainer/StatsContainer/LifeContainer/GreenBarWGaps/Bar/TextureProgressBar.set_tint_progress(Color(0.16,0.68,0.16,1))
	
	$VBoxContainer/StatsContainer/LifeContainer/BlueBarWGaps/Bar/TextureProgressBar.max_value = poolMax[life_pools.BLUE]
	$VBoxContainer/StatsContainer/LifeContainer/BlueBarWGaps/Bar/TextureProgressBar.value = poolCurrent[life_pools.BLUE]
	$VBoxContainer/StatsContainer/LifeContainer/BlueBarWGaps/Bar/Count/Background/Title.text = "MP"
	$VBoxContainer/StatsContainer/LifeContainer/BlueBarWGaps/Bar/Count/Background/Number.text = str(poolCurrent[life_pools.BLUE])
	$VBoxContainer/StatsContainer/LifeContainer/BlueBarWGaps/Bar/TextureProgressBar.set_tint_progress(Color(0.16,0.32,0.68,1))
	
	generateActions()
	pass
	
	
func switchToNextAction():
	print(actionStage)
	actionStage = (actionStage + 1) % enemy.actions.size()
	print(actionStage)
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
	$VBoxContainer/StatsContainer/ActionContainer/RedActionWGap/RedActionContainer/CenterContainer/Action.text = poolsText.red
	$VBoxContainer/StatsContainer/ActionContainer/GreenActionWGap/GreenActionContainer/CenterContainer/Action.text = poolsText.green
	$VBoxContainer/StatsContainer/ActionContainer/BlueActionWGap/BlueActionContainer/CenterContainer/Action.text = poolsText.blue

func manageHealth(pool, alteration):
	alterHealthWLimitCheck(pool, alteration)
	
	$VBoxContainer/StatsContainer/LifeContainer.get_node(pool + "BarWGaps/Bar/TextureProgressBar").value = poolCurrent[pool]
	$VBoxContainer/StatsContainer/LifeContainer.get_node(pool + "BarWGaps/Bar/Count/Background/Number").text = str(poolCurrent[pool])
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
