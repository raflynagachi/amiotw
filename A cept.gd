extends KinematicBody2D

var velocity = Vector2(0,0)
var coins = 0
var health = 3
var SPEED = 300
const GRAVITY = 30
const JUMPFORCE = -900
var hadap_kanan = true

var sword = preload("res://sword.tscn")
var sword_speed = 300
var sword_rot_speed = 15
onready var throw_hand = $Position2D

func _ready():
	SPEED = 300
	Global.stage_path = get_tree().current_scene.filename

func _physics_process(delta):
	if Input.is_action_pressed("jalankanan"):
		velocity.x = SPEED
		sword_speed = SPEED*1.2
		$Sprite.play("Jalan")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("jalankiri"):
		velocity.x = -SPEED
		sword_speed = -SPEED*1.2
		$Sprite.play("Jalan")
		$Sprite.flip_h = true
	else:
		$Sprite.play("Idle")
		
	if not is_on_floor():
		$Sprite.play("Udara")

	velocity.y = velocity.y + GRAVITY

	if Input.is_action_just_pressed("lompat") and is_on_floor():
		velocity.y = JUMPFORCE
		$SuaraLompat.play()

	velocity = move_and_slide(velocity,Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.2)
	
	if Input.is_action_just_pressed("attack") and Global.sword_num > 0:
		var new_sword = sword.instance()
		new_sword.set("speed", sword_speed)
		new_sword.set("rot_speed", sword_rot_speed)
		new_sword.position = throw_hand.global_position
		get_tree().current_scene.add_child(new_sword)
		Global.sword_num -= 1
		$SuaraPedang.play()
	
	if Input.is_action_just_pressed("ultimate") and Global.sword_num > 0:
		get_parent().find_node("HUD").find_node("Ulti text").visible = true
		get_parent().find_node("HUD").find_node("UltimateSound").play()
		for i in range(Global.sword_num):
			var new_sword = sword.instance()
			new_sword.set("speed", sword_speed)
			new_sword.set("rot_speed", sword_rot_speed)
			new_sword.position = throw_hand.global_position
			new_sword.position.y -= 30*i
			get_tree().current_scene.add_child(new_sword)
			$SuaraPedang.play()
			yield(get_tree().create_timer(.07),"timeout")
			#get_parent().find_node("HUD")._physics_process(delta)
		Global.sword_num = 0
		get_parent().find_node("HUD").find_node("Ulti text").visible = false

func _on_jatuh_body_entered(body):
	$SuaraJatuh.play()
	SPEED = 0
	yield(get_tree().create_timer(.8), "timeout")
	$Timer.start()
	Global.key_picked_up = false
	Global.sword_num = 10

func bounce():
	velocity.y = JUMPFORCE * 0.7

func itai(var musuhposx):
	velocity.y = JUMPFORCE * 0.5
	
	if position.x < musuhposx:
		velocity.x = -800
	elif position.x > musuhposx:
		velocity.x = 800
		
	Input.action_release("jalankanan")
	Input.action_release("jalankiri")
	Global.key_picked_up = false
	
	health -= 1
	$SuaraLuka.play()
	get_parent().find_node("HUD").find_node("HealthBox").update_health(health)
	
	if health <= 0:
		set_modulate(Color(1,0.3,0.3,0.3))
		$Timer.start()
	else:
		set_modulate(Color(1,0.3,0.3,0.3))
		yield(get_tree().create_timer(.25), "timeout")
		set_modulate(Color(1,1,1))
		yield(get_tree().create_timer(.25), "timeout")
		set_modulate(Color(1,0.3,0.3,0.3))
		yield(get_tree().create_timer(.25), "timeout")
		set_modulate(Color(1,1,1))

func _on_Timer_timeout():
	Global.sword_num = 10
	Global.key_picked_up = false
	SPEED = 0
	yield(get_tree().create_timer(.8), "timeout")
	get_parent().find_node("syringe").find_node("congrats").pitch_scale = 0.7
	get_parent().find_node("syringe").find_node("congrats").play()
	yield(get_tree().create_timer(2), "timeout")
	get_parent().find_node("syringe").find_node("congrats").pitch_scale = 3
	get_tree().change_scene("res://gameover.tscn")

func _on_hitbox_area_entered(area):
	if area.is_in_group("kunci"):
		Global.key_picked_up = true
		var sound = get_parent().find_node("pintu").find_node("key_sound")
		area.get_parent().queue_free()
		sound.play()
	
func _on_medkit_ambil_medkit():
	health += 1
	get_parent().find_node("medkit").find_node("healingSound").play()
	get_parent().find_node("HUD").find_node("HealthBox").update_health(health)

func _on_syringe_ambil_syringe():
	Global.key_picked_up = false
	Global.sword_num = 10
	get_parent().find_node("syringe").find_node("sound").play()
	get_parent().find_node("HUD").find_node("WIN").visible = true
	yield(get_tree().create_timer(.8), "timeout")
	get_parent().find_node("syringe").find_node("congrats").play()
	yield(get_tree().create_timer(3), "timeout")
	if Global.stage_path == "res://Stage1.tscn":
		get_tree().change_scene("res://Stage2.tscn")
	else:
		get_tree().change_scene("res://win.tscn")


func _on_woman_ambil_woman():
	Global.key_picked_up = false
	Global.sword_num = 10
	get_parent().find_node("woman").find_node("sound").play()
	get_parent().find_node("HUD").find_node("WIN").visible = true
	yield(get_tree().create_timer(.8), "timeout")
	get_parent().find_node("woman").find_node("congrats").play()
	yield(get_tree().create_timer(.8), "timeout")
	get_tree().change_scene("res://win.tscn")
