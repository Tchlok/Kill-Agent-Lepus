class_name Target
extends Area2D

enum TargetType{Civ,Hare,Bottle,Moon}
@export var targetType : TargetType

func hit(endings : Endings):
    match targetType:
        TargetType.Civ:
            endings.flagHitCiv=true
        TargetType.Hare:
            endings.flagHitHare=true
        TargetType.Bottle:
            endings.flagHitBottle=true
        TargetType.Moon:
            endings.flagHitMoon=true