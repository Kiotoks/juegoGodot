extends Node3D
@onready var pantalla: MeshInstance3D = $pantalla
@export var numero_pantalla : int

var textura_anana = preload("res://materiales/texturas/anana.tres")
var textura_banana = preload("res://materiales/texturas/banana.tres")
var textura_ciruela = preload("res://materiales/texturas/ciruela.tres")
var textura_durazno = preload("res://materiales/texturas/durazno.tres")
var textura_limon = preload("res://materiales/texturas/limon.tres")
var textura_manzana = preload("res://materiales/texturas/manzana.tres")
var textura_naranja = preload("res://materiales/texturas/naranja.tres")
var textura_pera = preload("res://materiales/texturas/pera.tres")
var textura_sandia = preload("res://materiales/texturas/sandia.tres")
var textura_uva = preload("res://materiales/texturas/uva.tres")
var textura_apagado = preload("res://materiales/bombanegra.tres")

func cambiarEstadoPantalla(estado):
	print(estado)
	match estado:
		0:
			pantalla.set_surface_override_material(0, textura_anana)
		1:
			pantalla.set_surface_override_material(0, textura_banana)
		2:
			pantalla.set_surface_override_material(0, textura_ciruela)
		3:
			pantalla.set_surface_override_material(0, textura_durazno)
		4:
			pantalla.set_surface_override_material(0, textura_limon)
		5:
			pantalla.set_surface_override_material(0, textura_manzana)
		6:
			pantalla.set_surface_override_material(0, textura_naranja)
		7:
			pantalla.set_surface_override_material(0, textura_pera)
		8:
			pantalla.set_surface_override_material(0, textura_sandia)
		9:
			pantalla.set_surface_override_material(0, textura_uva)
		
		null:
			pantalla.set_surface_override_material(0, textura_apagado)
			
		
