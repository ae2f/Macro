cmake_minimum_required(VERSION 3.20)

project(Macro VERSION 1.1.4)

set(ae2f_Macro_ROOT "${PROJECT_SOURCE_DIR}/src-macro" CACHE STRING "${PROJECT_SOURCE_DIR}/src-macro")

include(cmake/Core.cmake)
include(cmake/Macro.cmake)

if(NOT TARGET ae2f::Macro)
	configure_file(${PROJECT_SOURCE_DIR}/Macro.h.in ${PROJECT_SOURCE_DIR}/inc/ae2f/Macro.h)
	ae2f_CoreLibTent(Macro INTERFACE inc ae2f "inc/ae2f/Macro.h")
endif()
