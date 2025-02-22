class_name LifeSimActor extends Node2D

var health;
var maxHealth;

# Constructor
func _init(maxHealth):
	self.maxHealth = maxHealth
	self.health = maxHealth

# Take damage. If no value for damage is passed, 1 damage is applied.
func takeDamage(damage = 1):
	self.health -= damage
	if (health <= 0):
		self.die()

# Heal damage. If no value for heal is passed, 1 health is gained.
func heal(heal = 1):
	self.health += heal
	if (self.getCurrentHealth() > maxHealth):
		self.health = maxHealth

# Get health
func getCurrentHealth():
	return self.health

# Kill this actor
func die():
	self.queue_free()
