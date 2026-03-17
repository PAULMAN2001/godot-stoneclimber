extends Node

# Global variables for game management
var lives: int = 3
var health: int = 100
var score: int = 0
var is_paused: bool = false

# Signal for health change
signal health_changed(new_health)
# Signal for score change
signal score_changed(new_score)

# Called when the node enters the scene tree for the first time.
func _ready():
    update_ui()

# Function to update UI elements
func update_ui():
    # Update UI logic here (to be implemented)
    pass

# Function to take damage
func take_damage(amount: int):
    health -= amount
    emit_signal("health_changed", health)
    check_game_over()

# Function to heal
func heal(amount: int):
    health += amount
    emit_signal("health_changed", health)

# Function to handle player lives
func lose_life():
    lives -= 1
    if lives <= 0:
        game_over()

# Function to add score
func add_score(points: int):
    score += points
    emit_signal("score_changed", score)

# Function to pause the game
func pause_game():
    is_paused = true
    get_tree().paused = true

# Function to resume the game
func resume_game():
    is_paused = false
    get_tree().paused = false

# Function to check for game over
func check_game_over():
    if health <= 0:
        game_over()

# Function to handle game over state
func game_over():
    # Handle game over logic here (to be implemented)
    pass