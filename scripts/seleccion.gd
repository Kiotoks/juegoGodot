extends Control

# Variables temporales para almacenar la selección del usuario
var temp_cant_jugadores = 2
var temp_cant_rondas = 1
var temp_modo_juego = 0
var temp_minijuego = 0
@onready var selectorMinijuego: HBoxContainer = $CanvasLayer/VboxContainer/HBoxContainer4

func _ready():
	# Acceder a los nodos usando rutas relativas a partir de "Control"
	var cant_jugadores = get_node("CanvasLayer/VboxContainer/HBoxContainer/CantJugadores")
	if cant_jugadores:
		cant_jugadores.connect("item_selected", Callable(self, "_on_jugadores_option_selected"))
	else:
		print("Nodo CantJugadores no encontrado")
	
	
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
	temp_cant_rondas = index + 1
	print("Cantidad de rondas seleccionada temporalmente:", temp_cant_rondas)

func _on_aceptar_pressed():
	# Asignar los valores temporales a StaticData solo al presionar "Aceptar"
	print("Datos guardados: Jugadores =", StaticData.cantJugadores, ", Rondas =", StaticData.cantRondas)
	StaticData.iniciar_minijuegos(temp_cant_jugadores, temp_cant_rondas, temp_modo_juego, temp_minijuego)

func _on_modo_de_juego_item_selected(index: int) -> void:
	temp_modo_juego = index
	if temp_modo_juego == 2:
		selectorMinijuego.visible = true
	else:
		selectorMinijuego.visible = false
	pass # Replace with function body.

func _on_minijuego_item_selected(index: int) -> void:
	temp_minijuego = index
	pass # Replace with function body.


func _on_spin_box_value_changed(value: float) -> void:
	temp_cant_rondas = value
	pass # Replace with function body.
