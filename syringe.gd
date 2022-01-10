extends Area2D

signal ambil_syringe

func _on_syringe_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("ambil_syringe")
		set_collision_mask_bit(0,false)
		queue_free()
