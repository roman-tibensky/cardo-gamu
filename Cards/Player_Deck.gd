var DeckCards1 = [
	"card1",
	"card1",
	"card1",
	"card5",
	"card5",
	"card2",
	"card4",
	"card9"
]

var DeckCards2 = [
	"card1",
	"card1",
	"card1",
	"card5",
	"card5",
	"card2",
	"card4",
	"card9"
]

var CharacterHands = {
	Character1 = DeckCards1, 
	Character2 = DeckCards2, 
}

func get_size(char):
	return CharacterHands[char].size()
	
func get_card(char, card):
	return CharacterHands[char][card]

func add_card(char, card): 
	CharacterHands[char].append(card)

func remove_card(char, card):
	CharacterHands[char].remove_at(card)


