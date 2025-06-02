# res://scripts/drone_thrust.gd
extends RigidBody3D
# ─── exposed knobs ────────────────────────────────────────────
const MAX_THROTTLE  : float = 1.0

@export_range(-MAX_THROTTLE, MAX_THROTTLE) var throttle      : float = 0.0   # 1.0 ≈ hover
@export                  var gravity_force : float = 9.81
# arrow defaults (you can expose these too if you want)

const ARROW_PREFAB  : PackedScene = preload("res://scenes/arrow_visual.tscn")
# ─── internal ─────────────────────────────────────────────────
@onready var points : Array[Node3D] = [
	$FL_socket/FL_thrust,
	$FR_socket/FR_thrust,
	$RL_socket/RL_thrust,
	$RR_socket/RR_thrust,
]
var _hover_N : float          # Newtons per motor
var _arrows : Dictionary = {} # point → ArrowVisual

func _ready() -> void:
	_hover_N = (mass * gravity_force) / points.size()
	
	_spawn_arrows()

func _physics_process(_delta: float) -> void:
	for p in points:
		var up : Vector3  = -p.global_transform.basis.y
		var f  : float    = _hover_N * throttle      # ± N
		apply_force(up * f, p.global_transform.origin - global_transform.origin)
		_arrows[p].set_scale_signed(f / (_hover_N * MAX_THROTTLE))

# helpers
func _spawn_arrows() -> void:
	for p in points:
		var a : Node3D = ARROW_PREFAB.instantiate()
		p.add_child(a)
		_arrows[p] = a
