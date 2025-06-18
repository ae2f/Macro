cmake_minimum_required(VERSION 3.30)
project(Macro_BIN)

add_executable(Macro main.c)

set(ae2f_Macro_CMT_REQUIRED 1)
set(ae2f_Macro_SZPARAM      50)
set(ae2f_Macro_SZTPARAM     300)
set(ae2f_MAC_KEYWORD        ae2f_MAC)

file(WRITE ${PROJECT_SOURCE_DIR}/main.auto.h "#define ae2f_MAC_KEYWORD \"${ae2f_MAC_KEYWORD}\"")

target_compile_definitions(Macro PRIVATE -DCMT_REQUIRED=${ae2f_Macro_CMT_REQUIRED})
target_compile_definitions(Macro PRIVATE -DSZPARAM=${ae2f_Macro_SZPARAM})
target_compile_definitions(Macro PRIVATE -DSZTPARAM=${ae2f_Macro_SZTPARAM})
