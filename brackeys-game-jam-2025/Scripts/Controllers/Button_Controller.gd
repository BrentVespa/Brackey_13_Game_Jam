extends StaticBody3D

@export var Connector : Array[Node3D]
@export var UFood : int = 0
@export var UWater : int = 0
@export var UStress : int = 0
@onready var Layout = $"%SymbolLayout"

func Interact():
	if Connector != null:
		for c in Connector:
			if c.has_method("Something"):
				c.Something()
				GlobalSignals.updatePlayerStats.emit(UFood, UWater, UStress)
				GlobalSignals.updateUI3D.emit()
