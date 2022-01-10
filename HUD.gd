extends CanvasLayer

var coins = 0

func _ready():
	$Coins.text = String(coins)
	$Swords.text = String(Global.sword_num)

func _physics_process(delta):
	_ready()
	if coins == 100:
		get_tree().change_scene(Global.stage_path)

func _on_coin_ambil_coin():
	coins = coins + 1
	$SuaraCoin.play()
	Global.sword_num += 2
	_ready()
