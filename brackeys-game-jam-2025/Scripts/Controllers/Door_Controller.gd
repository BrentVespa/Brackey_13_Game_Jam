extends Node3D

@export var Elevator = false
@onready var Anim = $AnimationPlayer
@export var open = false

func _ready() -> void:
	if open:
		Anim.play("Open")
	elif !open:
		Anim.play("Idle")

func Something():
	if !open:
		Anim.play("Open")
		open = true
		if Elevator:
			elevator()
	elif open:
		Anim.play_backwards("Open")
		open = false


func elevator():
	GlobalSignals.emit_signal("failState")
