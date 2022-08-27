extends Node2D

#var CardSize = Vector2(281, 338)
var CardSize = Vector2(168, 203)
const CardBase = preload("res://CardBase.tscn")
const PlayerHand = preload("res://Player_Hand.gd")
var cardSelected
onready var deckSize = PlayerHand.HandCards.size()

# some horrifying oval math thing
onready var centerCardOval = get_viewport().size * Vector2(0.5, 1.25)
onready var horRad = get_viewport().size.x * 0.45
onready var verRad = get_viewport().size.y * 0.4
var angle = deg2rad(90) - 0.6
var ovalAngleVector = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func draw_card():
	print("DRAW ME A CARD")
	var new_card = CardBase.instance()
	cardSelected = randi() % deckSize
	
	new_card.cardName = PlayerHand.HandCards[cardSelected]

	# continue horrifying oval math thing
	ovalAngleVector = Vector2(horRad * cos(angle), -verRad * sin(angle))
	new_card.rect_position = centerCardOval + ovalAngleVector - new_card.rect_size/2
	new_card.rect_scale *= CardSize/new_card.rect_size
	
	#TODO: pixelated and ugly; research why later
	#new_card.rect_rotation = (90 - rad2deg(angle)) / 4
	
	
	$Cards.add_child(new_card)
	PlayerHand.HandCards.remove(cardSelected)
	
	angle += 0.25
	deckSize = PlayerHand.HandCards.size()
	return deckSize
		
