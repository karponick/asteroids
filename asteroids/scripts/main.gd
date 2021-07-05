extends Node2D

const ship = preload("res://scenes/ship.tscn")
const rock = preload("res://scenes/rock.tscn")

var score = 0

func _ready():
	var Player = ship.instance()
	self.add_child(Player)
	$UI/Label.text = str(score)

func _on_Timer_timeout():
	var new_rock = rock.instance()
	new_rock.set_base()
	self.add_child(new_rock)

func add_point():
	score += 1
	$UI/Label.text = str(score)
	
func rock_split(pos, rot):
	var rot_dev = 20
	var rock_a = rock.instance()
	var rock_b = rock.instance()
	rock_a.position = pos
	rock_b.position = pos + Vector2(30, 30)
	rock_a.rotation_degrees = rot - rot_dev
	rock_b.rotation_degrees = rot + rot_dev
	rock_a.set_scale(1.5)
	rock_b.set_scale(1.5)
	rock_a.speed_up()
	rock_b.speed_up()
	self.add_child(rock_a)
	self.add_child(rock_b)
