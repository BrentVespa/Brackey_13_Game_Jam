extends Node

##Examples of variables and singal syntax
##var power = 10
##signal take_damage(Damage, Target)
signal clone(caller : CharacterBody2D,  hit : CharacterBody2D, pos)
signal cloneFresh(caller : CharacterBody2D, PreFab : PackedScene, pos)
signal payout(caller)
signal updateUI()
signal closeTextBoxes(caller)
signal updateUI3D()
signal updatePlayerStats(UFood: int, UWater: int, UStress: int)
