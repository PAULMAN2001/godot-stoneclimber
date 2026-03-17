extends KinematicBody2D

class_name Enemy

var speed = 100
var health = 100
var alert_range = 200
var attack_range = 50
var damage = 20

# AI states
enum State { PATROL, ALERT, ATTACK, DEATH }
var state = State.PATROL

var target_player = null

# Patrol behavior
func _ready():
    set_process(true)

func _process(delta):
    match state:
        State.PATROL:
            patrol()
            detect_player()
        State.ALERT:
            alert_behavior()
        State.ATTACK:
            attack_player()
        State.DEATH:
            die()

func patrol():
    # Logic for patrolling between points.
    # Add patrol point logic here.
    # Move the enemy here based on patrol logic.

func detect_player():
    # Logic for detecting player within the alert range
    if position.distance_to(target_player.position) < alert_range:
        state = State.ALERT

func attack_player():
    if target_player:
        # Deal damage to player
        if position.distance_to(target_player.position) < attack_range:
            target_player.take_damage(damage)
            state = State.PATROL

func take_damage(amount):
    health -= amount
    if health <= 0:
        state = State.DEATH

func die():
    # Add death animation logic here.
    queue_free() # Removes the enemy from the scene when they die.

func _on_body_entered(body):
    if body.is_in_group("player"):
        target_player = body
        state = State.ATTACK
    

