extends Node

var charOpcs = {}
var data_file_path = "res://data/personaje.json"

var cantJugadores = 4
var cantRondas= 2
var cantGanados = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	charOpcs = load_json_file(data_file_path)
		
	pass # Replace with function body.

func load_json_file (path :String):
	if FileAccess.file_exists(path):
		var dataFile = FileAccess.open(path, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
	pass
	
func minijuego_terminado(ganador: int):
	cantGanados[ganador] += 1
	print("victorias: " + str(cantGanados))
	siguiente_minijuego()

func siguiente_minijuego():
	#aca tendria que hacerse el chequeo de la queue de minijuegos y ver el siguiente pero por ahora se recarga la escena
	get_tree().change_scene_to_file("res://scenes/minijuegos/carrera.tscn")

	pass
	
func iniciar_minijuegos(cantJ, cantR):
	cantJugadores = cantJ
	cantRondas = cantR
	for i in range(cantJugadores):
		cantGanados.append(0)
	siguiente_minijuego()
# Called every frame. 'delta' is the elapsed time since the previous frame.
