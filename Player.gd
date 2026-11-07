extends CharacterBody3D

@export var speed = 6.0
@export var jump_velocity = 4.5

var gravity = 9.8
var move_input = Vector2.ZERO

func _ready():
    create_controls()

func _physics_process(delta):
    if not is_on_floor():
        velocity.y -= gravity * delta

    var direction = Vector3(move_input.x, 0, move_input.y)

    if Input.is_key_pressed(KEY_W):
        direction.z = -1
    if Input.is_key_pressed(KEY_S):
        direction.z = 1
    if Input.is_key_pressed(KEY_A):
        direction.x = -1
    if Input.is_key_pressed(KEY_D):
        direction.x = 1

    direction = direction.normalized()

    velocity.x = direction.x * speed
    velocity.z = direction.z * speed

    move_and_slide()

func create_controls():
    var layer = CanvasLayer.new()
    add_child(layer)

    var ui = Control.new()
    ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    layer.add_child(ui)

    add_button(ui, "↑", Vector2(90, -190), false, Vector2(0, -1))
    add_button(ui, "↓", Vector2(90, -90), false, Vector2(0, 1))
    add_button(ui, "←", Vector2(30, -140), false, Vector2(-1, 0))
    add_button(ui, "→", Vector2(150, -140), false, Vector2(1, 0))
    add_button(ui, "SALTAR", Vector2(-160, -130), true)

func add_button(ui, label, pos, jump, dir = Vector2.ZERO):
    var button = Button.new()
    button.text = label
    button.custom_minimum_size = Vector2(90, 65)
    button.position = pos
    button.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)

    if jump:
        button.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
        button.position = pos

    ui.add_child(button)

    if jump:
        button.button_down.connect(func():
            if is_on_floor():
                velocity.y = jump_velocity
        )
    else:
        button.button_down.connect(func():
            move_input = dir
        )
        button.button_up.connect(func():
            move_input = Vector2.ZERO
        )
