/ai/boss/bubblegum/

	var/mob/living/simple/bubblegum/owner_as_bubblegum


/ai/boss/bubblegum/New(var/mob/living/desired_owner)
	owner_as_bubblegum = desired_owner
	return ..()

/ai/boss/bubblegum/Destroy()
	owner_as_bubblegum = null
	return ..()

/ai/boss/bubblegum/handle_movement()

	if(owner_as_bubblegum.charge_dir)
		owner_as_bubblegum.move_dir = owner_as_bubblegum.charge_dir
		owner_as_bubblegum.movement_flags = MOVEMENT_RUNNING
		return FALSE

	return ..()

/ai/boss/bubblegum/handle_attacking()

	if(owner_as_bubblegum.charge_steps)
		return FALSE

	if(objective_attack && owner_as_bubblegum.health)

		var/health_prob_mod = 3 - (owner_as_bubblegum.health.health_current / owner_as_bubblegum.health.health_max)*2

		if(!owner_as_bubblegum.charge_steps && prob(10*health_prob_mod))
			owner_as_bubblegum.start_charge()
			return TRUE

		if(prob(5*health_prob_mod))
			owner_as_bubblegum.blood_attack()
			return TRUE

		if(prob(5*health_prob_mod))
			owner_as_bubblegum.spray_blood()
			return TRUE

	return ..()