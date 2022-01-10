extends Panel

func _on_Panel3_mouse_entered():
	get_parent().find_node("Label").visible = true
