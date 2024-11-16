extends Camera3D

@export var velocidad_inicial: float = 2.0
@export var aceleracion: float = 0.5
@export var limite_velocidad: float = 15.0
@export var distancia_area: float = 5.0  # Distancia detrás de la cámara para la zona de muerte

var velocidad_actual: float = 0.0
var direccion: Vector3 = Vector3(1, 0, 0)  # Mover hacia la derecha
var zona_muerte: Area3D

func _ready():
	velocidad_actual = velocidad_inicial
	# Obtener el nodo ZonaMuerte (debe estar dentro de la Camera3D)
	zona_muerte = get_node("ZonaMuerte")
	if not zona_muerte:
		print("ZonaMuerte no encontrada en la cámara")
	else:
		# Ajustar la posición inicial de la zona de muerte (por detrás de la cámara)
		# Usamos `local_transform.origin` para mover la zona con la cámara
		zona_muerte.transform.origin = Vector3(-distancia_area, 0, 0)

func _process(delta: float):
	# Incrementar la velocidad con aceleración
	velocidad_actual += aceleracion * delta
	velocidad_actual = min(velocidad_actual, limite_velocidad)

	# Mover la cámara hacia la derecha
	translate(direccion * velocidad_actual * delta)

	# Hacer que la zona de muerte se mueva junto con la cámara
	if zona_muerte:
		# Mover la zona de muerte en la misma dirección que la cámara, pero un poco detrás de ella
		zona_muerte.transform.origin = Vector3(-distancia_area, 0, 0)
