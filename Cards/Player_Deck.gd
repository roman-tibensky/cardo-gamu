var DeckCards1 = [
	"unBaseShout",
	"unBaseShout",
	"unBaseManaRelease",
	"unBaseManaRelease",
	"unManaGeneration",
	"unManaGeneration",
	"unLifeHeal",
	"unMeditation",
	"unAwkwardPunch",
	"unAgryPounce",
	"unCastHeal",
	"unSiphonHealth",
	"unCalmSpirit",
	"unManaLeech",
	"unManaCrush"

]

var DeckCards2 = [
#	"bbCardGreenKill",
#	"bbBlueSelfMurder",
#	"bbGreenSelfMurder",
#	"bbCardGreenKill",
	"bbCardGreenKill",
	"bbCardGreenKill",
	"bbCardGreenKill",
	"bbCardGreenKill",
	"bbCardGreenKill",
	"bbCardGreenKill",
	"bbCard0"
]

var CharacterHands = {
	Character1 = DeckCards1, 
	Character2 = DeckCards2, 
}

func get_size(char):
	return CharacterHands[char].size()

func get_deck(char):
	return CharacterHands[char]
	
func get_card(char, card):
	return CharacterHands[char][card]

func add_card(char, card): 
	CharacterHands[char].append(card)

func remove_card(char, card):
	CharacterHands[char].remove_at(card)


