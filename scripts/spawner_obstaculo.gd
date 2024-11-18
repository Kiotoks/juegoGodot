extends Node3D

var obstaculo = preload("res://assets/obstaculo.tscn")
@onready var timer: Timer = $Timer
var intervalo = RandomNumberGenerator.new().randf_range(1, 5)

func _ready():
	timer.start(intervalo)

func _on_timer_timeout() -> void:
	intervalo = RandomNumberGenerator.new().randf_range(1, 5)
	timer.wait_time = intervalo
	var o = obstaculo.instantiate()
	add_child(o)
	o.global_transform = self.transform
