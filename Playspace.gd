extends Node2D

const constants = preload("res://constants.gd")
const life_pools = constants.new().life_pools
const targetEnum =  constants.new().targetEnum
const deathMessageSelfDestruct = constants.new().deathMessageSelfDestruct

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
const PlayerDeck = preload("res://Cards/Player_Deck.gd")
var playerDeck = PlayerDeck.new()
var currentDeck
const CardSlot = preload("res://Cards/CardSlot.tscn")
@onready var EnemiesData = preload("res://Assets/enemies/enemy_management.gd")
@onready var EnemiesLists = preload("res://Assets/enemies/Player_Enemies.gd")
var currentEnemyList
var enemyIndex = 0
var enemy

var player
var characterId
var roundManagementNode

var cardSelected

@onready var deckPosition = $Deck.position
@onready var discardPosition = $DiscardPile.position

# some horrifying oval math thing
@onready var centerCardOval = Vector2(get_viewport().size) * Vector2(0.5, 1.45)
@onready var horRad = get_viewport().size.x * 0.45
@onready var verRad = get_viewport().size.y * 0.45

var angle = deg_to_rad(90) - 0.6
var cardSpread = 0.2 * CardSize.x/117
var ovalAngleVector = Vector2i()



var handSize = -1

var arrowStartPosition
#var cardNumber = 1

var cardSlotEmpty = []

var selectedCard = null
var clickReadyAfterSelect = false
var basePortX
var basePortY



# Called when the node enters the scene tree for the first time.
func _ready():
	#to prevent screen resizing cause shenanigans
	basePortX = get_viewport().size.x
	basePortY = get_viewport().size.y
	
	enemy = $Enemies/EnemyBase
	
	$HelpButton/InGameHelp.position.x = get_viewport().size.x - $HelpButton/InGameHelp.size.x - 40
	$HelpButton/InGameHelp.position.y = 40
	
	player = $Player/PlayerBase
	player.scale *= (PlayerSize / player.size)

	
	roundManagementNode = $RoundManagement/RoundManagement
	roundManagementNode.scale *= (RoundManagementSize / roundManagementNode.size)
	
	clearScreenForMenu("Welcome to Primal TriStream")
	#$Deck/DeckDraw.scale *= DeckCardSize/$Deck/DeckDraw.size
	randomize()


func clearScreenForMenu(message):
	
	$HelpButton.visible = false
	$Deck.visible = false
	$DiscardPile.visible = false
	$Player/PlayerBase.visible = false
	$RoundManagement/RoundManagement.visible = false
	enemy.visible = false
	
	$MainMenu/Menu.showMenu(message)
	$HelpWindow/Help.visible = false
	
	
func _on_menu_start_new_game(requestedChar):
	$HelpButton.visible = true
	$Deck.visible = true
	$DiscardPile.visible = true
	$Player/PlayerBase.visible = true
	$RoundManagement/RoundManagement.visible = true
	enemy.visible = true
	
	$MainMenu/Menu.visible = false
	
	clearAllCards()
	await get_tree().create_timer(0.0001).timeout
	
	characterId = requestedChar
	player.setup_player(characterId)
	#make a copy of the deck for this session
	currentDeck = [] + playerDeck.get_deck(characterId)
	currentEnemyList = [] + EnemiesLists.new().CharacterEnemies[requestedChar]
	roundManagementNode.setup_player(characterId)
		
	enemyIndex = 0
	createEnemy()
	initDraw()


func createEnemy():
	var enemyData = EnemiesData.new()
	enemy.setup_enemy(enemyData.get_enemy_data()[currentEnemyList[enemyIndex]], EnemySizeRegular, basePortX)
	

func clearAllCards():
	#clear discard pile and selected cards
	for Card in $CardsInPlay.get_children():
		Card.queue_free()
		
	#clear held cards
	for Card in $CardsInHand.get_children():
		Card.queue_free()
	
	handSize = 0

func getHasCardSelected():
	return selectedCard


#proces card selection and determine how and which cards to highlight
#TODO: expand according to card effect target
func setHasCardSelected(val):
	selectedCard = val
	#does card need targeting?
	var cardContainer = $CardsInHand.get_child(selectedCard)
	var targetsOtherThanSelf = false
	for action in cardContainer.card.actions:
		if action.target == targetEnum.SINGLE:
			targetsOtherThanSelf = true
			break
				#deal with effects
	if !targetsOtherThanSelf:
		calculate_action_effects(cardContainer.card.actions, player, null)
		cardContainer.cardPlayed(true)
		ReParentCard(selectedCard)
		selectedCard = null
		clickReadyAfterSelect = false
		roundManagementNode.actionUpdate()
	else:
		cardContainer.highlightCardWhenSelected()
		manageHighlights(true)
		#async, so thath other click events don't trigger
		await get_tree().create_timer(0.1).timeout
		clickReadyAfterSelect = true

func setClickReady(isReady):
	clickReadyAfterSelect = isReady

#TODO: expand according to card effect target
func manageHighlights(active):
	for i in range($Enemies.get_child_count()):
		$Enemies.get_child(i).highlightMangement(active)
		

func initDraw():
	var waitTime = 0
	var cardsToDraw = player.playerData.handSizeDefault - $CardsInHand.get_child_count() #player.playerData.handSizeDefault - handSize - 1
	for i in range(cardsToDraw):
		if (waitTime == 0):
			waitTime = 0.1
		else:
			await get_tree().create_timer(waitTime).timeout
		draw_card()

func draw_card():
	if( handSize >= player.playerData.handSizeMax):
		#do not go over hand limit
		return
	angle = PI/2 + cardSpread*(float(handSize)/2 - handSize)
	var new_card = CardBase.instantiate()
	if(currentDeck.size() < 1):
		moveDiscardToDeck()
		
	cardSelected = randi() % currentDeck.size()
	
	new_card.setupCard(currentDeck[cardSelected], basePortY)

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
	currentDeck.remove_at(cardSelected)
	
	angle += cardSpread
	
	handSize += 1
	#cardNumber += 1
	
	#reorganize cards when pushing new card
	organizeHand()
	return currentDeck.size()
		
		
func _input(event):
	if $HelpWindow/Help.visible != true && clickReadyAfterSelect && event.is_action_pressed("left_click"):
		#make sure other events blocked by card selection don't trigger before the click is processed
		await get_tree().create_timer(0.0001).timeout
		
		for i in range($Enemies.get_child_count()):
			var enemy = $Enemies.get_child(i)
			var enemytPos = $Enemies.get_child(i).position
			var enemySize = $Enemies.get_child(i).size
			var enemyScale = $Enemies.get_child(i).scale
			var mousepos = get_global_mouse_position() 
			var enemyLive = enemySize * enemyScale
			var enemyReach = enemytPos + (enemySize * enemyScale)
			if (mousepos.x < enemyReach.x && mousepos.y < enemyReach.y 
				&& mousepos.x > enemytPos.x && mousepos.x > enemytPos.x
				&& enemy.state == enemy.enemyState.InPlay
			):
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
		var onPlayerDeath = ""
		match action.target:
			targetEnum.SINGLE:
				
				if("enemy" in owner && "playerData" in target):
					onPlayerDeath = target.playerData.name + owner.enemy.deathMessage
					
				for i in action.execute_times:
					target.manageHealth(action.pool, action.adjust, onPlayerDeath)
				pass
				
			targetEnum.SELF:
				if("playerData" in owner):
					onPlayerDeath = owner.playerData.name + deathMessageSelfDestruct[action.pool]
					
				for i in action.execute_times:
					owner.manageHealth(action.pool, action.adjust * action.execute_times, onPlayerDeath)
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

func discardAllCards():
	for Card in $CardsInHand.get_children():
		Card.cardPlayed(true)
		$CardsInHand.remove_child(Card)
		$CardsInPlay.add_child(Card)
		handSize -= 1
		organizeHand()

func _on_round_management_action_modification(pool, mod):
	player.manageHealthSelf(pool, mod)


func _on_round_management_round_end():
	if $HelpWindow/Help.visible != true:
		for i in range($Enemies.get_child_count()):
			var enemyNode = $Enemies.get_child(i)
			calculate_action_effects(enemyNode.enemy.actions[enemyNode.actionStage], enemyNode, player)
			enemyNode.switchToNextAction()
		
		if (player.isAlive):
			discardAllCards()
			initDraw()
	
func moveDiscardToDeck():
	for Card in $CardsInPlay.get_children():
		currentDeck.append(Card.cardName)
		Card.queue_free()
	pass
	#TODO


func _on_enemy_base_enemy_defeat():
	#create new enemy
	enemyIndex += 1
	if enemyIndex >= currentEnemyList.size():
		clearAllCards()
		clearScreenForMenu("YOU WIN!")
	else:
		createEnemy()
		
		#end round without enemy attacking
		$RoundManagement/RoundManagement.processModifiers()

		#reset deck and hand
		discardAllCards()
		moveDiscardToDeck()
		initDraw()
	

func _on_deck_draw_button_down():
	if( handSize >= player.playerData.handSizeMax):
		#do not go over hand limit
		return
	if $HelpWindow/Help.visible != true && selectedCard == null:
		roundManagementNode.actionUpdate()
		draw_card()
	#do not disable, deck automatically refills
		#if(deckSize == 0):
		#	$Deck/DeckDraw.disabled = true


func _on_player_base_game_over(message):
	clearAllCards()
	clearScreenForMenu(message)


func _on_help_trigger_close():
	$HelpWindow/Help.visible = false


func _on_menu_help_triggered():
	$HelpWindow/Help.switchPage(0)


func _on_in_game_help_button_down():
	$HelpWindow/Help.switchPage(2)
