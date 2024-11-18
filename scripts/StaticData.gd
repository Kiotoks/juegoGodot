extends Node

var charOpcs = {}
var data_file_path = "res://data/personaje.json"
var carpetaMinijuegos = "res://scenes/minijuegos/"
var minijuegos = DirAccess.get_files_at(carpetaMinijuegos)
var cantJugadores = 4
var listaMinijuegos = []
var cantRondas= 2
var cantGanados = []
var ronda = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	charOpcs = load_json_file(data_file_path)
	for i in range(len(minijuegos)):
		minijuegos[i] = carpetaMinijuegos + minijuegos[i]
	print(minijuegos)

func load_json_file (path :String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
	pass

func crearListaMinijuego():
	var indices = []
	listaMinijuegos = []
	for a in range(len(minijuegos)):
		indices.append(a)
	for i in range(len(minijuegos)):
		var m = indices[RandomNumberGenerator.new().randi_range(0, len(indices)-1)]
		listaMinijuegos.append(m)
		indices.erase(m)
	print(listaMinijuegos)

	
func minijuego_terminado(ganador: int):
	cantGanados[ganador] += 1
	print("victorias: " + str(cantGanados))
	siguiente_minijuego()

func siguiente_minijuego():
	if ronda < cantRondas:
		get_tree().change_scene_to_file(minijuegos[listaMinijuegos[ronda]])
		ronda += 1
	else:
		#tiene que ir al final
		get_tree().change_scene_to_file("res://scenes/inicio.tscn")
		
func iniciar_minijuegos(cantJ, cantR):
	crearListaMinijuego()
	cantGanados = []
	ronda = 0
	cantJugadores = cantJ
	cantRondas = cantR
	for i in range(cantJugadores):
		cantGanados.append(0)
	siguiente_minijuego()
# Called every frame. 'delta' is the elapsed time since the previous frame.
