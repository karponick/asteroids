extends KinematicBody2D

var speed = 200
var velocity
var ss
var scl = 0.5

func _ready():
	ss = get_viewport().size
	modulate = Color(randf(), randf(), randf())
	scale = Vector2(scl, scl)

func _process(delta):
	check_bounds()
	var collision = move_and_collide(velocity * delta)
	if collision:
		var obj = collision.get_collider()
		if obj.collision_layer == 4:
			obj.split()
			get_parent().add_point()
#		get_parent().remove_child(self)
		queue_free()
	
func set_velocity(ship_rotation):
	velocity = Vector2(cos(ship_rotation), sin(ship_rotation)) * speed


func check_bounds():
	if position.x < 0 or position.x > ss.x or position.y < 0 or position.y > ss.y:
#		get_parent().remove_child(self)
		queue_free()
