extends HBoxContainer

var answer = preload("res://Scenes/Answer.tscn")
var answer_script = preload("res://Scripts/Answer.gd")
var answer_list = []
func _ready():
	for _i in range(2):
		var a = answer.instance()
		a.set_meta("key", _i+1)
#		a.connect("text_entered", self, "entered", [a.get_meta('key')])
		answer_list.append(a)
		a.set_script(answer_script)
		add_child(a)

func error_one(texts, n):
	print("recieved Error")
	var children = self.get_children()
	children[n-1].error(texts[n])
