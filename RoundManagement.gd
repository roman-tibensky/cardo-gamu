extends MarginContainer


const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum = constants.new().targetEnum

signal action_modification(pool, mod)

@onready var PlayerManagement = preload("res://Assets/player/player_management.gd")
var playerManagement
var player
var poolModCurrent = {}
var poolMod = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	playerManagement = PlayerManagement.new()
	setup_player_modifiers()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func setup_player_modifiers():
	
	player = playerManagement.playerData.player1
	poolModCurrent[life_pools.RED] = player.redModifierStarting
	poolModCurrent[life_pools.GREEN] = player.greenModifierStarting
	poolModCurrent[life_pools.BLUE] = player.blueModifierStarting
	poolMod[life_pools.RED] = player.redModifierAction
	poolMod[life_pools.GREEN] = player.greenModifierAction
	poolMod[life_pools.BLUE] = player.blueModifierAction
	
	$RoundInfoContainer/PoolsWGap/RedActionContainer/CenterContainer/PoolMod.text = str(poolModCurrent[life_pools.RED])
	$RoundInfoContainer/ActionModifiersPoolsWGap/RedActionContainer/CenterContainer/PoolMod.text = str(poolMod[life_pools.RED])

	$RoundInfoContainer/PoolsWGap/GreenActionContainer/CenterContainer/PoolMod.text = str(poolModCurrent[life_pools.GREEN])
	#$VBoxContainer/StatsContainer/RoundInfoContainer/ActionModifiersPoolsWGap/GreenActionContainer/CenterContainer/PoolMod.text = str(player.greenModifierAction)
	$RoundInfoContainer/ActionModifiersPoolsWGap.get_node("GreenActionContainer/CenterContainer/PoolMod").text = str(poolMod[life_pools.GREEN])

	$RoundInfoContainer/PoolsWGap/BlueActionContainer/CenterContainer/PoolMod.text = str(poolModCurrent[life_pools.BLUE])
	$RoundInfoContainer/ActionModifiersPoolsWGap/BlueActionContainer/CenterContainer/PoolMod.text = str(poolMod[life_pools.BLUE])

func actionUpdate():
	for pool in life_pools:
		if poolModCurrent[life_pools[pool]] < 0:
			action_modification.emit(life_pools[pool], poolModCurrent[life_pools[pool]])
		
		poolModCurrent[life_pools[pool]] += poolMod[life_pools[pool]]
		$RoundInfoContainer/PoolsWGap.get_node(life_pools[pool] + "ActionContainer/CenterContainer/PoolMod").text = str(poolModCurrent[life_pools[pool]])


