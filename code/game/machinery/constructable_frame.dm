//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:31

//Circuit boards are in /code/game/objects/items/weapons/circuitboards/machinery/

/obj/machinery/constructable_frame //Made into a seperate type to make future revisions easier.
	name = "machine frame"
	icon = 'icons/obj/stock_parts.dmi'
	icon_state = "box_0"
	density = TRUE
	anchored = FALSE
	use_power = POWER_USE_OFF
	uncreated_component_parts = null
	construct_state = /decl/machine_construction/frame/unwrenched
	var/obj/item/weapon/stock_parts/circuitboard/circuit = null
	var/list/components = null
	var/list/req_components = null
	var/list/req_component_names = null
	var/expected_machine_type
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE

/obj/machinery/constructable_frame/examine(mob/user)
	. = ..()
	if(. && req_components)
		var/list/component_list = list()
		for(var/I in req_components)
			if(req_components[I] > 0)
				component_list += "[num2text(req_components[I])] [req_component_names[I]]"
		to_chat(user, "Requires [english_list(component_list)].")

/obj/machinery/constructable_frame/state_transition(decl/machine_construction/new_state)
	. = ..()
	update_icon()

/obj/machinery/constructable_frame/dismantle()
	new /obj/item/stack/material/steel(loc, 5)
	qdel(src)
	return TRUE

/obj/machinery/constructable_frame/machine_frame
	expected_machine_type = "machine"

/obj/machinery/constructable_frame/machine_frame/on_update_icon()
	switch(construct_state && construct_state.type)
		if(/decl/machine_construction/frame/awaiting_circuit)
			icon_state = "box_1"
		if(/decl/machine_construction/frame/awaiting_parts)
			icon_state = "box_2"
		else
			icon_state = "box_0"

/obj/machinery/constructable_frame/machine_frame/deconstruct
	anchored = TRUE
	construct_state = /decl/machine_construction/frame/awaiting_circuit