extends Area2D

var UI_Amount

func _ready() -> void:
	pass

func _pay_out_plane_enter(body: Node2D) -> void:
	print("Payout Started")
	if body.has_method("Cow"):
		GlobalSignals.payout.emit(body)
