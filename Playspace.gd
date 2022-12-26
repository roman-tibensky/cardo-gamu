extends Node2D

#var CardSize = Vector2(281, 338)
var CardSize = Vector2(168, 203)
var DeckCardSize = Vector2(205, 250)
const CardBase = preload("res://CardBase.tscn")
const PlayerHand = preload("res://Player_Hand.gd")
var cardSelected
onready var deckSize = PlayerHand.DeckCards.size()
onready var CardStateEnum = preload("res://Assets/cards/card_management.gd").new().get_card_state_enum()

# some horrifying oval math thing
onready var centerCardOval = get_viewport().size * Vector2(0.5, 1.25)
onready var horRad = get_viewport().size.x * 0.45
onready var verRad = get_viewport().size.y * 0.45
var angle = deg2rad(90) - 0.6
var cardSpread = 0.25
var ovalAngleVector = Vector2()

var handSize = 0
#var cardNumber = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Deck/DeckDraw.rect_scale *= DeckCardSize/$Deck/DeckDraw.rect_size
	pass


func draw_card():
	angle = PI/2 + cardSpread*(float(handSize)/2 - handSize)
	var new_card = CardBase.instance()
	cardSelected = randi() % deckSize
	
	new_card.cardName = PlayerHand.DeckCards[cardSelected]

	# continue horrifying oval math thing
	ovalAngleVector = Vector2(horRad * cos(angle), -verRad * sin(angle))
	new_card.startPos= $Deck.position
	new_card.targetPos= centerCardOval + ovalAngleVector - CardSize/2
	new_card.cardPos = new_card.targetPos
	
	#TODO: pixelated and ugly; research why later -check anti-aliasing maybe?
	new_card.startRot= 0
	#new_card.targetrot = (90 - rad2deg(angle)) / 4
	
	new_card.rect_scale *= CardSize/new_card.rect_size
	new_card.cardNumber = $CardsInHand.get_children().size()	
	
	new_card.state = CardStateEnum.MoveDrawnCardToHand
	
	#reorganize cards when pushing new card
	var cardNum = 0
	for Card in $CardsInHand.get_children():
		var handCardAngle = PI/2 + cardSpread*(float(handSize)/2 - cardNum)
		var handCardOvalAngleVector = Vector2(horRad * cos(handCardAngle), -verRad * sin(handCardAngle))
		
		Card.targetPos= centerCardOval + handCardOvalAngleVector - CardSize/2
		Card.cardPos = Card.targetPos #card default position
		#TODO: pixelated and ugly; research why later -check anti-aliasing maybe?
		#Card.startRot= Card.rect_rotation
		#Card.targetrot = (90 - rad2deg(handCardAngle)) / 4

		
		cardNum += 1
		
		#address issue when crds are not copletely drawn yet
		if Card.state == CardStateEnum.InHand:
			Card.state = CardStateEnum.ReorganizeHand
			Card.startPos= Card.rect_position
			pass
		elif Card.state == CardStateEnum.MoveDrawnCardToHand:
			Card.startPos = Card.targetPos - ((Card.targetPos - Card.rect_position )/(1 - Card.t))
			pass
		
	$CardsInHand.add_child(new_card)
	PlayerHand.DeckCards.remove(cardSelected)
	
	angle += cardSpread
	deckSize = PlayerHand.DeckCards.size()
	
	handSize += 1
	#cardNumber += 1
	
	
	return deckSize
		

