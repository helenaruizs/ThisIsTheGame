@tool
extends Sprite3D
class_name ShaderSprite3D

func _ready() -> void:
	if not material_override:
		_apply_material_override()
	
	_apply_texture()
	# For Godot 4: connect texture_changed so that updates happen automatically.
	texture_changed.connect(_apply_texture)

func _apply_material_override():
	var shader_material = ShaderMaterial.new()
	# Make sure this path points to your shader resource file.
	shader_material.shader = load("res://my_sprite_shader.gdshader")
	material_override = shader_material

func _apply_texture():
	var shader_material: ShaderMaterial = material_override
	shader_material.set_shader_parameter("sprite_texture", texture)
