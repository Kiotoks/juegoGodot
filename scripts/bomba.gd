extends RigidBody3D

var playerOwner
var isOnHand = false
@onready var modeloBomba: MeshInstance3D = $powerupBomb2
var materialPj1 = preload("res://materiales/bombaazul.tres")
var materialPj2 = preload("res://materiales/bombaroja.tres")
var materialPj3 = preload("res://materiales/bombaama.tres")
var materialPj4 = preload("res://materiales/bombaverde.tres")

var fuerza = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if  is_instance_valid(playerOwner) :
		if isOnHand:
			self.transform = playerOwner.transform
			transform.origin.y = playerOwner.transform.origin.y + 2
			if playerOwner.en_ataque:
				isOnHand = false
				linear_velocity = -playerOwner.transform.basis.z.normalized() * Vector3(fuerza, 0, fuerza)
				transform.origin.y = playerOwner.transform.origin.y + 1
				collision_mask = 1
				collision_layer = 1
				print("se tiro la bomba")
				await get_tree().create_timer(3).timeout
				isOnHand = true
		else:
			pass
			
	pass
	


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D and not isOnHand:
		if body != playerOwner:
			body.add_child(self)
			print("la bomba es de" + body.name)
			setOwner(body)
		isOnHand = true
		collision_mask = 0
		collision_layer = 0
	pass # Replace with function body.

func setOwner(body : CharacterBody3D):
	playerOwner = body
	setColor(body.numero_de_jugador)
	

func setColor(numeroJugador):
	print(numeroJugador)
	match numeroJugador:
		0:
			modeloBomba.mesh.surface_set_material(0, materialPj1)
		1:
			modeloBomba.mesh.surface_set_material(0, materialPj2)
		2:
			modeloBomba.mesh.surface_set_material(0, materialPj3)
		3:
			modeloBomba.mesh.surface_set_material(0, materialPj4)
			
