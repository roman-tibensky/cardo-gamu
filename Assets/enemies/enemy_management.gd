
const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools

const targetEnum =  constants.new().targetEnum
const statChars = constants.new().statChars

# enemy prefixes
# bb - Broken Bill only
# ss - stable Steve only
# un - universal

var enemy_data = {
	bbMurderlator = set_body(
		"Murderlator", "Is definitely something you want to kill let me tell you", #Name, Description
		" got murderlized by the Murderlator", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		15,15,15, #RED, GREEN, BLUE health

		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -60),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -6),
				set_action(life_pools.BLUE, targetEnum.SINGLE, -6),
				set_action(life_pools.GREEN, targetEnum.SELF, -1),
				set_action(life_pools.BLUE, targetEnum.SELF, -2)
			],
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -1),
				set_action(life_pools.GREEN, targetEnum.SELF, 1),
				set_action(life_pools.BLUE, targetEnum.SELF, 1)
			],
			[
				set_action(life_pools.GREEN, targetEnum.SELF, 2),
				set_action(life_pools.BLUE, targetEnum.SELF, 1)
			]
		]
	),
	unRat = set_body(
		"Rat", "Watch out or it will tell on you", #Name, Description
		" got nibbled to death byt a rat", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		5,5,5, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -2)
			],
			[
				set_action(life_pools.RED, targetEnum.SELF, -1),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -5)
			]
		]
	),
	unWisp = set_body(
		"Will-o-Wisp", "Likes to play pranks, does not know when to stop", #Name, Description
		" got whisked away by a wisp", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		6,7,10, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.GREEN, targetEnum.SINGLE, -5),
				set_action(life_pools.BLUE, targetEnum.SELF, -3),
			],
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -1),
				set_action(life_pools.BLUE, targetEnum.SELF, -3),
			]
		]
	),
	un8Ball = set_body(
		"Magic 8 Ball", "Aggravated by all the shaking", #Name, Description
		"'s future is hazy. Ask again later", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		25,8,15, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.BLUE, targetEnum.SINGLE, -2),
				set_action(life_pools.BLUE, targetEnum.SELF, -2),
			]
		]
	),
	unWolf = set_body(
		"Wolf", "Upset that the moon won't respond", #Name, Description
		" be came a wolf's din-din", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		10, 15, 8, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -2)
			],
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -2, 2),
				set_action(life_pools.GREEN, targetEnum.SELF, -2),
			],
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -2, 3),
				set_action(life_pools.GREEN, targetEnum.SELF, -4),
			]
		]
	),
	unBoomBug = set_body(
		"Giant Exploding Bug", "Aww, look, it's following you around!", #Name, Description
		" became one with the fireworks", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		20,20,20, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SELF, 0),
				set_action(life_pools.GREEN, targetEnum.SELF, 0),
				set_action(life_pools.BLUE, targetEnum.SELF, 0),
			],
			[
				set_action(life_pools.RED, targetEnum.SELF, 0),
				set_action(life_pools.GREEN, targetEnum.SELF, 0),
				set_action(life_pools.BLUE, targetEnum.SELF, 0),
			],
			[
				set_action(life_pools.RED, targetEnum.SELF, 0),
				set_action(life_pools.GREEN, targetEnum.SELF, 0),
				set_action(life_pools.BLUE, targetEnum.SELF, 0),
			],
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -50),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -50),
				set_action(life_pools.BLUE, targetEnum.SINGLE, -50)
			]
		]
	),
	unSpider = set_body( #TODO: implement damage over time
		"Giant Spider", "Contractually obligated to appear", #Name, Description
		" did not gain super powers after being bitten", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		15,10,10, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -1),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -2),
				set_action(life_pools.BLUE, targetEnum.SINGLE, -3),
			],
			[
				set_action(life_pools.RED, targetEnum.SELF, -2),
				set_action(life_pools.BLUE, targetEnum.SELF, -2)
			]
		]
	),
	unEye = set_body(
		"Large floating eyeball", "Desperate for eye drops", #Name, Description
		" got stared down and died of embarrasment", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		15,15,25, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.BLUE, targetEnum.SINGLE, -1),
				set_action(life_pools.GREEN, targetEnum.SINGLE, -1),
				set_action(life_pools.RED, targetEnum.SELF, 2),
				set_action(life_pools.GREEN, targetEnum.SELF, 2),
			]
		]
	),
	unZombie = set_body( # TODO: Implement partially dead state
		"Zombie", "Seen better days", #Name, Description
		" found out he had a brain after all", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		20, 10, 20, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SELF, 3),
				set_action(life_pools.RED, targetEnum.SINGLE, -3),
			]
		]
	),
	unHealingPool = set_body(
		"Healing Pool", "Take a rest, you've earned it", #Name, Description
		" achieved the impossible", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		5,5,5, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SINGLE, 5),
				set_action(life_pools.GREEN, targetEnum.SINGLE, 5),
				set_action(life_pools.BLUE, targetEnum.SINGLE, 5),
				set_action(life_pools.RED, targetEnum.SELF, -5),
				set_action(life_pools.GREEN, targetEnum.SELF, -5),
				set_action(life_pools.BLUE, targetEnum.SELF, -5),
			]
		]
	),
	unThugBoss = set_body(
		"Thug Leader", "Sad and alone - thug union is on strike", #Name, Description
		" got nibbled to death byt a rat", #death message
		"res://Assets/enemies/images/enemy1.png", #enemy background
		20,20,20, #RED, GREEN, BLUE health
		[ #actions to be cycled through after round end
			[
				set_action(life_pools.RED, targetEnum.SINGLE, -5),
				set_action(life_pools.RED, targetEnum.SELF, -1),
				set_action(life_pools.GREEN, targetEnum.SELF, -1),
			],
			[
				set_action(life_pools.BLUE, targetEnum.SINGLE, -2),
				set_action(life_pools.GREEN, targetEnum.SELF, -1),
			],
			[
				set_action(life_pools.GREEN, targetEnum.SINGLE, -1, 3),
				set_action(life_pools.GREEN, targetEnum.SELF, -1),
			],
			[
				set_action(life_pools.RED, targetEnum.SELF, 2),
				set_action(life_pools.GREEN, targetEnum.SELF, 2),
				set_action(life_pools.BLUE, targetEnum.SELF, 2),
				set_action(life_pools.GREEN, targetEnum.SELF, -1),
			]
		]
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
	new_pool, new_target, new_adjust, new_execute_times= 1, new_periodical_adjust = 0,
	new_number_of_rounds_adjust = 0, new_timer = 0, new_timer_adjust = 0
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
					currentString = str(currentString, statChars.giveLife, abs(current_adjust))
				else:
					currentString = str(currentString, statChars.attackSingleChar, abs(current_adjust))
				
		if (line.number_of_rounds_adjust > 0):
			currentString =+ (" " + statChars.roundsChar + line.number_of_rounds_adjust)
			
		if (line.execute_times > 1):
			currentString = str(currentString, statChars.multipleChar, line.execute_times)
			
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
	
