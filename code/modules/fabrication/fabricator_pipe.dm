/obj/machinery/fabricator/pipe
	name = "Pipe Dispenser"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "pipe_d"
	obj_flags = OBJ_FLAG_ANCHORABLE
	fabricator_class = FABRICATOR_CLASS_PIPE
	base_type = /obj/machinery/fabricator/pipe
	stat_immune = NOSCREEN//Doesn't need screen, just input for the parts wanted
	power_channel = EQUIP
	anchored = 0
	use_power = POWER_USE_OFF
	template = "pipe_fab.tmpl"
	var/pipe_color = "white"

/obj/machinery/fabricator/pipe/on_update_icon()

/obj/machinery/fabricator/pipe/get_ui_data()
	. = ..()
	.["color"] = pipe_color

/obj/machinery/fabricator/pipe/CanUseTopic(mob/user)
	if(!anchored)
		return STATUS_CLOSE
	return ..()

/obj/machinery/fabricator/pipe/OnTopic(user, href_list, state)
	if(href_list["color_select"])
		var/choice = input(user, "What color do you want pipes to have?") as null|anything in pipe_colors
		if(!choice)
			return TOPIC_HANDLED
		pipe_color = choice
		return TOPIC_REFRESH
	return ..()
	
/obj/machinery/fabricator/pipe/wrench_floor_bolts()
	..()
	update_use_power(anchored ? POWER_USE_IDLE : POWER_USE_OFF)

/obj/machinery/fabricator/pipe/Initialize()//for mapping purposes. Anchor them by map var edit if needed.
	. = ..()
	if(anchored)
		update_use_power(POWER_USE_IDLE)

/obj/machinery/fabricator/pipe/do_build(var/datum/fabricator_recipe/recipe, var/amount)
	recipe.build(get_turf(src), amount, pipe_colors[pipe_color])
	use_power_oneoff(500 * amount)

/obj/machinery/fabricator/pipe/disposal
	name = "Disposal Pipe Dispenser"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "pipe_d"
	fabricator_class = FABRICATOR_CLASS_DISPOSAL
	base_type = /obj/machinery/fabricator/pipe/disposal

//Allow you to drag-drop disposal pipes into it
/obj/machinery/fabricator/pipe/disposal/MouseDrop_T(var/obj/structure/disposalconstruct/pipe as obj, mob/user as mob)
	if(!CanPhysicallyInteract(user))
		return

	if (!istype(pipe) || get_dist(src,pipe) > 1 )
		return

	if (pipe.anchored)
		return

	qdel(pipe)