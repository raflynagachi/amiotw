extends Area2D

signal ambil_medkit

func _on_medkit_body_entered(body):
	if get_node('../../A cept').health < 3:
		if body.is_in_group("player"):
			emit_signal("ambil_medkit")
			set_collision_mask_bit(0,false)
			queue_free()
