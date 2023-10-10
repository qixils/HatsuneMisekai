class_name Player
extends CharacterBody2D

signal update_jump_power(old_value: float, new_value: float)
signal update_position(old_value: Vector2, new_value: Vector2)

@export var speed = 300.0
@export var jump_velocity = -500.0
@export var max_jump_power = 2.0
@export var jump_power_factor = 1.5
@export var acceleration = speed * 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_power = 0.0

func _ready():
	for node in get_node("../Entities").get_children():
		if node.name.begins_with("Checkpoint"): # TODO: better method of this
			if PlayerVariables.checkpoint == node.index:
				position = node.position

func _physics_process(delta):
	if position.y > 1000:
		PlayerVariables.death.emit()
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if is_on_floor():
		var old_power = jump_power
		if Input.is_action_pressed("blast"):
			jump_power = min(max_jump_power, jump_power + (jump_power_factor * delta))
		elif jump_power > 0:
			var blastScene: PackedScene = preload("res://blast.tscn")
			var blast: Blast = blastScene.instantiate() as Blast
			blast.position = position
			var percent = jump_power / max_jump_power
			blast.init(percent)
			get_node("..").add_child(blast)
			
			velocity.y = jump_velocity * pow(2, log(jump_power))
			jump_power = 0
		if old_power != jump_power:
			update_jump_power.emit(old_power, jump_power)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	var target: float
	if direction:
		target = direction * speed
	else:
		target = 0
	velocity.x = move_toward(velocity.x, target, acceleration * delta)
	
	if not is_on_floor():
		$Sprite.play("jump")
	elif velocity.x != 0:
		$Sprite.play("walk")
	else:
		$Sprite.play("idle")
	
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true

	var old_position = position
	move_and_slide()
	if old_position != position:
		update_position.emit(old_position, position)	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is CharacterBody2D and ((collider as CharacterBody2D).collision_layer & 0b100) != 0:
			PlayerVariables.death.emit()
