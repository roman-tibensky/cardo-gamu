extends Node2D

#var CardSize = Vector2i(281, 338)
var CardSize = Vector2(117, 142)
var EnemySizeRegular = Vector2(400, 264)
var EnemySizeMid = Vector2i(400, 264)
var EnemySizeBoss = Vector2i(400, 264)
#var CardSize = Vector2i(168, 203)
var DeckCardSize = Vector2i(117, 142)
#var DeckCardSize = Vector2i(205, 250)
const CardBase = preload("res://Cards/CardBase.tscn")
const PlayerHand = preload("res://Cards/Player_Hand.gd")
const CardSlot = preload("res://Cards/CardSlot.tscn")
@onready var EnemiesData = preload("res://Assets/enemies/enemy_management.gd")
var enemy

var cardSelected
@onready var deckSize = PlayerHand.DeckCards.size()

@onready var deckPosition = $Deck.position
@onready var discardPosition = $DiscardPile.position

# some horrifying oval math thing
@onready var centerCardOval = Vector2(get_viewport().size) * Vector2(0.5, 1.45)
@onready var horRad = get_viewport().size.x * 0.45
@onready var verRad = get_viewport().size.y * 0.45

var angle = deg_to_rad(90) - 0.6
var cardSpread = 0.2 * CardSize.x/117
var ovalAngleVector = Vector2i()

var playerRed = 20
var playerGreen = 20
var playerBlue = 20

var handSize = -1

var arrowStartPosition
#var cardNumber = 1

var cardSlotEmpty = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Deck/DeckDraw.scale *= DeckCardSize/$Deck/DeckDraw.size
	randomize()
	var enemyData = EnemiesData.new()
	enemy = $Enemies/EnemyBase
	enemy.setup_enemy(enemyData.get_enemy_data()['enemy1'])
	$Enemies/EnemyBase.visible = true
	$Enemies/EnemyBase.position = get_viewport().size  * 0.4 + Vector2(200, 0)
	$Enemies/EnemyBase.scale *= (EnemySizeRegular / $Enemies/EnemyBase.size)
	
	#TODO: try withuot card slots
	#var newSlot = CardSlot.instantiate()
	#newSlot.position = get_viewport().size * 0.4
	#newSlot.size = CardSize
	#$CardSlots.add_child(newSlot)
	#cardSlotEmpty.append(true)
	


func draw_card():
	angle = PI/2 + cardSpread*(float(handSize)/2 - handSize)
	var new_card = CardBase.instantiate()
	cardSelected = randi() % deckSize
	
	new_card.cardName = PlayerHand.DeckCards[cardSelected]

	# continue horrifying oval math thing
	#ovalAngleVector = Vector2i(horRad * cos(angle), -verRad * sin(angle))
	new_card.position = deckPosition
	new_card.discardPile = discardPosition
	#new_card.targetPos= centerCardOval + ovalAngleVector - CardSize/2
	#new_card.cardPos = new_card.targetPos
	
	#TODO: pixelated and ugly; research why later -check anti-aliasing maybe?
	#new_card.startRot= 0
	#new_card.targetrot = (90 - rad_to_deg(angle)) / 4
	
	new_card.scale *= CardSize/new_card.size
	#new_card.cardNumber = $CardsInHand.get_children().size()
	
	new_card.state = new_card.card_state.MoveDrawnCardToHand
	
	
	

		
	$CardsInHand.add_child(new_card)
	PlayerHand.DeckCards.remove_at(cardSelected)
	
	angle += cardSpread
	deckSize = PlayerHand.DeckCards.size()
	
	handSize += 1
	#cardNumber += 1
	
	#reorganize cards when pushing new card
	organizeHand()
	return deckSize
		
		
func calculate_card_effects(actions, target):
	target.manageHealth()
	#TODO: after the tutorial, the actual damage and stuff
	pass
	
func ReParentCard(CardNo):
	var Card = $CardsInHand.get_child(CardNo)
	$CardsInHand.remove_child(Card)
	$CardsInPlay.add_child(Card)
	handSize -= 1
	organizeHand()
	
func organizeHand():
	var cardNum = 0
	for Card in $CardsInHand.get_children():
		var handCardAngle = PI/2 + cardSpread*(float(handSize)/2 - cardNum)
		var handCardOvalAngleVector = Vector2(horRad * cos(handCardAngle), -verRad * sin(handCardAngle))
		
		Card.targetPos= centerCardOval + handCardOvalAngleVector - Vector2(0, CardSize.y)
		Card.cardPos = Card.targetPos #card default position
		#TODO: pixelated and ugly; research why later -check anti-aliasing maybe?
		#Card.startRot= Card.rotation
		#Card.targetrot = (90 - rad_to_deg(handCardAngle)) / 4

		Card.cardNumber = cardNum		
		cardNum += 1
		
		#address issue when crds are not copletely drawn yet
		if Card.state == Card.card_state.InHand:
			Card.setup = true
			Card.state = Card.card_state.ReorganizeHand
			#Card.startPos= Card.position
			pass
		elif Card.state == Card.card_state.MoveDrawnCardToHand:
			Card.t -= 0.1
			Card.startPos = Card.targetPos - ((Card.targetPos - Card.position )/(1 - Card.t))
			pass
