cmake_minimum_required(VERSION 3.20)

project(Macro)
include(cmake/Core.cmake)

ae2f_CoreLibTent(Macro INTERFACE inc ae2f "inc/Macro.h")
set(ae2f_Macro_ROOT "${PROJECT_SOURCE_DIR}/src/" CACHE STRING "${PROJECT_SOURCE_DIR}/src/")

function(ae2f_Macro_init prm_CMT_REQUIRED prm_SZPARAM prm_SZTPARAM)
	file(REMOVE_RECURSE ${ae2f_Macro_ROOT}/build/*)

	execute_process(
		WORKING_DIRECTORY ${ae2f_Macro_ROOT}
		COMMAND "cmake" "-S" "." "-B" "build" ${ARGN}
		COMMAND "cmake" "--build" "build"
	)
endfunction()

function(ae2f_Macro_one prm_in prm_out)
	execute_process(
		COMMAND ${ae2f_Macro_ROOT}/build/Macro 
		INPUT_FILE ${prm_in}
		OUTPUT_FILE ${prm_out}
		OUTPUT_VARIABLE MacroOut
	)

	if(${MacroOut} EQUAL 0)
		message("[ae2f_Macro] succeed.")
	endif()

	if(${MacroOut} EQUAL 1)
		message(FATAL_ERROR "[ae2f_Macro] Output operation has failed.")
	endif()

	if(${MacroOut} EQUAL 2)
		message(FATAL_ERROR "[ae2f_Macro] Unexpected token.")
	endif()

	if(${MacroOut} EQUAL 3)
		message(FATAL_ERROR "[ae2f_Macro] Buffer overrun has occurred.")
	endif()
endfunction()

function(ae2f_Macro_autoname prm_in)
	get_filename_component(path_no_ext "${prm_in}" NAME_WE)
	get_filename_component(ext "${prm_in}" LAST_EXT)
	get_filename_component(dir "${prm_in}" DIRECTORY)

	ae2f_Macro_one(${prm_in}  "${dir}/${path_no_ext}.auto${ext}")
endfunction()
