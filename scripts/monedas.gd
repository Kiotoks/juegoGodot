extends Node3D
@onready var confeti: Node3D = $confeti
@onready var timer: Timer = $Timer
@onready var bomba: RigidBody3D = $bomba
@export var spawners: Array[Node3D]
@onready var label: Label = $CanvasLayer/Label

var escenaJugador = preload("res://assets/player.tscn")
var cantJugadores = StaticData.cantJugadores
var jugadores = []
var jugadores_en_pie = []

func _ready() -> void:
	for i in range(cantJugadores):
		jugadores_en_pie.append(i)
	spawnear_jugadores()
	elegirOwner()
	timer.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(round(timer.time_left))
	pass

func spawnear_jugadores():
	for i in jugadores_en_pie:
		var jugador = escenaJugador.instantiate()
		jugador.set_numero_jugador(i)
		jugador.set_coords(spawners[i].global_transform.origin.x, spawners[i].global_transform.origin.z)
		jugadores.append(jugador)
		add_child(jugador)
		
func eliminar_jugadores():
	for j in jugadores:
		if is_instance_valid(j):
			j.queue_free()
	jugadores = []

func jugadorPierde(jugador):
	bomba.visible = false
	for j in jugadores:
		if jugador == j:
			confeti.transform.origin.x = jugador.transform.origin.x
			confeti.transform.origin.z = jugador.transform.origin.z
			confeti.activar()
			jugador.queue_free()
			jugadores_en_pie.erase(jugador.numero_de_jugador)

func elegirOwner():
	var numero_elegido = RandomNumberGenerator.new().randi_range(0, len(jugadores)-1)
	var jugador_elegido = jugadores[numero_elegido]
	bomba.setOwner(jugador_elegido)

func resetear_bomba():
	bomba.transform = Transform3D()
	bomba.linear_velocity = Vector3(0,0,0)
	bomba.transform.origin.x = 2
	bomba.transform.origin.z = 2
	bomba.transform.origin.y = 1.7
	bomba.collision_mask = 1
	bomba.collision_layer = 1
	bomba.isOnHand = false
	bomba.visible = true

func _on_timer_timeout() -> void:
	jugadorPierde(bomba.playerOwner)
	await get_tree().create_timer(3).timeout
	eliminar_jugadores()
	cantJugadores -= 1
	if cantJugadores > 1:
		await get_tree().create_timer(0.5).timeout
		resetear_bomba()
		spawnear_jugadores()
		elegirOwner()
		timer.start()
	else:
		StaticData.minijuego_terminado(jugadores_en_pie[0])
