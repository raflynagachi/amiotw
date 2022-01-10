extends HBoxContainer

enum MODES {simple, empty}

var heart_full = preload("res://Asset/asset random/heart.png")
var heart_empty = preload("res://Asset/asset random/help.png")

export (MODES) var mode = MODES.empty

func update_health(value):
	match mode:
		MODES.simple:
			update_simple(value)
		MODES.empty:
			update_empty(value)

func update_simple(value):
	for i in get_child_count():
		get_child(i).visible = value > i

func update_empty(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
