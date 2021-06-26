/mob/living/carbon/superior_animal/handmade/findTarget()
	. = ..()
	if(.)
		visible_emote("lets out a buzz as it detects a target!")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, 1, -3)

/mob/living/carbon/superior_animal/handmade/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "", var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol, speech_volume)
	..()
	if(speaker in friends) // Is the one talking a friend?
		if(message == "Follow." && !following) // Is he telling us to follow?
			following = speaker
			visible_emote("state, \"Beginning Escort Protocol on [speaker.name].\"")

		if(message == "Stop." && following) // Else, is he telling us to stop?
			following = null
			visible_emote("state, \"Ending Escort Protocol.\"")

	if(speaker in creator) // Is it the creator speaking?

		// Add mobs as friends
		if(findtext(message, "Add User") && findtext(message, "[src.name]")) // Do we say the magic words with the bot's name?
			for(var/mob/target in range(viewRange, src)) // Check every mob that it can see
				if(target != src) // Not include the bot
					if(findtext(message, target.name)) // Was the mob named in the order?
						if(friends.Find(target)) // Is it already a user?
							visible_emote("state, \"Error, [target.name] is already a registered user.\"")
						else
							visible_emote("state, \"Registering [target.name] as a new user.\"")
							friends += target // Add the mob as a user

		// Remove mobs as friends
		if(findtext(message, "Remove User") && findtext(message, "[src.name]")) // Do we say the magic words with the bot's name?
			for(var/mob/target in range(viewRange, src)) // Check every mob that it can see
				if(target != src) // Not include the bot
					if(findtext(message, target.name)) // Was the mob named in the order?
						if(friends.Find(target)) // Is the user in the list?
							visible_emote("state, \"Removing [target.name] as a user.\"")
							friends -= target // Remove the mob as a user
						else
							visible_emote("state, \"Error, [target.name] is not a registered user.\"")
