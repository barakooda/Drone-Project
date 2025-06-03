@tool
extends MultiMeshInstance3D
## Drop your orchard mesh and (optionally) a custom cylinder mesh in the inspector.
## When you press “Rebuild” in the inspector or run the scene,
## cylinders are (re)generated on every unique vertex.

@export var orchard_mesh    : Mesh     # the template that holds the points
@export var cylinder_mesh   : Mesh     = CylinderMesh.new()
@export var height          : float    = 2.0
@export var radius          : float    = 0.15
@export var remove_dupes_mm : float    = 0.001   # merge verts closer than this
@export var rebuild         : bool     = false:  set = _set_rebuild   # checkbox in inspector

func _ready() -> void:
	_build_multimesh()

func _set_rebuild(v: bool) -> void:
	if v:
		rebuild = false
		_build_multimesh()

func _build_multimesh() -> void:
	if orchard_mesh == null:
		push_warning("Assign an Orchard Mesh first.")
		return

	# ── 1. Collect vertex positions (all surfaces) ────────────────
	var verts := PackedVector3Array()
	for s in range(orchard_mesh.get_surface_count()):
		var a := orchard_mesh.surface_get_arrays(s)
		verts.append_array(a[Mesh.ARRAY_VERTEX])

	# ── 2. Remove duplicates (optional) ───────────────────────────
	if remove_dupes_mm > 0.0:
		var uniq := []
		for v in verts:
			var found := false
			for u in uniq:
				if v.distance_to(u) < remove_dupes_mm:
					found = true
					break
			if not found:
				uniq.append(v)
		verts = PackedVector3Array(uniq)

	# ── 3. Configure the MultiMesh ───────────────────────────────
	var mm := MultiMesh.new()
	mm.mesh            = cylinder_mesh
	mm.transform_format = MultiMesh.TRANSFORM_3D
	mm.instance_count   = verts.size()
	multimesh = mm      # assign to this node

	# Scale once so we don’t touch each instance’s basis twice
	var scale_basis := Basis().scaled(Vector3(radius, height * 0.5, radius)) # CylinderMesh is 1 m tall, centred at origin

	# ── 4. Write per-instance transforms ─────────────────────────
	for i in verts.size():
		var xform := Transform3D()
		xform.basis  = scale_basis
		xform.origin = verts[i]
		mm.set_instance_transform(i, xform)

	# optional: share a single material with all cylinders
	#mm.mesh.surface_set_material(0, preload("res://materials/tree_trunk.tres"))
