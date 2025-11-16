extends Node2D

@export var player : Player
@export var path : Path2D
@export var flameFollow : PathFollow2D
@export var flameSp : Sprite2D

@export var shakeDuration : float
@export var fuse : Line2D


func _process(delta: float):
	var fuseP : float = MathS.Clamp01(player.explodeT/(player.explodeThreshold-shakeDuration))
	flameFollow.progress_ratio=fuseP
	fuse.gradient.set_offset(1,fuseP)
	fuse.gradient.set_offset(2,fuseP+0.01)
