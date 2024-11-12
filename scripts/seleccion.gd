extends Control

# Variables temporales para almacenar la selección del usuario
var temp_cant_jugadores = 2
var temp_cant_rondas = 2

func _ready():
	# Acceder a los nodos usando rutas relativas a partir de "Control"
	var cant_jugadores = get_node("CanvasLayer/VboxContainer/HBoxContainer/CantJugadores")
	if cant_jugadores:
		cant_jugadores.connect("item_selected", Callable(self, "_on_jugadores_option_selected"))
	else:
		print("Nodo CantJugadores no encontrado")
	
	var cant_rondas = get_node("CanvasLayer/VboxContainer/HBoxContainer2/CantRondas")
	if cant_rondas:
		cant_rondas.connect("item_selected", Callable(self, "_on_rondas_option_selected"))
	else:
		print("Nodo CantRondas no encontrado")
	
	var aceptar_button = get_node("CanvasLayer/VboxContainer/Button")
	if aceptar_button:
		aceptar_button.connect("pressed", Callable(self, "_on_aceptar_pressed"))
	else:
		print("Botón Aceptar no encontrado")

# Funciones de manejo de señales
func _on_jugadores_option_selected(index):
	temp_cant_jugadores = index + 2
	print("Cantidad de jugadores seleccionada temporalmente:", temp_cant_jugadores)

func _on_rondas_option_selected(index):
	print("Índice seleccionado para rondas:", index)  # Depuración: Imprime el índice de selección
	match index:
		0:
			temp_cant_rondas = 1
		1:
			temp_cant_rondas = 2
		2:
			temp_cant_rondas = 3
		3:
			temp_cant_rondas = 4
		4:
			temp_cant_rondas = 5
		_:
			print("Índice fuera de rango para rondas: ", index)
	print("Cantidad de rondas seleccionada temporalmente:", temp_cant_rondas)

func _on_aceptar_pressed():
	# Asignar los valores temporales a StaticData solo al presionar "Aceptar"
	StaticData.cantJugadores = temp_cant_jugadores
	StaticData.cantRondas = temp_cant_rondas
	print("Datos guardados: Jugadores =", StaticData.cantJugadores, ", Rondas =", StaticData.cantRondas)
	get_tree().change_scene_to_file("res://controlador_juego.tscn")
