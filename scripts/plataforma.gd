extends Node3D
@onready var colision: StaticBody3D = $modeloPlataforma/StaticBody3D
@onready var pantalla: Node3D = $pantalla
@export var numero_plataforma : int
var fruta
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setFruta(f):
	fruta = f

func disableColision():
	colision.collision_layer = 0
	colision.collision_mask = 0
func enableColision():
	colision.collision_layer = 1
	colision.collision_mask = 1

func setActive(isActive):
	if isActive:
		visible = true
		enableColision()
	else:
		visible = false
		disableColision()
		
func encenderPantalla():
	self.pantalla.cambiarEstadoPantalla(self.fruta)

func apagarPantalla():
	self.pantalla.cambiarEstadoPantalla(null)
