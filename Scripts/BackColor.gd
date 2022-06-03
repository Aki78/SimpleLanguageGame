extends ColorRect


export(Gradient) var gradient

onready var back_tween = $BackTween

func _ready():
	var time = 1.0
	
	var colors = gradient.colors
	for idx in range(colors.size()):
		var color = colors[idx]
		var last_color
		if idx-1 < 0:
			last_color = colors[colors.size()-1]
		else:
			last_color = colors[idx-1]
		back_tween.interpolate_property(self,'color',last_color,color,time,
			Tween.TRANS_LINEAR,Tween.EASE_IN,time*idx)
	back_tween.start()


