extends KinematicBody2D

var speed = 50
var velocity
var ss
var bounds = 20
var base = false

func _ready():
	randomize()
	ss = get_viewport().size
	modulate = Color(randf(), randf(), randf())
	if base:
		base_setup()
	velocity = Vector2(cos(rotation), sin(rotation)) * speed


func _process(delta):
	check_bounds()
	var collision = move_and_collide(velocity * delta)
	if collision:
		var obj = collision.get_collider()
		if obj.collision_layer == 4:
			var obj_vel = obj.get_velocity()
			velocity.x *= obj_vel.x / abs(obj_vel.x)
			velocity.y *= obj_vel.y / abs(obj_vel.y)

func check_bounds():
	var lx = position.x < -bounds
	var hx = position.x > ss.x + bounds
	var ly = position.y < -bounds
	var hy = position.y > ss.y + bounds
	if lx or hx or ly or hy:
#		get_parent().remove_child(self)
		queue_free()

func set_scale(scl):
	scale = Vector2(scl, scl)
	
func speed_up():
	speed = 100

func base_setup():
	set_scale(3)
	
	var rand_val = randf()*400
	var options = [
		Vector2(-10, rand_val), 
		Vector2(ss.x + 10, rand_val), 
		Vector2(rand_val, -10), 
		Vector2(rand_val, ss.y + 10)
	]
	position = options[randi() % options.size()]
	rotation = get_angle_to(ss/2)

func set_base():
	base = true
	
func get_velocity():
	return velocity

func split():
	if base:
		get_parent().rock_split(position, rotation_degrees)
#	get_parent().remove_child(self)
	queue_free()
