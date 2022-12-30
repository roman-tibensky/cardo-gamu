extends Node2D

#var CardSize = Vector2(281, 338)
var CardSize = Vector2(117, 142)
#var CardSize = Vector2(168, 203)
var DeckCardSize = Vector2(117, 142)
#var DeckCardSize = Vector2(205, 250)
const CardBase = preload("res://Cards/CardBase.tscn")
const PlayerHand = preload("res://Cards/Player_Hand.gd")
const CardSlot = preload("res://Cards/CardSlot.tscn")
var cardSelected
onready var deckSize = PlayerHand.DeckCards.size()
onready var CardStateEnum = preload("res://Assets/cards/card_management.gd").new().get_card_state_enum()

onready var deckPosition = $Deck.position - CardSize/2  + Vector2(15,15)
onready var discardPosition = $DiscardPile.position - CardSize/2  + Vector2(15,15)

# some horrifying oval math thing
onready var centerCardOval = get_viewport().size * Vector2(0.5, 1.25)
onready var horRad = get_viewport().size.x * 0.45
onready var verRad = get_viewport().size.y * 0.45

var angle = deg2rad(90) - 0.6
var cardSpread = 0.2
var ovalAngleVector = Vector2()

var playerRed = 20
var playerGreen = 20
var playerBlue = 20

var handSize = -1
#var cardNumber = 1

var cardSlotEmpty = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Deck/DeckDraw.rect_scale *= DeckCardSize/$Deck/DeckDraw.rect_size
	randomize()
	$Enemies/EnemyBase.visible = true
	$Enemies/EnemyBase.rect_position = get_viewport().size  * 0.4 + Vector2(200, 0)
	$Enemies/EnemyBase.rect_scale *= CardSize/$Enemies/EnemyBase.rect_size
	
	var newSlot = CardSlot.instance()
	newSlot.rect_position = get_viewport().size * 0.4
	newSlot.rect_size = CardSize
	#newSlot.rect_scale *= CardSize/newSlot.rect_size
	$CardSlots.add_child(newSlot)
	cardSlotEmpty.append(true)


func draw_card():
	angle = PI/2 + cardSpread*(float(handSize)/2 - handSize)
	var new_card = CardBase.instance()
	cardSelected = randi() % deckSize
	
	new_card.cardName = PlayerHand.DeckCards[cardSelected]

	# continue horrifying oval math thing
	#ovalAngleVector = Vector2(horRad * cos(angle), -verRad * sin(angle))
	new_card.rect_position = deckPosition
	new_card.discardPile = discardPosition
	#new_card.targetPos= centerCardOval + ovalAngleVector - CardSize/2
	#new_card.cardPos = new_card.targetPos
	
	#TODO: pixelated and ugly; research why later -check anti-aliasing maybe?
	#new_card.startRot= 0
	#new_card.targetrot = (90 - rad2deg(angle)) / 4
	
	new_card.rect_scale *= CardSize/new_card.rect_size
	#new_card.cardNumber = $CardsInHand.get_children().size()
	
	new_card.state = CardStateEnum.MoveDrawnCardToHand
	
	
	

		
	$CardsInHand.add_child(new_card)
	PlayerHand.DeckCards.remove(cardSelected)
	
	angle += cardSpread
	deckSize = PlayerHand.DeckCards.size()
	
	handSize += 1
	#cardNumber += 1
	
	#reorganize cards when pushing new card
	organizeHand()
	return deckSize
		
		
func calculate_card_effects(actions, enemy):
	enemy.manageHealth()
	#TODO: after the tutorial, the actual damage and stuff
	pass
	
func organizeHand():
	var cardNum = 0
	for Card in $CardsInHand.get_children():
		var handCardAngle = PI/2 + cardSpread*(float(handSize)/2 - cardNum)
		var handCardOvalAngleVector = Vector2(horRad * cos(handCardAngle), -verRad * sin(handCardAngle))
		
		Card.targetPos= centerCardOval + handCardOvalAngleVector - CardSize/2
		Card.cardPos = Card.targetPos #card default position
		#TODO: pixelated and ugly; research why later -check anti-aliasing maybe?
		#Card.startRot= Card.rect_rotation
		#Card.targetrot = (90 - rad2deg(handCardAngle)) / 4

		Card.cardNumber = cardNum		
		cardNum += 1
		
		#address issue when crds are not copletely drawn yet
		if Card.state == CardStateEnum.InHand:
			Card.setup = true
			Card.state = CardStateEnum.ReorganizeHand
			#Card.startPos= Card.rect_position
			pass
		elif Card.state == CardStateEnum.MoveDrawnCardToHand:
			Card.startPos = Card.targetPos - ((Card.targetPos - Card.rect_position )/(1 - Card.t))
			pass
