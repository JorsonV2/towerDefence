extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bullet_speed = 200

var enemy
var dmg
var dmg_type

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_instance_valid(enemy):
		global_position += get_global_position().direction_to(enemy.global_position) * bullet_speed * delta
		pass
	else:
		$".".queue_free()
		pass
	pass
