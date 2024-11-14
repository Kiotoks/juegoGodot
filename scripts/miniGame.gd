extends Node

@export var spawners: Array[Node3D]

var cantJugadores = StaticData.cantJugadores
var jugadores = []
func _ready() -> void:
	spawnear_jugadores()
	for i in range(cantJugadores):
		jugadores.append(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_3d_body_entered(body) -> void:
	if body is CharacterBody3D:
		var numeroJugador = body.numero_de_jugador
		for j in jugadores:
			if numeroJugador == j:
				jugadores.erase(numeroJugador)
				if len(jugadores) == 1:
					terminar_minijuego()
				return
		body.queue_free()
		
	pass # Replace with function body.

func spawnear_jugadores():
	var escenaJugador = preload("res://player.tscn")
	for i in range(cantJugadores):
		var jugador = escenaJugador.instantiate()
		jugador.set_numero_jugador(i)
		jugador.set_coords(spawners[i].global_transform.origin.x, spawners[i].global_transform.origin.z,)
		add_child(jugador)

func terminar_minijuego():
	
	print("gano"+ str(jugadores[0]))
	StaticData.minijuego_terminado(jugadores[0])
