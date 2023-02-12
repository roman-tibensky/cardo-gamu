extends MarginContainer

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
	poolCurrent["RED"] = player.redStarting
	poolMax["RED"] = player.redMaxPool
	poolModCurrent["RED"] = player.redModifierStarting
	
	poolCurrent["GREEN"] = player.greenStarting
	poolMax["GREEN"] = player.greenMaxPool
	poolModCurrent["GREEN"] = player.greenModifierStarting
	
	poolCurrent["BLUE"] = player.blueStarting
	poolMax["BLUE"] = player.blueMaxPool
	poolModCurrent["BLUE"] = player.blueModifierStarting
	
		
	#$PlayerBackround.texture = load("res://Assets/enemies/images/player1.png")
	#$PlayerBackround.scale *= size/$PlayerBackround.texture.get_size()
	
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


	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/RedActionContainer/CenterContainer/RedPoolMod.text = str(poolCurrent["RED"])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/RedActionContainer/CenterContainer/RedPoolMod.text = str(player.redModifierAction)

	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/GreenActionContainer/CenterContainer/GreenPoolMod.text = str(poolCurrent["GREEN"])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/GreenActionContainer/CenterContainer/GreenPoolMod.text = str(player.greenModifierAction)

	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/BlueActionContainer/CenterContainer/BluePoolMod.text = str(poolCurrent["BLUE"])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/BlueActionContainer/CenterContainer/BluePoolMod.text = str(player.blueModifierAction)
	
	
	
	pass
	
func manageHealth(pool, alteration):
	alterHealthWLimitCheck(pool, alteration)
	
	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/RedActionContainer/CenterContainer/RedPoolMod.text = str(poolCurrent["RED"])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/RedActionContainer/CenterContainer/RedPoolMod.text = str(player.redModifierAction)

	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/GreenActionContainer/CenterContainer/GreenPoolMod.text = str(poolCurrent["GREEN"])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/GreenActionContainer/CenterContainer/GreenPoolMod.text = str(player.greenModifierAction)

	$VBoxContainer/StatsContainer/RoundInfoContainer/PoolsWGap/BlueActionContainer/CenterContainer/BluePoolMod.text = str(poolCurrent["BLUE"])
	$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/BlueActionContainer/CenterContainer/BluePoolMod.text = str(player.blueModifierAction)

func takeAction():
	if (poolCurrent["RED"] < 0):
		alterHealthWLimitCheck("RED", player.redModifierAction)
		
	poolCurrent["RED"] += player.redModifierAction
	
	if (poolCurrent["GREEN"] < 0):
		alterHealthWLimitCheck("GREEN", player.greenModifierAction)
		
	poolCurrent["GREEN"] += player.greenModifierAction
	
	if (poolCurrent["BLUE"] < 0):
		alterHealthWLimitCheck("BLUE", player.blueModifierAction)
		
	poolCurrent["BLUE"] += player.blueModifierAction

func alterHealthWLimitCheck(pool, alteration):
	if(poolCurrent[pool] + alteration <=0):
		#TODO: desu-troy
		pass
	elif((poolCurrent[pool] + alteration > poolMax[pool])):
		poolCurrent[pool] = poolMax[pool]
	else:
		poolCurrent[pool] += alteration
	
