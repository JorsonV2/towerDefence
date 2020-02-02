extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var fireTower
export (PackedScene) var grassTower
export (PackedScene) var waterTower

var placingTower
var triggerdTower
var coins = 20

var towers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.connect("fireTowerButton", self, "placeFireTower")
	$Control.connect("grassTowerButton", self, "placeGrassTower")
	$Control.connect("waterTowerButton", self, "placeWaterTower")
	$Control.connect("lvlUpButton", self, "lvlUpTower")
	$Control/MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/NinePatchRect/Label.text = String(coins)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		if placingTower != null:
			var e_pos = $Map1.world_to_map(event.position)
			e_pos = e_pos * 50 - Vector2(25, 25) + Vector2(50, 50)
			placingTower.position = e_pos
			
			if $Map1.get_cellv($Map1.world_to_map(event.position)) == 0:
				var bussy
				for x in towers:
					if x.global_position == placingTower.global_position:
						bussy = true
						break
				if bussy:
					placingTower.get_node("Radius").modulate = Color(1, 0, 0, 1)
				else:
					placingTower.get_node("Radius").modulate = Color(1, 1, 1, 1)		
			else:
				placingTower.get_node("Radius").modulate = Color(1, 0, 0, 1)
			if $Map1.get_cellv($Map1.world_to_map(event.position)) < 0:
				placingTower.visible = false
			else:
				placingTower.visible = true
		else:
			for x in towers:
				if event.position.x <= x.global_position.x + 25 && event.position.x >= x.global_position.x - 25 && event.position.y <= x.global_position.y + 25 && event.position.y >= x.global_position.y - 25:
					x.get_node("Radius").visible = true
					break
				elif x != triggerdTower:
					x.get_node("Radius").visible = false
			pass
			
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if placingTower != null:
				var bussy
				for x in towers:
					if x.global_position == placingTower.global_position:
						bussy = true
						break
				if $Map1.get_cellv($Map1.world_to_map(event.position)) == 0 && !bussy:
					placingTower.placed = true
					placingTower.get_node("Radius").visible = false
					towers.append(placingTower)
					placingTower = null
			else:
				for x in towers:
					if event.position.x <= x.global_position.x + 25 && event.position.x >= x.global_position.x - 25 && event.position.y <= x.global_position.y + 25 && event.position.y >= x.global_position.y - 25:
						if triggerdTower != null:
							triggerdTower.get_node("Radius").visible = false
						x.get_node("Radius").visible = true
						triggerdTower = x
						towerTriggered()
						break
					elif $Map1.get_cellv($Map1.world_to_map(event.position)) != -1:
						triggerdTower = null
						towerUntriggerd()
				pass
		if event.button_index == BUTTON_RIGHT:
			if placingTower != null:
				placingTower.queue_free()
				placingTower = null
				coins += 10
				updateControl()
			else:
				if triggerdTower != null:
					triggerdTower = null
					towerUntriggerd()
				pass

func placeFireTower():
	placingTower = fireTower.instance()
	add_child(placingTower)
	coins -= 10
	updateControl()
	pass
	
func placeGrassTower():
	placingTower = grassTower.instance()
	add_child(placingTower)
	coins -= 10
	updateControl()
	pass
	
func placeWaterTower():
	placingTower = waterTower.instance()
	add_child(placingTower)
	coins -= 10
	updateControl()
	pass
	
func addCoins(c):
	coins += c
	updateControl()
	
func updateControl():
	$Control/MarginContainer/HBoxContainer/VBoxContainer/MarginContainer/NinePatchRect/Label.text = String(coins)
	if coins < 10:
		$Control/MarginContainer/HBoxContainer/BuyTowers/FireTowerButton.disabled = true
		$Control/MarginContainer/HBoxContainer/BuyTowers/GrassTowerButton.disabled = true
		$Control/MarginContainer/HBoxContainer/BuyTowers/WaterTowerButton.disabled = true
	else:
		$Control/MarginContainer/HBoxContainer/BuyTowers/FireTowerButton.disabled = false
		$Control/MarginContainer/HBoxContainer/BuyTowers/GrassTowerButton.disabled = false
		$Control/MarginContainer/HBoxContainer/BuyTowers/WaterTowerButton.disabled = false
		
	if $Control/MarginContainer/HBoxContainer/Updates.visible:
		$Control/MarginContainer/HBoxContainer/Updates/Info1/Speed/Var/Label.text = "%-10.2f" % triggerdTower.shoot_speed
		$Control/MarginContainer/HBoxContainer/Updates/Info1/Radius/Var/Label.text = "%-10.0f" % triggerdTower.radius
		$Control/MarginContainer/HBoxContainer/Updates/Info2/Lvl/Var/Label.text = String(triggerdTower.lvl)
		$Control/MarginContainer/HBoxContainer/Updates/Info2/Dmg/Var/Label.text = "%-10.0f" % triggerdTower.dmg
		$Control/MarginContainer/HBoxContainer/Updates/LvlUPInfo/Cost/NinePatchRect/Label.text = String(triggerdTower.lvl * 10)
		
		if coins >= triggerdTower.lvl * 10:
			$Control/MarginContainer/HBoxContainer/Updates/LvlUP.disabled = false
		else:
			$Control/MarginContainer/HBoxContainer/Updates/LvlUP.disabled = true
		
	pass
	
func towerTriggered():
	$Control/MarginContainer/HBoxContainer/Updates.visible = true
	updateControl()
	pass
	
func towerUntriggerd():
	$Control/MarginContainer/HBoxContainer/Updates.visible = false
	pass
	
func lvlUpTower():
	coins -= triggerdTower.lvl * 10
	triggerdTower.lvl_up()
	updateControl()
	pass
