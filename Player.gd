extends CharacterBody2D

# Player attributes
var speed: float = 200.0
var jump_force: float = 400.0
var health: int = 100

# Animation player node
onready var animation_player = $AnimationPlayer

# Handling input
func _process(delta: float) -> void:
    var input_vector = Vector2.ZERO

    if Input.is_action_pressed("ui_right"):
        input_vector.x += 1
    if Input.is_action_pressed("ui_left"):
        input_vector.x -= 1

    # Normalize to prevent faster diagonal movement
    input_vector = input_vector.normalized()
    move_and_slide(input_vector * speed)

    # Jumping logic
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        jump()

    # Animation handling
    if is_on_floor():
        if input_vector.x != 0:
            animation_player.play("Run")
        else:
            animation_player.play("Idle")
    else:
        animation_player.play("Jump")

# Physics integration and jumping mechanic
func jump() -> void:
    velocity.y = -jump_force

# Health system
func take_damage(amount: int) -> void:
    health -= amount
    if health <= 0:
        die()

func die() -> void:
    queue_free() # Remove the player from the scene and handle game over logic.
