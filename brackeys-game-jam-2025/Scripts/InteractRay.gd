extends RayCast3D

@onready var onSprite = $Control/ON
@onready var offSprite = $Control/OFF

func _ready() -> void:
	onSprite.hide()
	offSprite.show()

func _physics_process(delta: float) -> void:
	#if get_collider():
		#print(get_collider())
	
	if get_collider():
		if get_collider().has_method("Interact"):
			if Input.is_action_just_pressed("Mouse 1"):
				get_collider().Interact()
			onSprite.show()
			offSprite.hide()
		else:
			if Input.is_action_just_pressed("Mouse 1"):
				#print("No interact, but mouse 1")
				GlobalSignals.emit_signal("closeTextBoxes", self)
	else:
		onSprite.hide()
		offSprite.show()
		if Input.is_action_just_pressed("Mouse 1"):
			#print("No hit, but mouse 1")
			GlobalSignals.emit_signal("closeTextBoxes", self)
