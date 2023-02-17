extends MarginContainer

const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum = constants.new().targetEnum

@onready var PlayerManagement = preload("res://Assets/player/player_management.gd")
var playerManagement
var player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var poolCurrent = {}
var poolMax = {}
var poolModCurrent = {}

var actionStage = 0

func _ready():
	playerManagement = PlayerManagement.new()
	setup_player()
	pass


# Called when the node enters the scene tree for the first time.
func setup_player():
	player = playerManagement.playerData.player1
	poolCurrent[life_pools.RED] = player.redStarting
	poolMax[life_pools.RED] = player.redMaxPool
	poolModCurrent[life_pools.RED] = player.redModifierStarting
	
	poolCurrent[life_pools.GREEN] = player.greenStarting
	poolMax[life_pools.GREEN] = player.greenMaxPool
	poolModCurrent[life_pools.GREEN] = player.greenModifierStarting
	
	poolCurrent[life_pools.BLUE] = player.blueStarting
	poolMax[life_pools.BLUE] = player.blueMaxPool
	poolModCurrent[life_pools.BLUE] = player.blueModifierStarting
	
		
	#$PlayerBackround.texture = load("res://Assets/enemies/images/player1.png")
	#$PlayerBackround.scale *= size/$PlayerBackround.texture.get_size()
	
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


	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/RedActionContainer/CenterContainer/PoolMod.text = str(poolCurrent[life_pools.RED])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/RedActionContainer/CenterContainer/PoolMod.text = str(player.redModifierAction)

	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/GreenActionContainer/CenterContainer/PoolMod.text = str(poolCurrent[life_pools.GREEN])
	#$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/GreenActionContainer/CenterContainer/PoolMod.text = str(player.greenModifierAction)
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap.get_node("GreenActionContainer/CenterContainer/PoolMod").text = str(player.greenModifierAction)

	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/BlueActionContainer/CenterContainer/PoolMod.text = str(poolCurrent[life_pools.BLUE])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/BlueActionContainer/CenterContainer/PoolMod.text = str(player.blueModifierAction)

	
func manageHealth(pool, alteration):
	alterHealthWLimitCheck(pool, alteration)
	$VBoxContainer/StatsContainer/LifeContainer.get_node(pool + "BarWGaps/Bar/Count/Background/Number").text = str(poolCurrent[pool])
	$VBoxContainer/StatsContainer/LifeContainer.get_node(pool + "BarWGaps/Bar/TextureProgressBar").value = poolCurrent[pool]
	
	
func takeAction():
	if (poolCurrent[life_pools.RED] < 0):
		alterHealthWLimitCheck(life_pools.RED, player.redModifierAction)
		
	poolCurrent[life_pools.RED] += player.redModifierAction
	
	if (poolCurrent[life_pools.GREEN] < 0):
		alterHealthWLimitCheck(life_pools.GREEN, player.greenModifierAction)
		
	poolCurrent[life_pools.GREEN] += player.greenModifierAction
	
	if (poolCurrent[life_pools.BLUE] < 0):
		alterHealthWLimitCheck(life_pools.BLUE, player.blueModifierAction)
		
	poolCurrent[life_pools.BLUE] += player.blueModifierAction

func alterHealthWLimitCheck(pool, alteration):
	if(poolCurrent[pool] + alteration <=0):
		#TODO: desu-troy
		pass
	elif((poolCurrent[pool] + alteration > poolMax[pool])):
		poolCurrent[pool] = poolMax[pool]
	else:
		poolCurrent[pool] += alteration
	
