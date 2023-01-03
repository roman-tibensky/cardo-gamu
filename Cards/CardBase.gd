extends MarginContainer
#enum CardStateEnum {InHand, InPlay, InGrab, InFocus, MoveDrawnCardToHand, ReorganizeHand}

var CardList = preload("res://Assets/cards/card_management.gd")
onready var CardStateEnum = CardList.new().get_card_state_enum()


var cardList
var cardName = 'card1'
var cardNumber
var card

var state
var oldState
var startPos = 0
var startRot = 0
var startScale = Vector2()
var cardPos = Vector2()
var cardSize = Vector2()
var targetPos = 0
var targetRot = 0
var targetScale = Vector2()


var discardPile = Vector2()




var setup = true
var movingIntoPlay = false
var reorganizeNeighbours = true
var moveNeighbourgCardCheck = false
var t = 0
var drawSpeed = 2
var organizeSpeed = 4
var grabSpeed = 5
var zoomInSize = 1.5
var zoomSpeed = 4
var handSize = 0

var canSelect = true
var movingToDiscard = false


onready var origScale = rect_scale

#onready var card_info = card_list.get_card_data()[card_name]

# Called when the node enters the scene tree for the first time.
func _ready():
	cardList = CardList.new()
	card = cardList.get_card_data()[cardName]
	var poolsText = cardList.preparePoolStrings(card.actions)
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


func _input(event):
	match state:
		CardStateEnum.InFocus, CardStateEnum.InGrab, CardStateEnum.InPlay:
			if event.is_action_pressed("left_click") && canSelect:
				oldState = state
				state = CardStateEnum.InGrab
				setup = true
				canSelect = false
			if event.is_action_released("left_click") && !canSelect:
				if oldState == CardStateEnum.InFocus:
					var cardSlots = $'../../CardSlots'
					var cardSlotsEmpty = $'../../'.cardSlotEmpty
					for i in range(cardSlots.get_child_count()):
						if cardSlotsEmpty[i]:
							cardSlotsEmpty[i] = false
							var cardSlotPos = cardSlots.get_child(i).rect_position
							var cardSlotSize = cardSlots.get_child(i).rect_size
							var mousepos = get_global_mouse_position()
							if mousepos < cardSlotPos + cardSlotSize && mousepos > cardSlotPos:
								setup = true
								movingIntoPlay = true
								#targetPos = cardSlotPos - $'../../'.CardSize/2
								targetPos = cardSlotPos # - cardSlotSize/2 + Vector2(15,15)
								targetScale = cardSlotSize/rect_size
								state = CardStateEnum.InPlay
								canSelect = true
								break
					
					if state != CardStateEnum.InPlay:
						setup = true
						targetPos = cardPos
						state = CardStateEnum.ReorganizeHand
						canSelect = true
						
				else: #handle if card was successfully played?
					var enemies = $'../../Enemies'
					for i in range(enemies.get_child_count()):
						var enemytPos = enemies.get_child(i).rect_position
						var enemySize = enemies.get_child(i).rect_size
						var mousepos = get_global_mouse_position()
						if mousepos < enemytPos + enemySize && mousepos > enemytPos:
							#deal with effects
							$'../../'.calculate_card_effects(card.actions, enemies.get_child(i))
							
							#discard card upon playing it
							movingToDiscard = true
							
							setup = true
							movingIntoPlay = true
							#targetPos = enemytPos - $'../../'.CardSize/2
							state = CardStateEnum.MoveToDiscardPile
							canSelect = true
							break
					
					if !canSelect:
						setup = true
						movingIntoPlay = true
						state = CardStateEnum.InPlay
						canSelect = true
	

func _physics_process(delta):
	match state:
		CardStateEnum.InHand:
			pass
		CardStateEnum.InPlay:
			if movingIntoPlay:
				if setup:
					setup_card()
					
				if t <= 1:
					#TODO: use Tween instead - tutorial 3B
					rect_position = startPos.linear_interpolate(targetPos,t)
					rect_scale = startScale.linear_interpolate(targetScale,t)
					#rect_rotation = startRot * (1-t) + targetRot*t


					#to control the speed of process
					t += delta * float(grabSpeed)
				else:
					rect_position = targetPos
					rect_scale = targetScale
					#rect_rotation = 0
					movingIntoPlay = false
					$'../../'.ReParentCard(cardNumber)
			pass
		CardStateEnum.InGrab:
			var middleOfCardHold = get_global_mouse_position() - ($'../../'.CardSize)/2
			if setup:
				setup_card()
				
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				rect_position = startPos.linear_interpolate(middleOfCardHold,t)
				rect_scale = startScale.linear_interpolate(origScale,t)
				#rect_rotation = startRot * (1-t) + targetRot*t


				#to control the speed of process
				t += delta * float(grabSpeed)
			else:
				rect_position = middleOfCardHold
				#rect_scale = startScale
				#rect_rotation = 0
				
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
			pass
		CardStateEnum.MoveToDiscardPile:
			if movingToDiscard:
				if setup:
					setup_card()
					targetPos = discardPile
					
				if t <= 1:
					#TODO: use Tween instead - tutorial 3B
					rect_position = startPos.linear_interpolate(targetPos,t)
					rect_scale = startScale.linear_interpolate(origScale,t)
					#rect_rotation = startRot * (1-t) + targetRot*t

					#to control the speed of process
					t += delta * float(drawSpeed)
				else:
					rect_position = targetPos
					
					movingToDiscard = false
					#rect_scale = startScale
					#rect_rotation = 0
					
				pass
		CardStateEnum.MoveDrawnCardToHand:
			if t <= 1:
				if setup:
					setup_card()
				
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
			targetPos.x = cardPos.x - $'../../'.CardSize.x/2
			targetPos.y = get_viewport().size.y - $'../../'.CardSize.y*zoomInSize*1.05
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


