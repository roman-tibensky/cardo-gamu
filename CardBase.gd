extends MarginContainer

onready var CardList = preload("res://Assets/cards/card_management.gd")
var card_name = 'card1'

#onready var card_info = card_list.get_card_data()[card_name]

# Called when the node enters the scene tree for the first time.
func _ready():
	var card_list = CardList.new().get_card_data()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
