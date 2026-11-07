extends CharacterBody3D

@export var speed = 6.0
@export var jump_velocity = 4.5

var gravity = 9.8

func _physics_process(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta

    var input_dir = Vector2.ZERO

    if Input.is_key_pressed(KEY_W):
        input_dir.y -= 1
    if Input.is_key_pressed(KEY_S):
        input_dir.y += 1
    if Input.is_key_pressed(KEY_A):
        input_dir.x -= 1
    if Input.is_key_pressed(KEY_D):
        input_dir.x += 1

    var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()

    velocity.x = direction.x * speed
    velocity.z = direction.z * speed

    if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
        velocity.y = jump_velocity

    move_and_slide()
