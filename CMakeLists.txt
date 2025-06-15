cmake_minimum_required(VERSION 3.20)

project(Macro)
include(cmake/Core.cmake)

ae2f_CoreLibTent(Macro INTERFACE inc ae2f "inc/ae2f/Macro.h")
set(ae2f_Macro_ROOT "${PROJECT_SOURCE_DIR}/src" CACHE STRING "${PROJECT_SOURCE_DIR}/src")

function(ae2f_Macro_init prm_CMT_REQUIRED prm_SZPARAM prm_SZTPARAM)
	file(REMOVE ${ae2f_Macro_ROOT}/build/Macro)
  	message("[ae2f_Macro_init]  ${CMAKE_GENERATOR}")

	execute_process(
		WORKING_DIRECTORY ${ae2f_Macro_ROOT}
		COMMAND ${CMAKE_COMMAND} 
    "-S" "." "-B" "./build" "-G" "${CMAKE_GENERATOR}" 
		-Dae2f_Macro_CMT_REQUIRED=${prm_CMT_REQUIRED}
		-Dae2f_Macro_SZPARAM=${prm_SZPARAM}
		-Dae2f_Macro_SZTPARAM=${prm_SZTPARAM}
		${ARGN}
  		RESULT_VARIABLE ConfOut
	)

 	if(NOT ConfOut EQUAL 0)
		message(FATAL_ERROR "[ae2f_Macro_init] Configuration failed. ${ConfOut}")
	endif()

	execute_process(
		WORKING_DIRECTORY ${ae2f_Macro_ROOT}
		COMMAND ${CMAKE_COMMAND} "--build" "build"
  		RESULT_VARIABLE BuildOut
		)
  
 	if(NOT BuildOut EQUAL 0)
		message(FATAL_ERROR "[ae2f_Macro_init] Build failed. ${BuildOut}")
	endif()

 	message("[ae2f_Macro_init] Succeed.")
endfunction()

function(ae2f_Macro_one prm_in prm_out)
	message("[ae2f_Macro_one] ${prm_in} ${prm_out}")
	message("[ae2f_Macro_one] ROOT ${ae2f_Macro_ROOT}")

	execute_process(
		COMMAND ${ae2f_Macro_ROOT}/build/Macro 
		INPUT_FILE ${prm_in}
		OUTPUT_FILE ${prm_out}
		RESULT_VARIABLE MacroOut
	)

	if(MacroOut EQUAL 0)
		message("[ae2f_Macro] succeed.")
	endif()

	if(MacroOut EQUAL 1)
		message(FATAL_ERROR "[ae2f_Macro] Output operation has failed.")
	endif()

	if(MacroOut EQUAL 2)
		message(FATAL_ERROR "[ae2f_Macro] Unexpected token.")
	endif()

	if(MacroOut EQUAL 3)
		message(FATAL_ERROR "[ae2f_Macro] Buffer overrun has occurred.")
	endif()
endfunction()

function(ae2f_Macro_autoname prm_in)
	get_filename_component(path_no_ext "${prm_in}" NAME_WE)
	get_filename_component(ext "${prm_in}" LAST_EXT)
	get_filename_component(dir "${prm_in}" DIRECTORY)

	ae2f_Macro_one(${prm_in}  "${dir}/${path_no_ext}.auto${ext}")
endfunction()
