extends KinematicBody2D

var speed = 50
var velocity = Vector2()
export var arah = 1
export var deteksi_ujung = true

func _ready():
	$AnimatedSprite.play("jalan")
	if arah == -1:
		$AnimatedSprite.flip_h = true
	$cek_ground.enabled = deteksi_ujung
	if deteksi_ujung:
		set_modulate(Color8(247,71,71))
	
func _physics_process(delta):
	if is_on_wall() or not $cek_ground.is_colliding() and deteksi_ujung and is_on_floor():
		arah = arah * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$cek_ground.position.x = $CollisionShape2D.shape.get_extents().x * arah
	
	velocity.y += 0
	
	velocity.x = speed * arah
	
	velocity = move_and_slide(velocity,Vector2.UP)


func _on_cek_atas_body_entered(body):
	speed = 0
	set_collision_layer_bit(5,false)
	set_collision_mask_bit(0,false)
	$cek_atas.set_collision_layer_bit(5,false)
	$cek_atas.set_collision_mask_bit(0,false)
	$cek_samping.set_collision_layer_bit(5,false)
	$cek_samping.set_collision_mask_bit(0,false)
	$Timer.start()
	body.bounce()

func _on_cek_samping_body_entered(body):
	body.itai(position.x)


func _on_Timer_timeout():
	queue_free()
