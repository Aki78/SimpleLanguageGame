extends Label

export (Color) var incorrect_color
export (Color) var correct_color
export var time = 1.0

onready var color_tween = $Color

func error():
	modulate = incorrect_color
	color_tween.stop_all()
	color_tween.interpolate_property(self,'modulate',incorrect_color,Color(1,1,1),time,
		Tween.TRANS_LINEAR,Tween.EASE_IN)
	color_tween.start()

func correct():
	modulate = correct_color
	color_tween.stop_all()
	color_tween.interpolate_property(self,'modulate',correct_color,Color(1,1,1),time,
		Tween.TRANS_LINEAR,Tween.EASE_IN)
	color_tween.start()
