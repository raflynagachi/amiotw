extends LineEdit

func _on_LineEdit_text_entered(new_text):
	if new_text == "akatsukif":
		get_tree().change_scene("res://StageSecret.tscn")
