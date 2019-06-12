/datum/map
	var/const/NO_APC = 1
	var/const/NO_VENT = 2
	var/const/NO_SCRUBBER = 4

	var/const/SELF = 1
	var/const/SUBTYPES = 2

	// Unit test vars
	var/list/apc_test_exempt_areas = list(
		/area/space = NO_SCRUBBER|NO_VENT|NO_APC,
		/area/exoplanet = NO_SCRUBBER|NO_VENT|NO_APC
	)

	var/list/area_coherency_test_exempt_areas = list(
		/area/space
	)
	var/list/area_coherency_test_exempted_root_areas = list(
		/area/exoplanet
	)
	var/list/area_coherency_test_subarea_count = list()

	// These areas are used specifically by code and need to be broken out somehow
	var/list/area_usage_test_exempted_areas = list(
		/area/beach,
		/area/centcom,
		/area/centcom/holding,
		/area/centcom/specops,
		/area/chapel,
		/area/hallway,
		/area/maintenance,
		/area/medical,
		/area/medical/virology,
		/area/medical/virologyaccess,
		/area/overmap,
		/area/rnd,
		/area/rnd/xenobiology,
		/area/rnd/xenobiology/xenoflora,
		/area/rnd/xenobiology/xenoflora_storage,
		/area/security,
		/area/security/prison,
		/area/security/brig,
		/area/skipjack_station,
		/area/skipjack_station/start,
		/area/shuttle,
		/area/shuttle/escape,
		/area/shuttle/escape/centcom,
		/area/shuttle/specops,
		/area/shuttle/specops/centcom,
		/area/shuttle/syndicate_elite,
		/area/shuttle/syndicate_elite/mothership,
		/area/shuttle/syndicate_elite/station,
		/area/turbolift,
		/area/supply,
		/area/syndicate_mothership,
		/area/syndicate_mothership/elite_squad,
		/area/wizard_station,
		/area/template_noop
	)

	var/list/area_usage_test_exempted_root_areas = list(
		/area/map_template,
		/area/exoplanet
	)

	var/list/area_purity_test_exempt_areas = list()

	var/list/buildable_exempt_machines = list(
		// Not buildable due to custom building procedure
		/obj/machinery/power/terminal = SELF,
		/obj/machinery/power/apc = SELF | SUBTYPES,
		/obj/machinery/door/firedoor = SELF | SUBTYPES,

		// Not buildable because a base type is buildable
		/obj/machinery/power/smes = SUBTYPES,
		/obj/machinery/alarm = SUBTYPES,
		/obj/machinery/vending/hydronutrients = SUBTYPES,
		/obj/machinery/vending/hydroseeds = SUBTYPES,

		// Not buildable due to special nature (not machines in classical sense)
		/obj/machinery/portable_atmospherics/hydroponics/soil/invisible = SELF,

		// Not buildable for balance or antag reasons
		/obj/machinery/teleport = SELF | SUBTYPES,
		/obj/machinery/vending/assist/antag = SELF,
		/obj/machinery/vending/magivend = SELF,
		/obj/machinery/vending/props = SELF
	)