class_name Coworker
extends Node2D

var _coworkerSpawner : CoworkerSpawner
var walkDir
var walkSpeed = 500

func setup(coworkerSpawner, xPos, player):
    _coworkerSpawner=coworkerSpawner
    position.x=xPos
    if xPos < coworkerSpawner.starePoint:
        walkDir=1
    else:
        walkDir=-1

func _physics_process(delta):
    position+=Vector2.RIGHT*delta*walkDir*walkSpeed
    if walkDir > 0 and position.x > _coworkerSpawner.despawnThreshold:
        despawn()
    elif walkDir < 0 and position.x < -_coworkerSpawner.despawnThreshold:
        despawn()


func despawn():
    queue_free()