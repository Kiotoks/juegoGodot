extends Node3D
@onready var bottom: MeshInstance3D = $RobotArmature/Skeleton3D/Bottom
@onready var chest: MeshInstance3D = $RobotArmature/Skeleton3D/Chest
@onready var face: MeshInstance3D = $RobotArmature/Skeleton3D/Face
@onready var limb: MeshInstance3D = $"RobotArmature/Skeleton3D/Llimbs and head"

var mat1 = preload("res://materiales/azul.tres")
var mat2 = preload("res://materiales/rojo.tres")
var mat3 = preload("res://materiales/amarillo.tres")
var mat4 = preload("res://materiales/verde.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func cambiarColor(color : int):
	if color == 0:
		bottom.set_surface_override_material(0, mat1)
		chest.set_surface_override_material(0, mat1)
		face.set_surface_override_material(0, mat1)
		limb.set_surface_override_material(0, mat1)
	if color == 1:
		bottom.set_surface_override_material(0, mat2)
		chest.set_surface_override_material(0, mat2)
		face.set_surface_override_material(0, mat2)
		limb.set_surface_override_material(0, mat2)
	if color == 2:
		bottom.set_surface_override_material(0, mat3)
		chest.set_surface_override_material(0, mat3)
		face.set_surface_override_material(0, mat3)
		limb.set_surface_override_material(0, mat3)
	if color == 3:
		bottom.set_surface_override_material(0, mat4)
		chest.set_surface_override_material(0, mat4)
		face.set_surface_override_material(0, mat4)
		limb.set_surface_override_material(0, mat4)
		
		pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
