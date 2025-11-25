extends CharacterBody2D


@export var init_speed : int = 5
@export var accel : int = 3
@export var jump_force : int = 300

var prev_x_dir : int = 0
var x_dir : int = 0

var prev_y_dir : int = 0
var y_dir : int = 0

func _lean(angle : float):
	var rotate_tween = create_tween()
	
	if x_dir == 0:
		rotate_tween.tween_property($Sprite2D,"rotation", 0, 0.1)
		rotation = 0
	if x_dir == -1:
		$Sprite2D.flip_h = true
		rotate_tween.tween_property($Sprite2D,"rotation", -angle, 0.1)
		#rotation = -angle
	if x_dir == 1:
		$Sprite2D.flip_h = false
		rotate_tween.tween_property($Sprite2D,"rotation", angle, 0.1)
		#rotation = angle

func _animate():
	if x_dir != prev_x_dir:
		prev_x_dir = x_dir # update to inform next frame
		_lean(PI/12)
	
	
func _physics_process(delta: float) -> void:
	var up : bool = Input.is_action_pressed("move_up")
	var down : bool = Input.is_action_pressed("move_down")
	var left : bool = Input.is_action_pressed("move_left")
	var right : bool = Input.is_action_pressed("move_right")
	
	x_dir = int(right) - int(left)
	y_dir = int(down) - int(up)
	
	if x_dir != 0: # if moving left or right
		#if is_on_wall():
		#	velocity.x = init_speed
		if velocity.x == 0:
			velocity.x = init_speed
		else:
			velocity.x += x_dir * accel
	else:
		velocity.x = 0
	
	if is_on_floor():
		velocity.y += y_dir * sqrt(get_gravity().y * jump_force)
	
	velocity += get_gravity() * delta
	
	_animate()
	move_and_slide()
