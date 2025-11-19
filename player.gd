extends CharacterBody2D

var speed : int = 100

func _physics_process(delta: float) -> void:
	var up : bool = Input.is_action_pressed("move_up")
	var down : bool = Input.is_action_pressed("move_down")
	var left : bool = Input.is_action_pressed("move_left")
	var right : bool = Input.is_action_pressed("move_right")
	
	velocity.x = int(right) - int(left)
	velocity.y = int(down) - int(up)
	
	velocity *= speed
	velocity.y += speed * get_gravity().y * delta
	
	move_and_slide()
