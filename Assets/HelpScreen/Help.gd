extends MarginContainer

const constants = preload("res://constants.gd")
const statChars = constants.new().statChars


var currentPage = 0
signal triggerClose

	
const helpPages = [
	
	"Your fights will be carried out in rounds. Each round you'll get a set number of random skills you can perform. You can either use these skills or attempt to draw more skill, if you are below your max available card limit. Using skills or drawing new ones both constitute an action.\n\n" +
	"You can use as many actions as you like, but each and every use potentially puts a strain on your body. Using too many actions will start sapping your resource. Alternatively, you can opt to not use any and recover a little bit of your resources.\n\n" +
	"Ending your turn discards your hand and lets your enemy perform an action.",
	
	"Every living being has three basic attributes it needs to exist:  [color=#ff0000]BODY[/color], [color=#00ff00]SPIRIT[/color] and [color=#0000ff]MANA[/color]. Should any living being lose one of these attributes, it'll experience instability that usually will lead to its destruction. If you wish to survive, you have to manage you own life essences while attacking the one's of your opponents.\n\n" +
	"In order to do so, you have a variety of skills at your disposal represented by cards. However, skills usually come with a cost. You will need to sacrifice part of your own [color=#ff0000]BODY[/color], [color=#00ff00]SPIRIT[/color] or [color=#0000ff]MANA[/color] in order to use them.",


	"Action symbols:\n\n" +
	statChars.lifeChar + "= heal attribute for X points\n" +
	statChars.giveLife + "= heal opponent's attribute for X points\n" +
	statChars.costChar + "= pay X points of own attribute\n" +
	statChars.attackSingleChar + "= attack a single opponent's attribute for X points\n" +
	statChars.attackRandomChar + "= attack a random opponent's attribute for X points\n" +
	statChars.attackAllChar + "= attack all opponents' attribute for X points\n" +
	statChars.roundsChar + "= repeat action for X rounds\n" +
	statChars.multipleChar + "= repeat action for X times\n" +
	statChars.countDownChar + "= trigger action after X rounds"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	switchPage(2)
	$HelpBackground.scale = size / Vector2($HelpBackground.texture.get_width(), $HelpBackground.texture.get_height())
	position.x = (get_viewport().size.x / 2) - (size.x / 2)
	position.y = (get_viewport().size.y / 2) - (size.y / 2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func switchPage(i):
	currentPage = i
	$VBoxContainer/Instructions/VBoxContainer/PageText/RichTextLabel.text = helpPages[currentPage]
	$VBoxContainer/Instructions/VBoxContainer/ButtonLine/PageCount/CenterContainer/Label.text = str(currentPage + 1) + " / " + str(helpPages.size())
	visible = true
	

	
	
func _on_prev_page_button_down():
	switchPage((currentPage + helpPages.size() - 1) % helpPages.size())
	pass # Replace with function body.
	

func _on_next_page_button_down():
	switchPage((currentPage + 1) % helpPages.size())
	pass # Replace with function body.




func _on_texture_button_button_down():
	triggerClose.emit()
	pass # Replace with function body.
