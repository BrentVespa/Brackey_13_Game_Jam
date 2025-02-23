extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("I've been created")

func _physics_process(delta: float) -> void:
	print(self, " : ", global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func Interact():
	GlobalSignals.emit_signal("updatePlayerStats", +30, -3, +10)
	EventBus._update_UI_3D()
	self.queue_free()
