extends Camera3D

@export var velocidad_inicial: float = 2.0
@export var aceleracion: float = 0.5
@export var limite_velocidad: float = 15.0

var velocidad_actual: float = 0.0
var direccion: Vector3 = Vector3(1, 0, 0)  # Mover hacia la derecha

func _ready():
	velocidad_actual = velocidad_inicial

func _process(delta: float):
	# Incrementar la velocidad con aceleración
	velocidad_actual += aceleracion * delta
	velocidad_actual = min(velocidad_actual, limite_velocidad)

	# Mover la cámara hacia la derecha
	translate(direccion * velocidad_actual * delta)
