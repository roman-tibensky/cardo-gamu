enum life_pools {RED, BLUE, GREEN}
enum target {SINGLE, RANDOM, ADJACENT, SELF}

class Single_Action:
	var pool:int
	var adjust:int
	var periodical_adjust: int
	var number_of_rounds_adjust: int
	var target:int
	var execute_times: int

	func _init(
		new_pool:int, new_target:int, new_adjust:int, new_periodical_adjust:int,
		new_number_of_rounds_adjust:int, new_execute_times:int= 1
	):
		pool= new_pool
		adjust= new_adjust
		periodical_adjust= new_periodical_adjust
		number_of_rounds_adjust= new_number_of_rounds_adjust
		target= new_target
		execute_times = new_execute_times
