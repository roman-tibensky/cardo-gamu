extends MarginContainer
#enum CardStateEnum {InHand, InPlay, InGrab, InFocus, MoveDrawnCardToHand, ReorganizeHand}

var CardList = preload("res://Assets/cards/card_management.gd")
onready var CardStateEnum = CardList.new().get_card_state_enum()

var cardList
var cardName = 'card1'
var cardNumber
var state
var startPos = 0
var startRot = 0
var startScale = Vector2()
var cardPos = Vector2()
var cardSize = Vector2()
var targetPos = 0
var targetRot = 0




var setup = true
var reorganizeNeighbours = true
var moveNeighbourgCardCheck = false
var t = 0
var drawSpeed = 2
var organizeSpeed = 4

var zoomInSize = 1.5
var zoomSpeed = 4
var handSize = 0

onready var origScale = rect_scale

#onready var card_info = card_list.get_card_data()[card_name]

# Called when the node enters the scene tree for the first time.
func _ready():
	cardList = CardList.new()
	var card = cardList.get_card_data()[cardName]
	var poolsText = cardList.preparePoolStrings(card.action)
	cardSize = rect_size
	
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
			if setup:
				setup_card()
				
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				rect_position = startPos.linear_interpolate(targetPos,t)
				#rect_rotation = startRot * (1-t) + targetRot*t
				rect_scale = startScale.linear_interpolate(origScale*zoomInSize,t)

				#to control the speed of process
				t += delta * float(zoomSpeed)
				if reorganizeNeighbours:
					reorganizeNeighbours = false
					handSize = $'../../'.handSize - 1
					if cardNumber - 1 >= 0:
						moveNeighbourCard(cardNumber -1, true, 1) #true = left
				
					if cardNumber - 2 >= 0:
						moveNeighbourCard(cardNumber -2, true, 0.5)
				
					if cardNumber + 1 <= handSize:
						moveNeighbourCard(cardNumber +1, false, 1)
				
					if cardNumber + 2 <= handSize:
						moveNeighbourCard(cardNumber +2, false, 0.5)
				
			else:
				rect_position = targetPos
				rect_scale = origScale*zoomInSize
				#rect_rotation = targetrot
		CardStateEnum.MoveDrawnCardToHand:
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				rect_position = startPos.linear_interpolate(targetPos,t)
				#rect_rotation = startRot * (1-t) + targetRot*t

				#flip ze card
				rect_scale.x = origScale.x * ( 2*t - 1)
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
			if setup:
				setup_card()
				
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				rect_position = startPos.linear_interpolate(targetPos,t)
				#rect_rotation = startRot * (1-t) + targetRot*t
				rect_scale = startScale.linear_interpolate(origScale,t)
				if moveNeighbourgCardCheck:
					moveNeighbourgCardCheck = false

				#to control the speed of process
				t += delta * float(organizeSpeed)
				
				if !reorganizeNeighbours:
					reorganizeNeighbours = true
					handSize = $'../../'.handSize - 1
					if cardNumber - 1 >= 0:
						resetNeighbourCard(cardNumber -1)
				
					if cardNumber - 2 >= 0:
						resetNeighbourCard(cardNumber -2)
				
					if cardNumber + 1 <= handSize:
						resetNeighbourCard(cardNumber +1)
				
					if cardNumber + 2 <= handSize:
						resetNeighbourCard(cardNumber +2)
				
			else:
				rect_position = targetPos
				rect_scale = origScale
				#rect_rotation = targetrot
				state = CardStateEnum.InHand
				t = 0
			pass
		_:
			pass

func _on_FocusButton_mouse_entered():
	match state:
		CardStateEnum.InHand, CardStateEnum.ReorganizeHand:
			setup = true
			targetPos = cardPos
			targetPos.y = get_viewport().size.y - $'../../'.CardSize.y*zoomInSize
			targetRot = 0
			
			state = CardStateEnum.InFocus
			

func _on_FocusButton_mouse_exited():
	match state:
		CardStateEnum.InFocus:
			setup = true
			targetPos = cardPos
			state = CardStateEnum.ReorganizeHand

func setup_card():
	startPos = rect_position
	startRot = rect_rotation
	startScale = rect_scale
	t = 0
	setup = false



func moveNeighbourCard(cardIndex, goesLeft, spreadFactor):
	var neighbourCard = $'../'.get_child(cardIndex)
	var baseOfSpread = $'../../'.CardSize.x *0.5
	if goesLeft:
		neighbourCard.targetPos = neighbourCard.cardPos - spreadFactor*Vector2(baseOfSpread, 0)
	else:
		neighbourCard.targetPos = neighbourCard.cardPos + spreadFactor*Vector2(baseOfSpread, 0)
		
	neighbourCard.setup = true
	neighbourCard.state = CardStateEnum.ReorganizeHand
	neighbourCard.moveNeighbourgCardCheck = true

func resetNeighbourCard(cardIndex):
	var neighbourCard = $'../'.get_child(cardIndex)
	
	
	if neighbourCard.state != CardStateEnum.InFocus && !moveNeighbourgCardCheck:
		neighbourCard.targetPos = neighbourCard.cardPos
		neighbourCard.setup = true
		neighbourCard.state = CardStateEnum.ReorganizeHand


