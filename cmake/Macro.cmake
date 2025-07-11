set(ae2f_MAC_KEYWORD "ae2f_MAC")

function(ae2f_Macro_init prm_CMT_REQUIRED prm_SZPARAM prm_SZTPARAM)
	file(REMOVE_RECURSE ${ae2f_Macro_ROOT}/build/bin)
  	message("[ae2f_Macro_init]  ${CMAKE_GENERATOR}")

	if(${CMAKE_C_STANDARD})
		set(cstd "-DCMAKE_C_STANDARD=${CMAKE_C_STANDARD}")
	else()
		set(cstd "")
	endif()

	if(${CMAKE_C_COMPILER})
		set(cc "-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}")
	else()
		set(cc "")
	endif()

	if(${CMAKE_GENERATOR})
		set(gen "-G${CMAKE_GENERATOR}")
	else()
		set(gen "")
	endif()

	execute_process(
		WORKING_DIRECTORY ${ae2f_Macro_ROOT}
		COMMAND ${CMAKE_COMMAND} 
		"-S" "." "-B" "./build"
		-Dae2f_Macro_CMT_REQUIRED=${prm_CMT_REQUIRED}
		-Dae2f_Macro_SZPARAM=${prm_SZPARAM}
		-Dae2f_Macro_SZTPARAM=${prm_SZTPARAM}
        	-Dae2f_MAC_KEYWORD=${ae2f_MAC_KEYWORD}
		${gen} ${cstd} ${cc}
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

	file(GLOB_RECURSE macrocmd ${ae2f_Macro_ROOT}/build/bin/**)

	execute_process(
		COMMAND ${macrocmd}
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


function(ae2f_Macro_cvrt prm_in prm_dir prm_ext)
	get_filename_component(path_no_ext "${prm_in}" NAME_WE)
	ae2f_Macro_one(${prm_in} ${prm_dir}/${path_no_ext}${prm_ext})
endfunction()

function(ae2f_Macro_autoname prm_in)
	get_filename_component(path_no_ext "${prm_in}" NAME_WE)
	get_filename_component(ext "${prm_in}" LAST_EXT)
	get_filename_component(dir "${prm_in}" DIRECTORY)

	ae2f_Macro_one(${prm_in}  "${dir}/${path_no_ext}.auto${ext}")
endfunction()

if(${ae2f_TEST})
	ae2f_Macro_init(1, 100, 100)
endif()
