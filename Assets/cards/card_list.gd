onready var card_action = preload("res://Assets/cards/models/card_single_action.gd")
onready var card_body = preload("res://Assets/cards/models/card_body.gd")

enum life_pools {RED, BLUE, GREEN}
enum target {SINGLE, RANDOM, ADJACENT, SELF}

enum {card1,card2,card3,card4,card5,card6,card7,card8,card9,card10,card11,card12}


var card_data =  {
	card1= {
		card_name= "Card1",
		description= "Card1",
		source_front= "res=//Assets/cards/images/card1.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, 2, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SELF, -1, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SINGLE, -3, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card2= {
		name= "Card2",
		description= "Card2",
		source_front= "res=//Assets/cards/images/card2.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.GREEN, target.SELF, 2, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, -1, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SINGLE, -3, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card3= {
		name= "Card3",
		description= "Card3",
		source_front= "res=//Assets/cards/images/card3.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.BLUE, target.SELF, 2, 0, 0, 1),
			card_action.new(life_pools.RED, target.SELF, -1, 0, 0, 1),
			card_action.new(life_pools.RED, target.SINGLE, -3, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card4= {
		name= "Card4",
		description= "Card4",
		source_front= "res=//Assets/cards/images/card4.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.GREEN, target.SELF, 1, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, 4, 0, 0, 1),
			card_action.new(life_pools.RED, target.SELF, -3, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card5= {
		name= "Card5",
		description= "Card5",
		source_front= "res=//Assets/cards/images/card5.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.GREEN, target.SELF, 2, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, 2, 0, 0, 1),
			card_action.new(life_pools.RED, target.SELF, 2, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card6= {
		name= "Card6",
		description= "Card6",
		source_front= "res=//Assets/cards/images/card6.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, -3, 0, 0, 1),
			card_action.new(life_pools.RED, target.SINGLE, -6, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card7= {
		name= "Card7",
		description= "Card7",
		source_front= "res=//Assets/cards/images/card7.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, -2, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SELF, -2, 0, 0, 1),
			card_action.new(life_pools.RED, target.SINGLE, -4, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SINGLE, -2, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SINGLE, -2, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card8= {
		name= "Card8",
		description= "Card8",
		source_front= "res=//Assets/cards/images/card8.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, 8, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, -4, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card9= {
		name= "Card9",
		description= "Card9",
		source_front= "res=//Assets/cards/images/card9.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, 4, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SELF, -2, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, -3, 0, 0, 1),
			card_action.new(life_pools.RED, target.SINGLE, -3, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SINGLE, -5, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card10= {
		name= "Card10",
		description= "Card10",
		source_front= "res=//Assets/cards/images/card10.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, 1, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SELF, 4, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, -3, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card11= {
		name= "Card11",
		description= "Card11",
		source_front= "res=//Assets/cards/images/card11.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.BLUE, target.SELF, 8, 0, 0, 1),
			card_action.new(life_pools.RED, target.SELF, -3, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SELF, -3, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SINGLE, -3, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	},
	card12= {
		name= "Card12",
		description= "Card12",
		source_front= "res=//Assets/cards/images/card12.png",
		source_back='',
		pre_player_phase= [],
		player_phase= [
			card_action.new(life_pools.RED, target.SELF, 4, 0, 0, 1),
			card_action.new(life_pools.GREEN, target.SELF, -3, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SELF, -3, 0, 0, 1),
			card_action.new(life_pools.BLUE, target.SINGLE, -6, 0, 0, 1)
		],
		post_player_phase= [],
		pre_enemy_phase= [],
		enemy_phase= [],
		post_enemy_phase= []
	}
}
