extends Control

onready var word = $WordBox/Word
onready var answers = $WordBox/Answeres
onready var entries = $WordBox/Entries

var words = Singleton.get_words()
var current_word = 0

func _ready():
	entries.connect("move_on",self,"add_one")
	entries.update_word(current_word, answers)
	show_word()

func add_one():
	if  current_word < words[0].size()-1:
		current_word += 1
	else:
		current_word = 0
	
	entries.update_word(current_word, answers)
	show_word()

func show_word():
	word.text = words[current_word][0]

