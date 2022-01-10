extends Area2D

var speed = 300
var rot_speed = 15
var moveable = true

func _physics_process(delta):
	if moveable == true:
		position.x += speed	* delta
		rotate(deg2rad(rot_speed))	

func remove():
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	print("sword exited")

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
		speed = 0
		rot_speed = 0
		moveable = false
		position.x += 22
		if body.is_in_group("ground enemy"):
			$SlimeHit.play()
		else:
			$BatHit.play()
		yield(get_tree().create_timer(1.5),"timeout")
		remove()
