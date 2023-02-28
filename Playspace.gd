extends Node2D

enum targetEnum {SINGLE, RANDOM, ALL, SELF}

const constants = preload("res://constants.gd")
var life_pools = constants.new().life_pools

#var CardSize = Vector2i(281, 338)
var PlayerSize = Vector2(320, 170)
var RoundManagementSize = Vector2(140, 170)
var CardSize = Vector2(117, 142)
var EnemySizeRegular = Vector2(400, 264)
var EnemySizeMid = Vector2i(400, 264)
var EnemySizeBoss = Vector2i(400, 264)
#var CardSize = Vector2i(168, 203)
var DeckCardSize = Vector2i(117, 142)
#var DeckCardSize = Vector2i(205, 250)
const CardBase = preload("res://Cards/CardBase.tscn")
const PlayerHand = preload("res://Cards/Player_Hand.gd")
var playerHand = PlayerHand.new()
const CardSlot = preload("res://Cards/CardSlot.tscn")
@onready var EnemiesData = preload("res://Assets/enemies/enemy_management.gd")
var enemy

var player
var roundManagementNode

var cardSelected
@onready var deckSize = playerHand.get_size()

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

var selectedCard = null
var clickReadyAfterSelect = false

func getHasCardSelected():
	return selectedCard


#proces card selection and determine how and which cards to highlight
#TODO: expand according to card effect target
func setHasCardSelected(val):
	selectedCard = val
	manageHighlights(true)
	#await setClickReady(true).create_timer(500).timeout
	await get_tree().create_timer(0.5).timeout
	clickReadyAfterSelect = true

func setClickReady(isReady):
	clickReadyAfterSelect = isReady

#TODO: expand according to card effect target
func manageHighlights(active):
	for i in range($Enemies.get_child_count()):
		$Enemies.get_child(i).highlightMangement(active)
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Deck/DeckDraw.scale *= DeckCardSize/$Deck/DeckDraw.size
	randomize()
	var enemyData = EnemiesData.new()
	enemy = $Enemies/EnemyBase
	enemy.setup_enemy(enemyData.get_enemy_data()['enemy1'])
	$Enemies/EnemyBase.visible = true
	
	$Enemies/EnemyBase.scale *= (EnemySizeRegular / $Enemies/EnemyBase.size)
	var enSX = $Enemies/EnemyBase.size.x
	var vPX = get_viewport().size.x
	var enemy_x_pos = (get_viewport().size.x / 2) - (EnemySizeRegular.x / 2)
	$Enemies/EnemyBase.position = Vector2(enemy_x_pos, 50)
	
	player = $Player/PlayerBase
	player.scale *= (PlayerSize / player.size)
	
	roundManagementNode = $RoundManagement/RoundManagement
	roundManagementNode.scale *= (RoundManagementSize / roundManagementNode.size)


func draw_card():
	angle = PI/2 + cardSpread*(float(handSize)/2 - handSize)
	var new_card = CardBase.instantiate()
	cardSelected = randi() % deckSize
	
	new_card.cardName = playerHand.get_card(cardSelected)

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
	playerHand.remove_card(cardSelected)
	
	angle += cardSpread
	deckSize = playerHand.get_size()
	
	handSize += 1
	#cardNumber += 1
	
	#reorganize cards when pushing new card
	organizeHand()
	return deckSize
		
		
func _input(event):
	if clickReadyAfterSelect && event.is_action_pressed("left_click"):
		for i in range($Enemies.get_child_count()):
			var enemy = $Enemies.get_child(i)
			var enemytPos = $Enemies.get_child(i).position
			var enemySize = $Enemies.get_child(i).size
			var enemyScale = $Enemies.get_child(i).scale
			var mousepos = get_global_mouse_position() 
			var enemyLive = enemySize * enemyScale
			var enemyReach = enemytPos + (enemySize * enemyScale)
			if mousepos.x < enemyReach.x && mousepos.y < enemyReach.y && mousepos.x > enemytPos.x && mousepos.x > enemytPos.x:
				var cardContainer = $CardsInHand.get_child(selectedCard)
				#deal with effects
				calculate_action_effects(cardContainer.card.actions, player, $Enemies.get_child(i))
				$CardsInHand.get_child(selectedCard).cardPlayed(true)
				ReParentCard(selectedCard)
				selectedCard = null
				clickReadyAfterSelect = false
				roundManagementNode.actionUpdate()
				break
				
		if selectedCard != null:
			$CardsInHand.get_child(selectedCard).cardPlayed(false)
			selectedCard = null
			clickReadyAfterSelect = false
			
		manageHighlights(false)
		
func calculate_action_effects(actions, owner, target):
	for action in actions:
		match action.target:
			targetEnum.SINGLE:
				target.manageHealth(action.pool, action.adjust)
				pass
				
			targetEnum.SELF:
				owner.manageHealth(action.pool, action.adjust)
				pass
	
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


func _on_round_management_action_modification(pool, mod):
	player.manageHealth(pool, mod)
