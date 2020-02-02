extends TileMap

export (PackedScene) var EnemyFire
export (PackedScene) var EnemyGrass
export (PackedScene) var EnemyWater


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var wave_size = 10
var wave_num = 1
var spawnEnemy

func _init():
	randomize()
	set_new_spawn_enemy()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SpawnTimer_timeout():
	if wave_size == 0:
		wave_num += 1
		set_new_spawn_enemy()
		wave_size = 10
	var path_follow = PathFollow2D.new()
	path_follow.rotate = false
	path_follow.loop = true
	$Path2D.add_child(path_follow)
	var enemy
	if spawnEnemy == 0:
		enemy = EnemyFire.instance()
	elif spawnEnemy == 1:
		enemy = EnemyGrass.instance()
	elif spawnEnemy == 2:
		enemy = EnemyWater.instance()
	
	path_follow.add_child(enemy)
	enemy.update_enemy(wave_num)
	
	wave_size -= 1
	
	pass # Replace with function body.
	
func set_new_spawn_enemy():
	
	spawnEnemy = randi() % 3
	pass
