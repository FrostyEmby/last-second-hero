extends Control

func _process(_delta: float) -> void:
	$Time.text = str($Timer.time_left)
