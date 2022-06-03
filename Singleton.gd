extends Node2D

var words = []


onready var incorrect_sound =AudioStreamPlayer.new()
onready var correct_sound =AudioStreamPlayer.new()
onready var camera_script = preload("res://Scripts/Camera.gd")
onready var camera = Camera2D.new()

var word_data = {}

func _ready() -> void:
	
	#setting up sound
	var sound_incorrect :AudioStream = preload("res://Resources/incorrect.ogg") 
	var sound_correct :AudioStream = preload("res://Resources/correct.ogg") 
	incorrect_sound.set_stream(sound_incorrect)
	correct_sound.set_stream(sound_correct)
	add_child(incorrect_sound)
	add_child(correct_sound)
	
	#setting up camera
	camera.set_script(camera_script)
	camera.make_current()
	camera.process_mode = 1
	camera.anchor_mode = 0
	add_child(camera)
	
func get_words():
	var file = File.new()
	
	if file.open('data.json',File.READ) == OK:
	
		word_data = parse_json(file.get_as_text())
		words = word_data.words
		
		file.close()
	return words

func shake_cam():
	camera.shake_amount += 2.0

func play_incorrect():
	incorrect_sound.play()

func play_correct():
	correct_sound.play()

# Helper Functions
func is_all_correct(bool_list):
	var bool_val = true
	for _i in bool_list:
		if !_i:
			bool_val = false
	return  bool_val
