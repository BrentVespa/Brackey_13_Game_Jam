extends Sprite3D

@onready var Subviewport = get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await RenderingServer.frame_post_draw
	var img = get_viewport().get_texture()
	self.texture = Subviewport.get_viewport().get_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
