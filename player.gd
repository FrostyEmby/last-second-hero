extends CharacterBody2D

var init_speed : int = 5
var accel : int = 3
var jump_force : int = 300

func _animate(x_dir : int):
	if x_dir == -1:
		$Sprite2D.flip_h = true
	if x_dir == 1:
		$Sprite2D.flip_h = false
		
	if velocity.x != 0:
		if x_dir == -1:
			rotate(-PI/12)
		if x_dir == 1:
			$Sprite2D.flip_h = false
			rotate(PI/12)
	
func _physics_process(delta: float) -> void:
	var up : bool = Input.is_action_pressed("move_up")
	var down : bool = Input.is_action_pressed("move_down")
	var left : bool = Input.is_action_pressed("move_left")
	var right : bool = Input.is_action_pressed("move_right")
	
	var x_dir : int = int(right) - int(left)
	var y_dir : int = int(down) - int(up)
	
	if x_dir != 0:
		if is_on_wall():
			velocity.x = init_speed
		if velocity.x == 0:
			velocity.x = init_speed
		else:
			velocity.x += x_dir * accel
	else:
		velocity.x = 0
	
	if is_on_floor():
		velocity.y += y_dir * sqrt(get_gravity().y * jump_force)
	
	velocity += get_gravity() * delta
	
	_animate(x_dir)
	move_and_slide()
