const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum = constants.new().targetEnum
const statChars = constants.new().statChars

# card prefixes
# bb - Broken Bill only
# ss - stable Steve only
# un - universal

var card_data = {
	bbRedSelfMurder = set_body(
		"RedSelfMurder", "ouchies red", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, -30),
			set_action(life_pools.GREEN, targetEnum.SELF, 0),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0)
		]
	),
	bbGreenSelfMurder = set_body(
		"GreenSelfMurder", "ouchies green", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 0),
			set_action(life_pools.GREEN, targetEnum.SELF, -30),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0)
		]
	),
	bbBlueSelfMurder = set_body(
		"BlueSelfMurder", "ouchies blue", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 0),
			set_action(life_pools.BLUE, targetEnum.SELF, -30),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0)
		]
	),
	bbCard0 = set_body(
		"do nothing", "000000000", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 0),
			set_action(life_pools.GREEN, targetEnum.SELF, 0),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0)
		]
	),
	bbCardRedKill = set_body(
		"Red Kill", "Red murder you", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.GREEN, targetEnum.SINGLE, -30)
		]

	),
	bbCardGreenKill = set_body(
		"Green Kill", "Green murder you", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.GREEN, targetEnum.SINGLE, -30)
		]

	),
	bbCardBlueKill = set_body(
		"Blue Kill", "Blue murder you", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.BLUE, targetEnum.SINGLE, -30)
		]

	),
	unBaseShout = set_body(
		"Battle Cry", "Intimidate enemies, boost your adrenaline", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 2),
			set_action(life_pools.GREEN, targetEnum.SELF, -1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, -3)
		]
	),
	unBaseManaRelease = set_body(
		"Mana Release", "Easily manageable burst of mana", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.GREEN, targetEnum.SELF, 2),
			set_action(life_pools.BLUE, targetEnum.SELF, -1),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -3)
		]
	),
	unManaGeneration = set_body(
		"Mana Generation", "Punch so hard you gain mana out of thin air", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.BLUE, targetEnum.SELF, 2),
			set_action(life_pools.RED, targetEnum.SELF, -1),
			set_action(life_pools.RED, targetEnum.SINGLE, -3)
		]
	),
	unLifeHeal = set_body(
		"Health heal", "Sacrifice you health to gain mana and spirit", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.GREEN, targetEnum.SELF, 2),
			set_action(life_pools.BLUE, targetEnum.SELF, 2),
			set_action(life_pools.RED, targetEnum.SELF, -3)
		]
	),
	unMeditation = set_body(
		"Meditation", "Do you really have time for this?", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.GREEN, targetEnum.SELF, 4),
			set_action(life_pools.BLUE, targetEnum.SELF, 4),
			set_action(life_pools.RED, targetEnum.SELF, 4)
		]
	),
	unAwkwardPunch = set_body(
		"Awkward punch", "Is your arm supposed to bend that way?", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, -2),
			set_action(life_pools.RED, targetEnum.SINGLE, -6)
		]
	),
	unAgryPounce = set_body(
		"Angry pounce", "Painful and terrifying", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, -2),
			set_action(life_pools.GREEN, targetEnum.SELF, -2),
			set_action(life_pools.RED, targetEnum.SINGLE, -4),
			set_action(life_pools.GREEN, targetEnum.SINGLE, -2),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -2)
		]
	),

	unCastHeal = set_body(
		"Cast heal", "Accompanied by a satisfying 'ping'", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 8),
			set_action(life_pools.BLUE, targetEnum.SELF, -4)
		]
	),
	unSiphonHealth = set_body(
		"Siphon health", "An unstable incantation", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 4),
			set_action(life_pools.GREEN, targetEnum.SELF, -2),
			set_action(life_pools.BLUE, targetEnum.SELF, -3),
			set_action(life_pools.RED, targetEnum.SINGLE, -3),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -5)
		]
	),
	unCalmSpirit = set_body(
		"Calm Spirit", "Ohmmmmmm", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, 4),
			set_action(life_pools.BLUE, targetEnum.SELF, -3)
		]
	),
	unManaLeech = set_body(
		"Mana leech", "All shall feed your mana pool", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.BLUE, targetEnum.SELF, 8),
			set_action(life_pools.RED, targetEnum.SELF, -3),
			set_action(life_pools.GREEN, targetEnum.SELF, -3),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -3)
		]
	),
	unManaCrush = set_body(
		"Mana crush", "Rip out the mana of your opponent", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		[ # card actions
			set_action(life_pools.RED, targetEnum.SELF, 4),
			set_action(life_pools.GREEN, targetEnum.SELF, -3),
			set_action(life_pools.BLUE, targetEnum.SELF, -3),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -6)
		]
	),
}

func _init():
	pass

func get_card_data():
	return card_data


func set_body(
	new_name, new_description, new_source_front, new_source_back,
	#new_pre_player_phase, 
	# new_player_phase
	new_actions 
	#new_post_player_phase,
	#new_pre_enemy_phase, new_enemy_phase, new_post_enemy_phase
):
	return {
		card_name= new_name,
		description= new_description,
		source_front= new_source_front,
		source_back= new_source_back,
		#pre_player_phase= new_pre_player_phase,
		#player_phase= new_player_phase,
		actions= new_actions,
		#post_player_phase= new_post_player_phase,
		#pre_enemy_phase= new_pre_enemy_phase,
		#enemy_phase= new_enemy_phase,
		#post_enemy_phase= new_post_enemy_phase
	}

func set_action(
	new_pool, new_target, new_adjust, new_execute_times= 1, new_periodical_adjust = 0,
	new_number_of_rounds_adjust= 0, new_timer = 0, new_timer_adjust = 0
):
	return {
		pool= new_pool,
		adjust= new_adjust,
		periodical_adjust= new_periodical_adjust,
		number_of_rounds_adjust= new_number_of_rounds_adjust,
		target= new_target,
		execute_times= new_execute_times,
		timer= new_timer,
		timer_adjust= new_timer_adjust
	}

	
func preparePoolStrings(lines):
	var redLine = []
	var greenLine = []
	var blueLine = []
	
	for line in lines:
		var currentString = ""
		var current_adjust = line.adjust
		if (line.periodical_adjust > 0):
			currentString = str(currentString, statChars.specialChar)
			current_adjust = line.periodical_adjust
			
		if (line.timer_adjust > 0):
			currentString = str(currentString, statChars.specialChar)
			current_adjust = line.timer_adjust

		match (line.target):
			targetEnum.SELF:
				if (line.adjust> 0):
					currentString = str(currentString, statChars.lifeChar, current_adjust)
				else:
					currentString = str(currentString, statChars.costChar, abs(current_adjust))
			targetEnum.SINGLE:
				currentString = str(currentString, statChars.attackSingleChar, abs(current_adjust))
			targetEnum.RANDOM:
				currentString = str(currentString, statChars.attackRandomChar, abs(current_adjust))
			targetEnum.ALL:
				currentString = str(currentString, statChars.attackAllChar, abs(current_adjust))
				
		if (line.number_of_rounds_adjust > 0):
			currentString =+ (" " + statChars.roundsChar + line.number_of_rounds_adjust)
			
		if (line.execute_times > 1):
			currentString = str(currentString, " ", statChars.multipleChar, line.execute_times)
			
		if (line.timer > 0):
			currentString = str(currentString, " " + statChars.countDownChar, line.execute_times)
			
		match (line.pool):
			life_pools.RED:
				redLine.append(currentString)
			life_pools.GREEN:
				greenLine.append(currentString)
			life_pools.BLUE:
				blueLine.append(currentString)
			
	return {red= " ".join(PackedStringArray(redLine)), green= " ".join(PackedStringArray(greenLine)), blue= " ".join(PackedStringArray(blueLine))}
	

