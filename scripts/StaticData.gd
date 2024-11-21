extends Node

var charOpcs = {}
var data_file_path = "res://data/personaje.json"
var carpetaMinijuegos = "res://scenes/minijuegos/"
var controllers = [2,3,0,1]

var minijuegos = ["res://scenes/minijuegos/carrera.tscn", "res://scenes/minijuegos/dinosaurio.tscn", "res://scenes/minijuegos/main.tscn", "res://scenes/minijuegos/memotest.tscn", "res://scenes/minijuegos/monedas.tscn", "res://scenes/minijuegos/clicker.tscn"]
var cantJugadores = 4
var listaMinijuegos = []
var cantRondas= 2
var cantGanados = []
var ronda = 0
var minijuego = 0
var modo = 0
var minijuegoAnt
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	charOpcs = load_json_file(data_file_path)
	print(minijuegos)

func load_json_file (path :String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
	pass

func crearListaMinijuego(modo, mini):
	var indices = []
	listaMinijuegos = []
	if modo == 0:
		for a in range(len(minijuegos)):
			indices.append(a)
		for i in range(len(minijuegos)):
			var m = indices[RandomNumberGenerator.new().randi_range(0, len(indices)-1)]
			listaMinijuegos.append(m)
			indices.erase(m)
		if cantRondas > len(minijuegos):
			for i in range(cantRondas - len(minijuegos)):
				listaMinijuegos.append(minijuego_aleatorio())
	if modo == 2:
		for i in range(cantRondas):
			listaMinijuegos.append(mini)
	print(listaMinijuegos)

	
func minijuego_terminado(ganador: int):
	cantGanados[ganador] += 1
	print("victorias: " + str(cantGanados))
	siguiente_minijuego()

func minijuego_aleatorio():
	var m = minijuegos[RandomNumberGenerator.new().randi_range(0, len(minijuegos)-1)]
	while m == minijuegoAnt:
		m = minijuegos[RandomNumberGenerator.new().randi_range(0, len(minijuegos)-1)]
	minijuegoAnt = m
	return m

func siguiente_minijuego():
	if modo != 1:
		if ronda < cantRondas:
			Transicion.mostrarScores(cantGanados, minijuegos[listaMinijuegos[ronda]])
			ronda += 1
		else:
			#tiene que ir al final
			get_tree().change_scene_to_file("res://scenes/final.tscn")
	else:
		var ganador
		for g in len(cantGanados):
			if cantGanados[g] == cantRondas:
				ganador = g
		if ganador == null:
			Transicion.mostrarScores(cantGanados,minijuego_aleatorio())
		else:
			#tiene que ir al final
			get_tree().change_scene_to_file("res://scenes/final.tscn")
			
func iniciar_minijuegos(cantJ, cantR, m, mini):
	cantJugadores = cantJ
	cantRondas = cantR
	minijuego = mini
	modo = m
	cantGanados = []
	ronda = 0
	crearListaMinijuego(modo, mini)
	
	for i in range(cantJugadores):
		cantGanados.append(0)
	siguiente_minijuego()
# Called every frame. 'delta' is the elapsed time since the previous frame.
