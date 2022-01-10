extends Area2D

signal ambil_coin

func _on_coin_body_entered(body):
	emit_signal("ambil_coin")
	set_collision_mask_bit(0,false)
	queue_free()
