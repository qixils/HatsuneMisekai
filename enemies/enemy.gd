class_name Enemy
extends CharacterBody2D

@export var speed = 100
@export var activation_radius = 1280
@export var gravity: int = 0

enum Facing {
	LEFT,
	RIGHT
}

enum State {
	ALIVE,
	DEAD
}

@export var facing = Facing.LEFT
var state = State.ALIVE
var direction = -1 if facing == Facing.LEFT else 1

func _ready():
	if gravity == 0:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if state == State.DEAD:
		return
	if position.y > 1000:
		# TODO: delete self ???
		return
	var player = get_node("../../Player") as Player
	if abs(position.x - player.position.x) > activation_radius:
		return
		
	if is_on_wall():
		direction *= -1
		$Sprite.flip_h = not $Sprite.flip_h
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = direction * speed
	
	move_and_slide()

func die():
	if state == State.DEAD:
		return
	state = State.DEAD
	collision_layer = 0b0
	collision_mask = 0b0
	modulate.a = 0
	queue_free()
