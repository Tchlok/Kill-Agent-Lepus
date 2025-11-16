class_name Player
extends Node2D

var timeRemaining : float
@export var suffocationThreshold : float
@export var lungCapacity : float
var storedBreath : float
var explodeT : float
@export var explodeThreshold : float


var inhaling : bool
var inhaleT : float
signal EV_inhaleStart
signal EV_inhaleEnd

@export var exhaleSpeed : float
@export var exhaleGain : float


var ended : bool

func _enter_tree():
    ended=false
    timeRemaining=20

func caughtCheck():
    if ended:
        return
    if not isExhaling():
        return
    #caught ending
    print("caught ending")
    end()

func isExhaling():
    return not inhaling and storedBreath > 0

func _physics_process(delta: float):
    if ended:
        return
    
    timeRemaining-=delta
    explodeT+=delta
    if inhaling:
        inhaleT+=delta
        storedBreath=min(inhaleT,lungCapacity)
        if inhaleT >= suffocationThreshold:
            # suffocation ending
            print("suffocation ending")
            end()
    else:
        if storedBreath > 0:
            storedBreath-=delta*exhaleSpeed
            explodeT=max(0,explodeT-delta*exhaleGain)
            
    if explodeT >= explodeThreshold:
        # explode ending
        print("explode ending")
        end()
    if timeRemaining<=0:
        # good ending
        print("good ending")
        end()

func _process(delta: float):
    if ended:
        return
    if Input.is_action_just_pressed("Inhale"):
        inhaleT=0
        inhaling=true
    if Input.is_action_just_released("Inhale"):
        inhaling=false

func end():
    ended=true