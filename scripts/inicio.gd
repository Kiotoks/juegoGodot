extends Control

func _ready():
	$"VBoxContainer/BotonJugar".connect("pressed", Callable(self, "_on_boton_jugar_pressed"))
	$"VBoxContainer/BotonOpciones".connect("pressed", Callable(self, "_on_boton_opciones_pressed"))
	$"VBoxContainer/BotonSalir".connect("pressed", Callable(self, "_on_boton_salir_pressed"))

func _on_boton_jugar_pressed():
	print("Iniciar juego")
	get_tree().change_scene_to_file("res://seleccion.tscn")

func _on_boton_opciones_pressed():
	print("Abrir opciones")

func _on_boton_salir_pressed():
	get_tree().quit()
