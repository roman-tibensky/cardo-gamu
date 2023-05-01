const life_pools = {
	RED = "Red",
	BLUE = "Blue",
	GREEN = "Green"
}


enum targetEnum {SINGLE, RANDOM, ALL, SELF}

const statChars = {
	lifeChar = "+", #"\u2764"
	giveLife = "\u2764",
	costChar = "\u2620",
	attackSingleChar = "\u2316",
	attackRandomChar = "\u26A1",
	attackAllChar = "\u2748", #bomb alternative \u1F4A3
	roundsChar = "R",
	specialChar = "*",
	multipleChar = "x",
	countDownChar = "T"
}


const deathMessageSelfDestruct = {
	life_pools.RED: "\'s body broke beyond repair",
	life_pools.GREEN: "\'s soul faded into oblivion",
	life_pools.BLUE: "\'s mana destablized and so did they"
}
