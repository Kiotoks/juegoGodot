extends Node3D
var cantJugadores = StaticData.cantJugadores
var escenaJugador = preload("res://assets/pj_clicker.tscn")
@onready var nodoSpawners: Node3D = $spawners
@onready var spawners = nodoSpawners.get_children()
@onready var timer: Timer = $Timer
@onready var label: Label = $CanvasLayer/Label
var termino = false
var jugadores = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnearJugadores()
	pass # Replace with function body.

func spawnearJugadores():
	for i in range(cantJugadores):
		var jugador = escenaJugador.instantiate()
		jugador.numero_de_jugador = i
		jugador.global_transform.origin = spawners[i].global_transform.origin
		add_child(jugador)
		jugadores.append(jugador)

func setTerminado():
	for j in jugadores:
		j.terminado = true

func _process(delta: float) -> void:
	label.text = str(round(timer.time_left))
	if not termino:
		for j in jugadores:
			if j.terminado:
				j.festejar()
				setTerminado()
				termino = true
				await get_tree().create_timer(3).timeout
				StaticData.minijuego_terminado(j.numero_de_jugador)
				break
				

func _on_timer_timeout() -> void:
	var masBajo = 100
	var ganador
	for j in jugadores:
		if j.height < masBajo:
			masBajo = j.height
			ganador = j
	ganador.festejar()
	setTerminado()
	await get_tree().create_timer(3).timeout
	StaticData.minijuego_terminado(ganador.numero_de_jugador)
