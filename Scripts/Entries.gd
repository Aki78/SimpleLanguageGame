extends HBoxContainer

onready var entry_box = preload("res://Scenes/EntryBox.tscn")
onready var entry_script = preload("res://Scripts/Enter.gd")

signal move_on

var words = Singleton.get_words()
var entry_list =[]
var are_correct = [false, false]

var current = 0
var answers 
func _ready():
	for _i in range(2):
		var entry = entry_box.instance()
		entry.set_meta("key", _i+1)
		entry.connect("text_entered", self, "entered", [entry.get_meta('key')])
		entry_list.append(entry)
		entry.set_script(entry_script)
		add_child(entry)
	
func check_if_all_correct():
	if Singleton.is_all_correct(are_correct):
		yield(get_tree().create_timer(0.5),"timeout")
		next_word(current)
		for _i in range(are_correct.size()):
			are_correct[_i] = false
		for _i in entry_list:
			_i.reload()	

		send_all_correct_signal()
func send_all_correct_signal():
	emit_signal("move_on")
	
func next_word(current):
	if current >= words.size():
		current = 0
	for _i in entry_list:
		_i.editable = true
	
func handle_correct(entry,entry_key):
	entry.editable = false
	entry.correct()
	are_correct[entry_key-1] = true

	Singleton.play_correct()
	check_if_all_correct()
	entry.clear()

func handle_entry(entry_key):

	var current_entry = entry_list[entry_key-1]
	if current_entry.text.empty():
		return
	if current_entry.text.to_lower() == words[current][entry_key].to_lower():
		handle_correct(current_entry,entry_key)
	else:
		handle_error(entry_key)

func handle_error(entry_key):
	print("Error")
#	emit_signal("typed_in_error")
	answers.error_one(words[current], entry_key)
	Singleton.play_incorrect()
	Singleton.shake_cam()

func update_word(current_global, answers_global):
	current = current_global
	answers = answers_global
	
func entered(new_text, entry_key):
	handle_entry(entry_key)
