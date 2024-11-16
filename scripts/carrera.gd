extends Node

@export var spawners: Array[Node3D]
@export var y_min: float = -10.0  # Límite para detectar caída
var cantJugadores = StaticData.cantJugadores
var jugadores = []

func _ready() -> void:
	spawnear_jugadores()
	for i in range(cantJugadores):
		jugadores.append(i)
	# Conectar la señal del Area3D
	var zona_muerte = get_node("Pivot/Camera3D/ZonaMuerte")
	if zona_muerte:
		zona_muerte.connect("body_entered", Callable(self, "_on_area_3d_body_entered"))

func spawnear_jugadores():
	var escenaJugador = preload("res://player.tscn")
	for i in range(cantJugadores):
		var jugador = escenaJugador.instantiate()
		jugador.set_numero_jugador(i)
		jugador.set_coords(spawners[i].global_transform.origin.x, spawners[i].global_transform.origin.z)
		add_child(jugador)

func _process(delta: float) -> void:
	# Verificar si algún jugador ha caído
	for jugador in get_children():
		if jugador is CharacterBody3D and jugador.transform.origin.y < y_min:
			eliminar_jugador(jugador)

# Manejar cuando un jugador entra en el Area3D (zona de muerte)
func _on_area_3d_body_entered(body) -> void:
	if body is CharacterBody3D:
		eliminar_jugador(body)

# Función para eliminar a un jugador
func eliminar_jugador(jugador):
	var numeroJugador = jugador.numero_de_jugador
	if numeroJugador in jugadores:
		jugadores.erase(numeroJugador)
		jugador.queue_free()
		print("Jugador", numeroJugador, "ha sido eliminado.")
		if len(jugadores) == 1:
			terminar_minijuego()

func terminar_minijuego():
	print("Gano el jugador", jugadores[0])
	StaticData.minijuego_terminado(jugadores[0])
