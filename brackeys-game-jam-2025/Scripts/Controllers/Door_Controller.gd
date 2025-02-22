extends Node3D

@onready var Anim = $AnimationPlayer
var open = false

func Something():
	if !open:
		Anim.play("Open")
		open = true
	elif open:
		Anim.play_backwards("Open")
		open = false
