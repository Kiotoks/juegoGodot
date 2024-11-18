extends Node3D

@onready var escenaJugador = preload("res://assets/player.tscn")
@export var spawners : Array[Node3D]
var cantJugadores = StaticData.cantJugadores
var jugadores = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnearJugadores()
	pass # Replace with function body.

func spawnearJugadores():
	for i in range(cantJugadores):
		var jugador = escenaJugador.instantiate()
		jugador.set_numero_jugador(i)
		jugador.global_transform.origin.y = spawners[i].global_transform.origin.y
		jugador.set_coords(spawners[i].global_transform.origin.x, spawners[i].global_transform.origin.z)
		add_child(jugador)
		jugadores.append(jugador)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for jugador in jugadores:
		if not is_instance_valid(jugador):
			jugadores.erase(jugador)
	if len(jugadores) == 1:
		StaticData.minijuego_terminado(jugadores[0].numero_de_jugador )
	pass
