extends Node3D

@export var velocidad = 10
@export var limite = 50
var colision
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	transform.origin.x += velocidad * delta;
	if transform.origin.x > limite:
		queue_free()
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		colision = body
		body.queue_free()
	pass # Replace with function body.
