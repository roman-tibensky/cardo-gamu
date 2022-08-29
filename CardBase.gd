extends MarginContainer
enum {InHand, InPlay, InGrab, InFocus, MoveDrawnCardToHand}

onready var CardList = preload("res://Assets/cards/card_management.gd")

var cardList
var cardName = 'card1'
var state = InHand

#onready var card_info = card_list.get_card_data()[card_name]

# Called when the node enters the scene tree for the first time.
func _ready():
	cardList = CardList.new()
	var card = cardList.get_card_data()[cardName]
	var poolsText = cardList.preparePoolStrings(card.action)
	var cardSize = rect_size
	$CardFront.texture = load(card.source_front)
	$CardFront.scale *= cardSize/$CardFront.texture.get_size()
	$VBoxContainer/NameCont/NameContainer/CenterContainer/Name.text = card.card_name
	$VBoxContainer/RedPoolCont/RedPoolContainer/CenterContainer/RedPool.text = poolsText.red
	$VBoxContainer/GreenPoolCont/GreenPoolContainer/CenterContainer/GreenPool.text = poolsText.green
	$VBoxContainer/BluePoolCont/BluePoolContainer/CenterContainer/BluePool.text = poolsText.blue
	$VBoxContainer/DescCont/DescContainer/CenterContainer/Desc.text = card.description


func _physics_process(delta):
	match state:
		InHand:
			pass
		InPlay:
			pass
		InGrab:
			pass
		InFocus:
			pass
		MoveDrawnCardToHand:
			pass
