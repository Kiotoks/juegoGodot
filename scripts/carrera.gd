extends Node3D

@onready var confeti: Node3D = $confeti

@export var spawners: Array[Node3D]
var cantJugadores = StaticData.cantJugadores
var jugadores = []

# Referencias a las áreas
var zona_vacio: Area3D
var zona_muerte: Area3D
var zona_meta: Area3D  # Nueva zona de meta

# Distancia detrás de la cámara para la zona de muerte
@export var distancia_detras_camara: float = 5.0

func _ready() -> void:
	# Inicializar jugadores
	spawnear_jugadores()
	for i in range(cantJugadores):
		jugadores.append(i)

	# Obtener referencias a las áreas
	zona_vacio = $zona_vacio
	zona_muerte = $Pivot/Camera3D/zona_muerte  # Zona de muerte está dentro de Camera3D
	zona_meta = $zona_meta  # Nueva zona de meta

	# Conectar las señales automáticamente
	zona_vacio.connect("body_entered", Callable(self, "_on_zona_vacio_body_entered"))
	zona_muerte.connect("body_entered", Callable(self, "_on_zona_muerte_body_entered"))
	zona_meta.connect("body_entered", Callable(self, "_on_zona_meta_body_entered"))  # Conectar la señal de la meta

func _process(delta: float) -> void:
	# Mover la zona de muerte detrás de la cámara
	mover_zona_muerte()

func spawnear_jugadores():
	var escenaJugador = preload("res://assets/player.tscn")
	for i in range(cantJugadores):
		var jugador = escenaJugador.instantiate()
		jugador.set_numero_jugador(i)
		jugador.global_transform.origin.y = spawners[i].global_transform.origin.y
		jugador.set_coords(spawners[i].global_transform.origin.x, spawners[i].global_transform.origin.z)
		add_child(jugador)

func mover_zona_muerte() -> void:
	# Actualizar la posición de la zona de muerte para que esté detrás de la cámara
	var camara_pos = $Pivot/Camera3D.global_transform.origin
	zona_muerte.global_transform.origin = camara_pos - Vector3(distancia_detras_camara, 0, 0)

func _on_zona_vacio_body_entered(body: Node3D):
	if body is CharacterBody3D:
		print("Jugador ha caído al vacío.")
		eliminar_jugador(body)

func _on_zona_muerte_body_entered(body: Node3D):
	if body is CharacterBody3D:
		print("Jugador se quedó atrás y ha sido eliminado.")
		eliminar_jugador(body)

func _on_zona_meta_body_entered(body: Node3D):
	if body is CharacterBody3D:
		confeti.activar()
		print("¡Jugador", body.numero_de_jugador, "ha llegado a la meta!")
		# El primer jugador que llegue a la meta gana
		await get_tree().create_timer(3).timeout
		terminar_minijuego_con_ganador(body)

func eliminar_jugador(jugador: CharacterBody3D):
	var numeroJugador = jugador.numero_de_jugador
	if numeroJugador in jugadores:
		jugadores.erase(numeroJugador)
		jugador.queue_free()
		print("Jugador", numeroJugador, "ha sido eliminado.")
		if len(jugadores) == 1:
			terminar_minijuego()

func terminar_minijuego():
	print("Ganó el jugador", jugadores[0])
	StaticData.minijuego_terminado(jugadores[0])

# Nueva función para terminar el minijuego cuando alguien llega a la meta
func terminar_minijuego_con_ganador(jugador: CharacterBody3D):
	print("El jugador", jugador.numero_de_jugador, "ha ganado al llegar a la meta!")
	StaticData.minijuego_terminado(jugador.numero_de_jugador)
