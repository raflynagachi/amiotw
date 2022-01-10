extends Area2D

signal ambil_woman

func _on_woman_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("ambil_woman")
		set_collision_mask_bit(0,false)
		queue_free()
