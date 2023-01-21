extends MarginContainer
#enum CardStateEnum {InHand, InPlay, InGrab, InFocus, MoveDrawnCardToHand, ReorganizeHand}

var CardList = preload("res://Assets/cards/card_management.gd")
#const CardStateEnum = CardList.new().get_card_state_enum()

enum card_state {InHand, InPlay, InGrab, InFocus, MoveDrawnCardToHand, MoveToDiscardPile, ReorganizeHand}

var cardList
var cardName = 'card1'
var cardNumber
var card

var state
var oldState
var startPos = Vector2()
var startRot = 0
var startScale = Vector2i()
var cardPos = Vector2i()
var cardSize = Vector2i()
var targetPos = Vector2()
var targetRot = 0
var targetScale = Vector2i()


var discardPile = Vector2i()




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


@onready var origScale = scale

#onready var card_info = card_list.get_card_data()[card_name]

# Called when the node enters the scene tree for the first time.
func _ready():
	cardList = CardList.new()
	card = cardList.get_card_data()[cardName]
	var poolsText = cardList.preparePoolStrings(card.actions)
	cardSize = size
	
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
	#const cardEnum = CardList.new().get_card_state_enum()
	match state:
		card_state.InFocus, card_state.InGrab, card_state.InPlay:
			if event.is_action_pressed("left_click") && canSelect:
				oldState = state
				state = card_state.InGrab
				setup = true
				canSelect = false
			if event.is_action_released("left_click") && !canSelect:
				if oldState == card_state.InFocus:
					var cardSlots = $'../../CardSlots'
					var cardSlotsEmpty = $'../../'.cardSlotEmpty
					for i in range(cardSlots.get_child_count()):
						if cardSlotsEmpty[i]:
							cardSlotsEmpty[i] = false
							var cardSlotPos = cardSlots.get_child(i).position
							var cardSlotSize = cardSlots.get_child(i).size
							var mousepos = get_global_mouse_position()
							if mousepos < cardSlotPos + cardSlotSize && mousepos > cardSlotPos:
								setup = true
								movingIntoPlay = true
								#targetPos = cardSlotPos - $'../../'.CardSize/2
								targetPos = cardSlotPos # - cardSlotSize/2 + Vector2i(15,15)
								targetScale = cardSlotSize/size
								state = card_state.InPlay
								canSelect = true
								break
					
					if state != card_state.InPlay:
						setup = true
						targetPos = cardPos
						state = card_state.ReorganizeHand
						canSelect = true
						
				else: #handle if card was successfully played?
					var enemies = $'../../Enemies'
					for i in range(enemies.get_child_count()):
						var enemytPos = enemies.get_child(i).position
						var enemySize = enemies.get_child(i).size
						var mousepos = get_global_mouse_position()
						if mousepos < enemytPos + enemySize && mousepos > enemytPos:
							#deal with effects
							$'../../'.calculate_card_effects(card.actions, enemies.get_child(i))
							
							#discard card upon playing it
							movingToDiscard = true
							
							setup = true
							movingIntoPlay = true
							#targetPos = enemytPos - $'../../'.CardSize/2
							state = card_state.MoveToDiscardPile
							canSelect = true
							break
					
					if !canSelect:
						setup = true
						movingIntoPlay = true
						state = card_state.InPlay
						canSelect = true
	

func _physics_process(delta):
	match state:
		card_state.InHand:
			pass
		card_state.InPlay:
			if movingIntoPlay:
				if setup:
					setup_card()
					
				if t <= 1:
					#TODO: use Tween instead - tutorial 3B
					position = startPos.lerp(targetPos,t)
					scale = startScale.lerp(targetScale,t)
					#rotation = startRot * (1-t) + targetRot*t


					#to control the speed of process
					t += delta * float(grabSpeed)
				else:
					position = targetPos
					scale = targetScale
					#rotation = 0
					movingIntoPlay = false
					$'../../'.ReParentCard(cardNumber)
			pass
		card_state.InGrab:
			var middleOfCardHold = get_global_mouse_position() - ($'../../'.CardSize)/2
			if setup:
				setup_card()
				
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				position = startPos.lerp(middleOfCardHold,t)
				scale = startScale.lerp(origScale,t)
				#rotation = startRot * (1-t) + targetRot*t


				#to control the speed of process
				t += delta * float(grabSpeed)
			else:
				position = middleOfCardHold
				#scale = startScale
				#rotation = 0
				
			pass
		card_state.InFocus:
			if setup:
				setup_card()
				
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				position = startPos.lerp(targetPos,t)
				#rotation = startRot * (1-t) + targetRot*t
				scale = startScale.lerp(origScale*zoomInSize,t)

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
				position = targetPos
				scale = origScale*zoomInSize
				#rotation = targetrot
			pass
		card_state.MoveToDiscardPile:
			if movingToDiscard:
				if setup:
					setup_card()
					targetPos = discardPile
					
				if t <= 1:
					#TODO: use Tween instead - tutorial 3B
					position = startPos.lerp(targetPos,t)
					scale = startScale.lerp(origScale,t)
					#rotation = startRot * (1-t) + targetRot*t

					#to control the speed of process
					t += delta * float(drawSpeed)
				else:
					position = targetPos
					
					movingToDiscard = false
					#scale = startScale
					#rotation = 0
					
				pass
		card_state.MoveDrawnCardToHand:
			if t <= 1:
				if setup:
					setup_card()
				
				#TODO: use Tween instead - tutorial 3B
				position = startPos.lerp(targetPos,t)
				#rotation = startRot * (1-t) + targetRot*t

				#flip ze card
				scale.x = origScale.x * ( 2*t - 1)
				if $CardBack.visible && t >= 0.5:
					$CardBack.visible = false

				#to control the speed of process
				t += delta * float(drawSpeed)
			else:
				position = targetPos
				#rotation = targetrot
				state = card_state.InHand
			pass
		card_state.ReorganizeHand:
			if setup:
				setup_card()
				
			if t <= 1:
				#TODO: use Tween instead - tutorial 3B
				position = startPos.lerp(targetPos,t)
				#rotation = startRot * (1-t) + targetRot*t
				scale = startScale.lerp(origScale,t)
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
				position = targetPos
				scale = origScale
				#rotation = targetrot
				state = card_state.InHand
				t = 0
			pass
		_:
			pass

func _on_FocusButton_mouse_entered():
	match state:
		card_state.InHand, card_state.ReorganizeHand:
			setup = true
			targetPos.x = cardPos.x - $'../../'.CardSize.x/2
			targetPos.y = get_viewport().size.y - $'../../'.CardSize.y*zoomInSize*1.05
			targetRot = 0
			
			state = card_state.InFocus
			

func _on_FocusButton_mouse_exited():
	match state:
		card_state.InFocus:
			setup = true
			targetPos = cardPos
			state = card_state.ReorganizeHand

func setup_card():
	startPos = position
	startRot = rotation
	startScale = scale
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
	neighbourCard.state = card_state.ReorganizeHand
	neighbourCard.moveNeighbourgCardCheck = true

func resetNeighbourCard(cardIndex):
	var neighbourCard = $'../'.get_child(cardIndex)
	
	
	if neighbourCard.state != card_state.InFocus && !moveNeighbourgCardCheck:
		neighbourCard.targetPos = neighbourCard.cardPos
		neighbourCard.setup = true
		neighbourCard.state = card_state.ReorganizeHand

func get_card_state_enum():
	return card_state
