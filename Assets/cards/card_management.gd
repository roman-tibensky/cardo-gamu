enum life_pools {RED, BLUE, GREEN}
enum target {SINGLE, RANDOM, ADJACENT, SELF}

enum {card1,card2,card3,card4,card5,card6,card7,card8,card9,card10,card11,card12}

var card_data = {
	card1 = set_body(
		"Card1", "Card1 description", #Name, Description
		"res://Assets/cards/images/card1.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, target.SELF, 2, 0, 0, 1),
			set_action(life_pools.GREEN, target.SELF, -1, 0, 0, 1),
			set_action(life_pools.GREEN, target.SINGLE, -3, 0, 0, 1)
		],
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card2 = set_body(
		"Card2", "Card2 description", #Name, Description
		"res://Assets/cards/images/card2.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.GREEN, target.SELF, 2, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, -1, 0, 0, 1),
			set_action(life_pools.BLUE, target.SINGLE, -3, 0, 0, 1)
		],
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card3 = set_body(
		"Card3", "Card3 description", #Name, Description
		"res://Assets/cards/images/card3.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.BLUE, target.SELF, 2, 0, 0, 1),
			set_action(life_pools.RED, target.SELF, -1, 0, 0, 1),
			set_action(life_pools.RED, target.SINGLE, -3, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card4 = set_body(
		"Card4", "Card4 description", #Name, Description
		"res://Assets/cards/images/card4.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.GREEN, target.SELF, 1, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, 4, 0, 0, 1),
			set_action(life_pools.RED, target.SELF, -3, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card5 = set_body(
		"Card5", "Card5 description", #Name, Description
		"res://Assets/cards/images/card5.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.GREEN, target.SELF, 2, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, 2, 0, 0, 1),
			set_action(life_pools.RED, target.SELF, 2, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card6 = set_body(
		"Card6", "Card6 description", #Name, Description
		"res://Assets/cards/images/card6.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, target.SELF, -3, 0, 0, 1),
			set_action(life_pools.RED, target.SINGLE, -6, 0, 0, 1)
		],
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card7= set_body(
		"Card7", "Card7 description", #Name, Description
		"res://Assets/cards/images/card7.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, target.SELF, -2, 0, 0, 1),
			set_action(life_pools.GREEN, target.SELF, -2, 0, 0, 1),
			set_action(life_pools.RED, target.SINGLE, -4, 0, 0, 1),
			set_action(life_pools.GREEN, target.SINGLE, -2, 0, 0, 1),
			set_action(life_pools.BLUE, target.SINGLE, -2, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),

	card8 = set_body(
		"Card8", "Card8 description", #Name, Description
		"res://Assets/cards/images/card8.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, target.SELF, 8, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, -4, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card9 = set_body(
		"Card9", "Card9 description", #Name, Description
		"res://Assets/cards/images/card9.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, target.SELF, 4, 0, 0, 1),
			set_action(life_pools.GREEN, target.SELF, -2, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, -3, 0, 0, 1),
			set_action(life_pools.RED, target.SINGLE, -3, 0, 0, 1),
			set_action(life_pools.BLUE, target.SINGLE, -5, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card10 = set_body(
		"Card10 ", "Card10  description", #Name, Description
		"res://Assets/cards/images/card10.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.RED, target.SELF, 1, 0, 0, 1),
			set_action(life_pools.GREEN, target.SELF, 4, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, -3, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card11 = set_body(
		"Card11", "Card11 description", #Name, Description
		"res://Assets/cards/images/card11.png", #card front
		"", # card back
		[], #pre player phase
		[ # player phase
			set_action(life_pools.BLUE, target.SELF, 8, 0, 0, 1),
			set_action(life_pools.RED, target.SELF, -3, 0, 0, 1),
			set_action(life_pools.GREEN, target.SELF, -3, 0, 0, 1),
			set_action(life_pools.BLUE, target.SINGLE, -3, 0, 0, 1)
		], 
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
	card12 = set_body(
		"Card12", "Card12 description", #Name, Description
		"res://Assets/cards/images/card12.png", #card front
		"", # card back
		[], #pre player phase
		[
			set_action(life_pools.RED, target.SELF, 4, 0, 0, 1),
			set_action(life_pools.GREEN, target.SELF, -3, 0, 0, 1),
			set_action(life_pools.BLUE, target.SELF, -3, 0, 0, 1),
			set_action(life_pools.BLUE, target.SINGLE, -6, 0, 0, 1)
		], # player phase
		[], # post player phase
		[], # pre enemy phase
		[], # enemy phase
		[] # post enemy phase
	),
}

func _init():
	pass

func get_card_data():
	return card_data


func set_body(
	new_name, new_description, new_source_front, new_source_back,
	new_pre_player_phase, new_player_phase, new_post_player_phase,
	new_pre_enemy_phase, new_enemy_phase, new_post_enemy_phase
):
	return {
		card_name= new_name,
		description= new_description,
		source_front= new_source_front,
		source_back= new_source_back,
		pre_player_phase= new_pre_player_phase,
		player_phase= new_player_phase,
		post_player_phase= new_post_player_phase,
		pre_enemy_phase= new_pre_enemy_phase,
		enemy_phase= new_enemy_phase,
		post_enemy_phase= new_post_enemy_phase
	}

func set_action(
	new_pool:int, new_target:int, new_adjust:int, new_periodical_adjust:int,
	new_number_of_rounds_adjust:int, new_execute_times:int= 1, new_timer:int = 0, new_timer_action:int = 0
):
	return {
		pool= new_pool,
		adjust= new_adjust,
		periodical_adjust= new_periodical_adjust,
		number_of_rounds_adjust= new_number_of_rounds_adjust,
		target= new_target,
		execute_times= new_execute_times,
		timer= new_timer,
		timer_action= new_timer_action
	}

