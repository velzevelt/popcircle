tool
class_name FlatTexture
extends ImageTexture

export var modulate: Color = Color.white
export var size: Vector2 = Vector2(10, 10)
export var update_texture := true setget update_texture

func update_texture(_v):
	var image = Image.new()
	image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
	image.fill(modulate)
	
	create_from_image(image)
