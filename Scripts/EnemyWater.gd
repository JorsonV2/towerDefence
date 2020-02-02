extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var move_speed = 50
var hp = 40
var coins = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgress.max_value = hp
	$TextureProgress.value = hp
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().offset += move_speed * delta
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet") and area.enemy == $".":
		var dmg_multi
		if area.dmg_type == "water":
			dmg_multi = 1
		elif area.dmg_type == "grass":
			dmg_multi = 2
		elif area.dmg_type == "fire":
			dmg_multi = 0.5
		$TextureProgress.value -= area.dmg * dmg_multi
		area.queue_free()
		if $TextureProgress.value <= 0:
			get_node("/root/MainScene").addCoins(coins)
			$".".queue_free()
			pass
		pass
	pass # Replace with function body.
	
func update_enemy(lvl):
	move_speed += lvl * 4
	hp += lvl * 2
	coins += lvl / 5
	$TextureProgress.max_value = hp
	$TextureProgress.value = hp
	pass