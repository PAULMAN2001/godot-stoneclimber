extends Camera2D

# Variables
export (NodePath) var target_path: NodePath = null
export (float) var smooth_speed: float = 5.0
export (float) var shake_magnitude: float = 0.5
export (int) var shake_duration: int = 30

var target: Node = null
var is_shaking: bool = false
var shake_timer: int = 0
var original_position: Vector2

func _ready():
    if target_path:
        target = get_node(target_path)  
    original_position = position

func _process(delta):
    if target:
        # Smooth following
        var target_position = target.position
        position = position.linear_interpolate(target_position, smooth_speed * delta)

    # Camera shake effect
    if is_shaking:
        shake_timer -= 1
        if shake_timer > 0:
            position += Vector2(randf_range(-shake_magnitude, shake_magnitude), randf_range(-shake_magnitude, shake_magnitude))
        else:
            is_shaking = false
            position = original_position

func shake():
    is_shaking = true
    shake_timer = shake_duration
    original_position = position

# Parallax background support can be handled in the main scene via the background nodes
