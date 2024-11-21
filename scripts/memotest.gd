extends Node3D
@onready var nodoPlataformas: Node3D = $plataformas
@onready var plataformas = nodoPlataformas.get_children()
@onready var pantalla_principal: MeshInstance3D = $pantalla/pantallaPrincipal

var escenaJugador = preload("res://assets/player.tscn")
var cantJugadores = StaticData.cantJugadores

@onready var nodoSpawners: Node3D = $spawners
@onready var spawners = nodoSpawners.get_children()
var jugadores = []

var cantCorrectas = 1
var velocidad = 1
var cantFrutas = 9
var frutaElegida
var rondas = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(cantJugadores):
		jugadores.append(i)
	spawnearJugadores()
	await get_tree().create_timer(5).timeout
	while len(jugadores) > 1:
		if rondas == 3:
			velocidad = 0.7
		if rondas == 6:
			velocidad = 0.5
		if rondas == 10:
			velocidad = 0.2
		resetearPlataformas()
		apagarPantallas()
		apagarPantallaPrincipal()
		
		frutaElegida = elegirFruta()
		
		elegirFrutasPantallas()
		encenderPantallas()
		
		await get_tree().create_timer(5 * velocidad).timeout
		
		apagarPantallas()
		
		await get_tree().create_timer(1).timeout
		
		mostrarFrutaCorrecta()
		
		await get_tree().create_timer(5 * velocidad).timeout
		
		eliminarPlataformasErroneas()
		encenderPantallas()
		
		await get_tree().create_timer(3).timeout
		rondas += 1

func spawnearJugadores():
	for i in range(cantJugadores):
		var jugador = escenaJugador.instantiate()
		jugador.set_numero_jugador(i)
		jugador.global_transform.origin.y = spawners[i].global_transform.origin.y
		jugador.set_coords(spawners[i].global_transform.origin.x, spawners[i].global_transform.origin.z)
		add_child(jugador)

func elegirFruta():
	return RandomNumberGenerator.new().randi_range(0, cantFrutas)

func elegirFrutasPantallas():
	var frutas = []
	for i in range(cantCorrectas):
		frutas.append(frutaElegida)
	for i in range(len(plataformas)- cantCorrectas):
		frutas.append(elegirFruta())
	
	for plataforma in plataformas:
		var frutaPlataforma = frutas[RandomNumberGenerator.new().randi_range(0, len(frutas)-1)]
		frutas.erase(frutaPlataforma)
		plataforma.setFruta(frutaPlataforma)
	pass

func encenderPantallas():
	for plataforma in plataformas:
		plataforma.encenderPantalla()

func apagarPantallas():
	for plataforma in plataformas:
		plataforma.apagarPantalla()

func mostrarFrutaCorrecta():
	print(frutaElegida)
	pantalla_principal.cambiarEstadoPantalla(frutaElegida)

func eliminarPlataformasErroneas():
	for plataforma in plataformas:
		if plataforma.fruta != frutaElegida:
			plataforma.setActive(false)

func resetearPlataformas():
	for plataforma in plataformas:
		plataforma.setActive(true)

func apagarPantallaPrincipal():
	pantalla_principal.cambiarEstadoPantalla(null)


func _on_death_zone_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		var numeroJugador = body.numero_de_jugador
		for j in jugadores:
			if numeroJugador == j:
				print("perdio "+ str(numeroJugador))
				jugadores.erase(numeroJugador)
				print(len(jugadores))
				if len(jugadores) == 1:
					terminar_minijuego()
				return
		body.queue_free()
		
	pass # Replace with function body.

func terminar_minijuego():
	print("gano"+ str(jugadores[0]))
	StaticData.minijuego_terminado(jugadores[0])
