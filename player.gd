extends CharacterBody3D

const SPEED = 5.0
const MOUSE_SENSITIVITY = 0.003
const INTERACT_DISTANCE = 6.0

@onready var head = $Head
@onready var camera = $Head/Camera3D

var current_target = null


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	
	# Mouse look
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)

		head.rotation.x = clamp(
			head.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)

	# Mouse click interaction
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if current_target and current_target.has_method("interact"):
				current_target.interact()

	# ✅ ADD THIS RIGHT HERE (NEW)
	if event.is_action_pressed("interact"):
		if current_target and current_target.has_method("interact"):
			current_target.interact()

	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _physics_process(delta):

	# Movement
	var input_dir = Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_back"
	)

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()

	# 🔦 Raycast interaction check
	check_look_target()


# =========================
# 🔦 RAYCAST SYSTEM
# =========================

func check_look_target():
	var space_state = get_world_3d().direct_space_state

	var from = camera.global_position
	var to = from + camera.global_transform.basis.z * -INTERACT_DISTANCE

	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_bodies = true
	query.exclude = [self]

	var result = space_state.intersect_ray(query)

	if result:
		var obj = result.collider

		if obj != current_target:
			clear_highlight()

			if obj.has_method("highlight"):
				obj.highlight(true)
				current_target = obj
	else:
		clear_highlight()


func clear_highlight():
	if current_target and current_target.has_method("highlight"):
		current_target.highlight(false)

	current_target = null


func _on_00_pressed() -> void:
	pass # Replace with function body.
