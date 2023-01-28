enum life_pools {RED, BLUE, GREEN}
enum target {SINGLE, SELF}

const lifeChar = "+" #"\u2764"
const costChar = "\u2620"
const attackSingleChar = "\u2316"
const attackRandomChar = "\u26A1"
const attackAllChar = "\u2748" #bomb alternative \u1F4A3
const roundsChar = "R"
const specialChar = "*"
const multipleChar = "x"
const countDownChar = "T"


var enemy_data = {
	enemy1 = set_body(
		"Enemy 1", "Is definitely something you want to kill let me tell you", #Name, Description
		"res://Assets/enemies/images/enemy1.png", #enemy background
		15,15,15, #RED, GREEN, BLUE health

		#[], #pre player phase
		[ #actions to be cycled through
			[ # player phase
				set_action(life_pools.RED, target.SINGLE, 6, 0, 0, 1),
				set_action(life_pools.GREEN, target.SELF, -1, 0, 0, 1),
				set_action(life_pools.BLUE, target.SELF, -2, 0, 0, 1)
			],
			[ # player phase
				set_action(life_pools.GREEN, target.SELF, 2, 0, 0, 1),
				set_action(life_pools.BLUE, target.SELF, 1, 0, 0, 1)
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
	new_name, new_description, new_source_front,
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
	new_pool:int, new_target:int, new_adjust:int, new_periodical_adjust:int,
	new_number_of_rounds_adjust:int, new_execute_times:int= 1, new_timer:int = 0, new_timer_adjust:int = 0
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

func get_target_enum():
	return target
	
func get_pool_enum():
	return life_pools
	
	
func preparePoolStrings(lines):
	var redLine = []
	var greenLine = []
	var blueLine = []
	
	for line in lines:
		var currentString = ""
		var current_adjust = line.adjust
		if (line.periodical_adjust > 0):
			currentString = str(currentString, specialChar)
			current_adjust = line.periodical_adjust
			
		if (line.timer_adjust > 0):
			currentString = str(currentString, specialChar)
			current_adjust = line.timer_adjust

		match (line.target):
			target.SELF:
				if (line.adjust> 0):
					currentString = str(currentString, lifeChar, current_adjust)
				else:
					currentString = str(currentString, costChar, abs(current_adjust))
			target.SINGLE:
				currentString = str(currentString, attackSingleChar, abs(current_adjust))
				
		if (line.number_of_rounds_adjust > 0):
			currentString =+ (" " + roundsChar + line.number_of_rounds_adjust)
			
		if (line.execute_times > 1):
			currentString = str(currentString, " ", multipleChar, line.execute_times)
			
		if (line.timer > 0):
			currentString = str(currentString, " " + countDownChar, line.execute_times)
			
		match (line.pool):
			life_pools.RED:
				redLine.append(currentString)
			life_pools.GREEN:
				greenLine.append(currentString)
			life_pools.BLUE:
				blueLine.append(currentString)
			
	return {red= " ".join(PackedStringArray(redLine)), green= " ".join(PackedStringArray(greenLine)), blue= " ".join(PackedStringArray(blueLine))}
	
