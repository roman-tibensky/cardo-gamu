var DeckCards = [
	"card1",
	"card5",
	"card2",
	"card4",
	"card9"
]

func get_size():
	return DeckCards.size()
	
func get_card(card):
	return DeckCards[card]

func add_card(card): 
	DeckCards.append(card)

func remove_card(card):
	DeckCards.remove_at(card)


