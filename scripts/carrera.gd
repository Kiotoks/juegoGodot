extends Node

@export var spawners: Array[Node3D]
@export var y_min: float = -10.0  # Límite para detectar caída
var cantJugadores = StaticData.cantJugadores
var jugadores = []

func _ready() -> void:
	spawnear_jugadores()
	for i in range(cantJugadores):
		jugadores.append(i)

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


func _on_zona_muerte_body_entered(body: Node3D) -> void:
	print("afuera")
	if body is CharacterBody3D:
		eliminar_jugador(body)
