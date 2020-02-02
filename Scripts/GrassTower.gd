extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shoot_speed = 1
var dmg = 10
var radius = 75
var placed = false
var lvl = 1

export (PackedScene) var Bullet

var visable_enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	confTower()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if placed and visable_enemies.size() > 0:
		look_at(visable_enemies[0].get_global_position())
		pass
	pass

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		if visable_enemies.size() == 0:
			$Timer.paused = false
			$Timer.start()
			pass
		visable_enemies.append(area)
		pass
	pass # Replace with function body.

func _on_Area2D_area_exited(area):
	if area.is_in_group("enemy"):
		visable_enemies.erase(area)
		if visable_enemies.size() == 0:
			$Timer.paused = true
			pass
		pass
	pass # Replace with function body.

func _on_Timer_timeout():
	if placed:
		var bullet = Bullet.instance()
		bullet.global_position = $Node2D.global_position
		bullet.enemy = visable_enemies[0]
		bullet.dmg = dmg
		bullet.dmg_type = "grass"
		$"..".add_child(bullet)
		pass
	pass # Replace with function body.
	
func lvl_up():
	lvl += 1
	shoot_speed *= 1
	dmg *= 2
	radius *= 1
	confTower()
	pass
	
func confTower():
	$CollisionShape2D.shape.set_radius(radius)
	$Radius.rect_size = Vector2(radius*2,radius*2)
	$Radius.rect_position = Vector2(-radius, -radius)
	$Timer.wait_time = shoot_speed
	pass
	
