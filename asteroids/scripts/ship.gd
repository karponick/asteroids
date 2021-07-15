extends KinematicBody2D

var thrusting = false
var velocity = Vector2.ZERO
var max_speed = 150
var acceleration = 0.6
var friction = .01
var rot_val = 5
var bullet_cd = .5
var scl = .7
var ss

const bullet = preload("res://scenes/bullet.tscn")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	ss = get_viewport().size
	position = Vector2(ss.x, ss.y) / 2
	scale = Vector2(scl, scl)

func _process(delta):
	move_binds()
	if thrusting:
		velocity.x = lerp(0, cos(rotation) * max_speed, acceleration)
		velocity.y = lerp(0, sin(rotation) * max_speed, acceleration)
	elif velocity != Vector2.ZERO:
		velocity.x = lerp(velocity.x, 0, friction)
		velocity.y = lerp(velocity.y, 0, friction)
	
	position.x = wrapf(position.x, 0, ss.x)
	position.y = wrapf(position.y, 0, ss.y)
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var obj = collision.get_collider()
		if obj.collision_layer == 4:
			get_parent().game_over()
#			get_parent().remove_child(self)
			queue_free()

func move_binds():
	if Input.is_action_pressed("rotate_left"):
		rotation_degrees -= rot_val
	if Input.is_action_pressed("rotate_right"):
		rotation_degrees += rot_val
	if Input.is_action_pressed("thrust"):
		thrusting = true
	else:
		thrusting = false
		
	if Input.is_action_pressed("fire") and $Timer.is_stopped():
		var new_bullet = bullet.instance()
		new_bullet.set_velocity(rotation)
		new_bullet.position = $Gun.global_position
		get_parent().add_child(new_bullet)
		$Timer.start(bullet_cd)
