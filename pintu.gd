extends StaticBody2D

var door_open = preload("res://Asset/asset random/door_open.png")

func _process(delta):
	if Global.key_picked_up == true:
		get_node("./Sprite").texture = door_open
		set_collision_mask_bit(0,false)
		set_collision_layer_bit(0, false)
		#queue_free()
