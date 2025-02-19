extends StaticBody3D

@onready var child = $Tower

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func Interact():
	print("I HAVE THE POWER TO FIGHT")
	var mat : StandardMaterial3D = StandardMaterial3D.new()
	var rng1 = EventBus.rng.randf_range(0, 1)
	var rng2 = EventBus.rng.randf_range(0, 1)
	var rng3 = EventBus.rng.randf_range(0, 1)
	var rng4 = EventBus.rng.randf_range(0, 1)
	mat.albedo_color = Color(rng1, rng2, rng3, rng4)
	child.mesh.surface_set_material(0, mat)
	EventBus.Money -= 10
	EventBus._update_UI()
