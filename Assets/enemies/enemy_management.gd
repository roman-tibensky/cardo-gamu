
const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools

const targetEnum =  constants.new().targetEnum
const statChars = constants.new().statChars



var enemy_data = {
	bbEnemy1 = set_body(
		"Enemy 1", "Is definitely something you want to kill let me tell you", #Name, Description
		" got murderlized by Enemy 1", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		15,15,15, #RED, GREEN, BLUE health

		#[], #pre player phase
		[ #actions to be cycled through
			[ # player phase
				set_action(life_pools.RED, targetEnum.SINGLE, -60, 0, 0, 1),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -6, 0, 0, 1),
				set_action(life_pools.BLUE, targetEnum.SINGLE, -6, 0, 0, 1),
				set_action(life_pools.GREEN, targetEnum.SELF, -1, 0, 0, 1),
				set_action(life_pools.BLUE, targetEnum.SELF, -2, 0, 0, 1)
			],
			[ # player phase
				set_action(life_pools.RED, targetEnum.SINGLE, -1, 0, 0, 1),
				set_action(life_pools.GREEN, targetEnum.SELF, 1, 0, 0, 1),
				set_action(life_pools.BLUE, targetEnum.SELF, 1, 0, 0, 1)
			],
			[ # player phase
				set_action(life_pools.GREEN, targetEnum.SELF, 2, 0, 0, 1),
				set_action(life_pools.BLUE, targetEnum.SELF, 1, 0, 0, 1)
			]
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	ssRat = set_body(
		"Rat", "Watch out or he will tell on you", #Name, Description
		" got nibbled to death byt a rat", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		5,5,5, #RED, GREEN, BLUE health

		#[], #pre player phase
		[ #actions to be cycled through
			[ # player phase
				set_action(life_pools.RED, targetEnum.SINGLE, -2, 0, 0, 1)
			],
			[ # player phase
				set_action(life_pools.RED, targetEnum.SELF, -1, 0, 0, 1),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -5, 0, 0, 1)
			]
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	)
}

func get_enemy_data():
	return enemy_data


func set_body(
	new_name, new_description, new_death_message, new_source_front,
	new_maxRedPool, new_maxGreenPool, new_maxBluePool,
	#new_pre_player_phase, 
	# new_player_phase
	new_cycle_of_actions 
	#new_post_player_phase,
	#new_pre_enemy_phase, new_enemy_phase, new_post_enemy_phase
):
	return {
		name= new_name,
		description= new_description,
		deathMessage = new_death_message,
		source_front= new_source_front,
		maxRedPool= new_maxRedPool,
		maxGreenPool= new_maxGreenPool,
		maxBluePool= new_maxBluePool,
		#pre_player_phase= new_pre_player_phase,
		#player_phase= new_player_phase,
		actions= new_cycle_of_actions,
		#post_player_phase= new_post_player_phase,
		#pre_enemy_phase= new_pre_enemy_phase,
		#enemy_phase= new_enemy_phase,
		#post_enemy_phase= new_post_enemy_phase
	}

func set_action(
	new_pool, new_target, new_adjust, new_periodical_adjust,
	new_number_of_rounds_adjust, new_execute_times= 1, new_timer = 0, new_timer_adjust = 0
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
				if (line.adjust> 0):
					#TODO: shouldn't happen?
					currentString = str(currentString, "!!", current_adjust)
				else:
					currentString = str(currentString, statChars.attackSingleChar, abs(current_adjust))
				
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
	
