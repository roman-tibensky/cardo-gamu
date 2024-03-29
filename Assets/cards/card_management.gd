#const life_pools = {
#	RED = "Red",
#	BLUE = "Blue",
#	GREEN = "Green"
#}

const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum = constants.new().targetEnum
const statChars = constants.new().statChars

#enum {card1,card2,card3,card4,card5,card6,card7,card8,card9,card10,card11,card12}



var card_data = {
	bbRedSelfMurder = set_body(
		"RedSelfMurder", "ouchies red", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card1.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, -30, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, 0, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	bbGreenSelfMurder = set_body(
		"GreenSelfMurder", "ouchies green", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card1.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 0, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -30, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	bbBlueSelfMurder = set_body(
		"BlueSelfMurder", "ouchies blue", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card1.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 0, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, -30, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	bbCard0 = set_body(
		"do nothing", "000000000", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card1.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 0, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, 0, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, 0, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	bbCardGreenKill = set_body(
		"Green Kill", "Imma murder you", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card1.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 2, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -1, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, -30, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card1 = set_body(
		"Card1", "Card1 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card2.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 2, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -1, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, -3, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card2 = set_body(
		"Card2", "Card2 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card2.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.GREEN, targetEnum.SELF, 2, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, -1, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -3, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card3 = set_body(
		"Card3", "Card3 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card3.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.BLUE, targetEnum.SELF, 2, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SELF, -1, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SINGLE, -3, 0, 0, 1)
		] 
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card4 = set_body(
		"Card4", "Card4 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card4.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.GREEN, targetEnum.SELF, 1, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, 4, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SELF, -3, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card5 = set_body(
		"Card5", "Card5 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card5.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.GREEN, targetEnum.SELF, 2, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, 2, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SELF, 2, 0, 0, 1)
		] 
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card6 = set_body(
		"Card6", "Card6 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card6.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, -3, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SINGLE, -6, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card7= set_body(
		"Card7", "Card7 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card7.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, -2, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -2, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SINGLE, -4, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SINGLE, -2, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -2, 0, 0, 1)
		] 
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),

	card8 = set_body(
		"Card8", "Card8 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card8.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 8, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, -4, 0, 0, 1)
		] 
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card9 = set_body(
		"Card9", "Card9 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card9.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 4, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -2, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, -3, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SINGLE, -3, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -5, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card10 = set_body(
		"Card10 ", "Card10  description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card10.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 1, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, 4, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, -3, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card11 = set_body(
		"Card11", "Card11 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card11.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.BLUE, targetEnum.SELF, 8, 0, 0, 1),
			set_action(life_pools.RED, targetEnum.SELF, -3, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -3, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -3, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
	),
	card12 = set_body(
		"Card12", "Card12 description", #Name, Description
		"res://Assets/cards/images/card0.png", #card front
		# "res://Assets/cards/images/card12.png", #card front
		"res://Assets/cards/images/card-back.png", # card back
		#[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, targetEnum.SELF, 4, 0, 0, 1),
			set_action(life_pools.GREEN, targetEnum.SELF, -3, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SELF, -3, 0, 0, 1),
			set_action(life_pools.BLUE, targetEnum.SINGLE, -6, 0, 0, 1)
		]
		#[], # post player phase
		#[], # pre enemy phase
		#[], # enemy phase
		#[] # post enemy phase
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
	

