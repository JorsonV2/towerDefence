extends Control

signal fireTowerButton
signal grassTowerButton
signal waterTowerButton
signal lvlUpButton

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FireTowerButton_pressed():
	emit_signal("fireTowerButton")
	pass # Replace with function body.


func _on_LvlUP_pressed():
	emit_signal("lvlUpButton")
	pass # Replace with function body.


func _on_GrassTowerButton_pressed():
	emit_signal("grassTowerButton")
	pass # Replace with function body.


func _on_WaterTowerButton_pressed():
	emit_signal("waterTowerButton")
	pass # Replace with function body.
