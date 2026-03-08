extends Control

#starting dialogue scene
var dialogue = [
	"One day, you have a dream...",
	"Your eyes go turn into colours...",
	"A giant crystal glows in the center of your view",
	"Suddenly, your mind goes blank",
]

var index = 0
var typing = false
var char_delay = 0.02

@onready var label = $Panel/Label
@onready var next_button = $next_button

func show_line(line_index):
	"""
	Shows line
	Args:
		line_index (int)
	"""
	typing = true
	label.text = ""
	var text = dialogue[line_index]
	await typewriter(text)

#typewriter effect
func typewriter(text):
	"""
	Typewrite effect
	Args:
		text (str)
	"""
	for i in range(1, text.length() + 1):
		label.text = text.substr(0,i)
		await get_tree().create_timer(char_delay).timeout
	typing = false
	next_button.disabled = false
func _ready():
	"""
	shows text
	"""
	if next_button == null:
		push_error("UHH")
	else:
		print("AHH", next_button)
	#next_button.disabled = true
	show_line(index)

func _on_next_button_pressed():
	"""
	moves on to game scene
	"""
	if typing:
		label.text = dialogue[index]
		next_button.disabled = false
		typing = false
		return 
	index += 1
	if index < dialogue.size():
		show_line(index)
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	
