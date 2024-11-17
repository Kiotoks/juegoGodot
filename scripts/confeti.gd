extends Node3D
@onready var verde: CPUParticles3D = $verde
@onready var rojo: CPUParticles3D = $rojo
@onready var azul: CPUParticles3D = $azul
@onready var amarillo: CPUParticles3D = $amarillo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func activar():
	verde.emitting = true
	rojo.emitting = true
	azul.emitting = true
	amarillo.emitting = true
	print("¡Confeti activado!")
# Called every frame. 'delta' is the elapsed time since the previous frame.
