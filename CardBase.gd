extends MarginContainer
#enum CardStateEnum {InHand, InPlay, InGrab, InFocus, MoveDrawnCardToHand, ReorganizeHand}

var CardList = preload("res://Assets/cards/card_management.gd")
onready var CardStateEnum = CardList.new().get_card_state_enum()

var cardList
var cardName = 'card1'
var state
var startPos = 0
var startRot = 0
var targetPos = 0
var targetRot = 0
var t = 0
var drawSpeed = 2
var organizeSpeed = 4
onready var origScale = rect_scale.x

#onready var card_info = card_list.get_card_data()[card_name]

# Called when the node enters the scene tree for the first time.
func _ready():
	cardList = CardList.new()
	var card = cardList.get_card_data()[cardName]
	var poolsText = cardList.preparePoolStrings(card.action)
	var cardSize = rect_size
	$CardFront.texture = load(card.source_front)
	$CardFront.scale *= cardSize/$CardFront.texture.get_size()
	
	$CardBack.texture = load(card.source_back)
	$CardBack.scale *= cardSize/$CardBack.texture.get_size()
	
	
	$TextGrid/NameCont/NameContainer/CenterContainer/Name.text = card.card_name
	$TextGrid/RedPoolCont/RedPoolContainer/CenterContainer/RedPool.text = poolsText.red
	$TextGrid/GreenPoolCont/GreenPoolContainer/CenterContainer/GreenPool.text = poolsText.green
	$TextGrid/BluePoolCont/BluePoolContainer/CenterContainer/BluePool.text = poolsText.blue
	$TextGrid/DescCont/DescContainer/CenterContainer/Desc.text = card.description


func _physics_process(delta):
	match state:
		CardStateEnum.InHand:
			pass
		CardStateEnum.InPlay:
			pass
		CardStateEnum.InGrab:
			pass
		CardStateEnum.InFocus:
			pass
		CardStateEnum.MoveDrawnCardToHand:
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				rect_position = startPos.linear_interpolate(targetPos,t)
				#rect_rotation = startRot * (1-t) + targetRot*t

				#flip ze card
				rect_scale.x = origScale * ( 2*t - 1)
				if $CardBack.visible && t >= 0.5:
					$CardBack.visible = false

				#to control the speed of process
				t += delta * float(drawSpeed)
			else:
				rect_position = targetPos
				#rect_rotation = targetrot
				state = CardStateEnum.InHand
				t = 0
			pass
		CardStateEnum.ReorganizeHand:
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				rect_position = startPos.linear_interpolate(targetPos,t)
				#rect_rotation = startRot * (1-t) + targetRot*t

				#to control the speed of process
				t += delta * float(organizeSpeed)
			else:
				rect_position = targetPos
				#rect_rotation = targetrot
				state = CardStateEnum.InHand
				t = 0
			pass
		_:
			pass
