# res://scripts/arrow_visual.gd
# Build & update a 3-D arrow that always grows/shrinks along its +Y axis.
extends Node3D

@export var max_length      : float = 0.40   # total length at scale = 1
@export var shaft_radius    : float = 0.015
@export var head_height     : float = 0.10
@export var head_radius     : float = 0.035
@export var color           : Color = Color("2ecc71")

var _shaft     : MeshInstance3D
var _head      : MeshInstance3D
var _max_shaft : float      # cached = max_length - head_height

func _ready() -> void:
	_max_shaft = max_length - head_height
	_build_meshes()

func set_scale_signed(signed_mag: float) -> void:
	# |signed_mag| ∈ [0,1]; sign flips direction
	var mag :float = clamp(abs(signed_mag), 0.0, 1.0)
	var shaft_len :float = max(0.001, _max_shaft * mag)

	_shaft.scale.y    = shaft_len / _max_shaft
	_shaft.position.y =  shaft_len * 0.5
	_head.position.y  =  shaft_len + head_height * 0.5
	scale.y           = 1.0 if signed_mag >= 0.0 else -1.0

# ─── internal ───────────────────────────────────────────────
func _build_meshes() -> void:
	var mat := StandardMaterial3D.new()
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.albedo_color = color

	var shaft_mesh := CylinderMesh.new()
	shaft_mesh.top_radius = shaft_radius
	shaft_mesh.bottom_radius = shaft_radius
	shaft_mesh.height = _max_shaft
	shaft_mesh.radial_segments = 20

	var head_mesh := CylinderMesh.new()
	head_mesh.top_radius = 0.0
	head_mesh.bottom_radius = head_radius
	head_mesh.height = head_height
	head_mesh.radial_segments = 20

	_shaft = MeshInstance3D.new()
	_shaft.mesh = shaft_mesh
	_shaft.material_override = mat
	add_child(_shaft)

	_head = MeshInstance3D.new()
	_head.mesh = head_mesh
	_head.material_override = mat
	add_child(_head)
