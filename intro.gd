extends VideoPlayer

func _on_intro_finished():
	get_tree().change_scene("res://menu.tscn")
