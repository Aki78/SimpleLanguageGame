extends Label

export (Color) var incorrect_color
export var time = 0.5

onready var color_tween1 = $Color1
onready var color_tween2 = $Color2

var invisible = Color(1,0,0,0)
var self_color = Color(1,0,0,1000)

func _ready():
	add_color_override("font_color", Color(1,1,1,0.001))

func error(text: String):
	self.text = text
	print(text,"Entered error text")
	modulate = incorrect_color
	color_tween1.stop_all()
	color_tween2.stop_all()
	color_tween1.interpolate_property(self,'modulate',invisible,self_color,time,
		Tween.TRANS_LINEAR,Tween.EASE_IN)
	color_tween1.start()

	yield(color_tween1, "tween_completed")
	color_tween2.interpolate_property(self,'modulate',self_color,invisible,time,
		Tween.TRANS_LINEAR,Tween.EASE_IN)
	color_tween2.start()


