extends MarginContainer

const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum = constants.new().targetEnum
const deathMessageSelfDestruct = constants.new().deathMessageSelfDestruct

var PlayerManagement = preload("res://Assets/player/player_management.gd")
var playerManagement
var playerData
var characterId
signal gameOver


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var poolCurrent = {}
var poolMax = {}
var poolModCurrent = {}
var isAlive

func _ready():
	playerManagement = PlayerManagement.new()
	#setup_player()
	pass


# Called when the node enters the scene tree for the first time.
func setup_player(char):
	isAlive = true
	characterId = char
	playerData = playerManagement.characterData[characterId]
	poolCurrent[life_pools.RED] = playerData.redStarting
	poolMax[life_pools.RED] = playerData.redMaxPool
	poolModCurrent[life_pools.RED] = playerData.redModifierStarting
	
	poolCurrent[life_pools.GREEN] = playerData.greenStarting
	poolMax[life_pools.GREEN] = playerData.greenMaxPool
	poolModCurrent[life_pools.GREEN] = playerData.greenModifierStarting
	
	poolCurrent[life_pools.BLUE] = playerData.blueStarting
	poolMax[life_pools.BLUE] = playerData.blueMaxPool
	poolModCurrent[life_pools.BLUE] = playerData.blueModifierStarting
	
		
	#$PlayerBackround.texture = load("res://Assets/enemies/images/player1.png")
	#$PlayerBackround.scale *= size/$PlayerBackround.texture.get_size()
	
	$VBoxContainer/LifeContainer/RedBarWGaps/Bar/TextureProgressBar.max_value = poolMax[life_pools.RED]
	$VBoxContainer/LifeContainer/RedBarWGaps/Bar/TextureProgressBar.value = poolCurrent[life_pools.RED]
	$VBoxContainer/LifeContainer/RedBarWGaps/Bar/Count/Background/Title.text = "HP"
	$VBoxContainer/LifeContainer/RedBarWGaps/Bar/Count/Background/Number.text = str(poolCurrent[life_pools.RED])
	$VBoxContainer/LifeContainer/RedBarWGaps/Bar/TextureProgressBar.set_tint_progress(Color(0.68,0.16,0.16,1))
		
	$VBoxContainer/LifeContainer/GreenBarWGaps/Bar/TextureProgressBar.max_value = poolMax[life_pools.GREEN]
	$VBoxContainer/LifeContainer/GreenBarWGaps/Bar/TextureProgressBar.value = poolCurrent[life_pools.GREEN]
	$VBoxContainer/LifeContainer/GreenBarWGaps/Bar/Count/Background/Title.text = "SP"
	$VBoxContainer/LifeContainer/GreenBarWGaps/Bar/Count/Background/Number.text = str(poolCurrent[life_pools.GREEN])
	$VBoxContainer/LifeContainer/GreenBarWGaps/Bar/TextureProgressBar.set_tint_progress(Color(0.16,0.68,0.16,1))
	
	$VBoxContainer/LifeContainer/BlueBarWGaps/Bar/TextureProgressBar.max_value = poolMax[life_pools.BLUE]
	$VBoxContainer/LifeContainer/BlueBarWGaps/Bar/TextureProgressBar.value = poolCurrent[life_pools.BLUE]
	$VBoxContainer/LifeContainer/BlueBarWGaps/Bar/Count/Background/Title.text = "MP"
	$VBoxContainer/LifeContainer/BlueBarWGaps/Bar/Count/Background/Number.text = str(poolCurrent[life_pools.BLUE])
	$VBoxContainer/LifeContainer/BlueBarWGaps/Bar/TextureProgressBar.set_tint_progress(Color(0.16,0.32,0.68,1))




	
func manageHealth(pool, alteration, message = ""):
	alterHealthWLimitCheck(pool, alteration, message)
	$VBoxContainer/LifeContainer.get_node(pool + "BarWGaps/Bar/Count/Background/Number").text = str(poolCurrent[pool])
	$VBoxContainer/LifeContainer.get_node(pool + "BarWGaps/Bar/TextureProgressBar").value = poolCurrent[pool]
	
	
func takeAction():
	alterHealthWLimitCheck(life_pools.RED, playerData.redModifierAction, playerData.name + deathMessageSelfDestruct[life_pools.RED])
	alterHealthWLimitCheck(life_pools.GREEN, playerData.greenModifierAction, playerData.name + deathMessageSelfDestruct[life_pools.GREEN])
	alterHealthWLimitCheck(life_pools.BLUE, playerData.blueModifierAction, playerData.name + deathMessageSelfDestruct[life_pools.BLUE])

func alterHealthWLimitCheck(pool, alteration, deathMessage):
	if(poolCurrent[pool] + alteration <=0):
		#TODO: implement GOLEM, UNDEAD, SPIRIT states
		isAlive = false
		gameOver.emit(deathMessage)
	elif((poolCurrent[pool] + alteration > poolMax[pool])):
		poolCurrent[pool] = poolMax[pool]
	else:
		poolCurrent[pool] += alteration
	
