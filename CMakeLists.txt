cmake_minimum_required(VERSION 3.16)

include(FetchContent)
FetchContent_Declare(
  libui_import
  GIT_REPOSITORY https://github.com/andlabs/libui.git
  GIT_PROGRESS TRUE
#  PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/src-import
#  SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src-import-src
  FETCHCONTENT_QUIET FALSE
  
)

FetchContent_GetProperties(libui_import)
if(NOT libui_import_POPULATED)
  FetchContent_Populate(libui_import)
endif()

enable_language(C)

project(libui)

option(LIBUI_STATIC_LIB "build libui static library" ON)
option(LIBUI_SHARED_LIB "build libui shared library" OFF)
option(LIBUI_USE_SHARED_CRT "use shared crt library" ON)

if (MSVC)
if (NOT LIBUI_USE_SHARED_CRT)
       foreach(flag_var
                CMAKE_CXX_FLAGS_DEBUG
                CMAKE_CXX_FLAGS_RELEASE
                CMAKE_CXX_FLAGS_MINSIZEREL
                CMAKE_CXX_FLAGS_RELWITHDEBINFO
                CMAKE_C_FLAGS_DEBUG
                CMAKE_C_FLAGS_RELEASE
                CMAKE_C_FLAGS_MINSIZEREL
                CMAKE_C_FLAGS_RELWITHDEBINFO
                )
            string(REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
        endforeach()
#else(LIBUI_USE_SHARED_CRT)
endif(NOT LIBUI_USE_SHARED_CRT)
endif(MSVC)

set(LIBUI_SOURCES_DARWIN
  ${libui_import_SOURCE_DIR}/darwin/aat.m
  ${libui_import_SOURCE_DIR}/darwin/alloc.m
  ${libui_import_SOURCE_DIR}/darwin/area.m
  ${libui_import_SOURCE_DIR}/darwin/areaevents.m
  ${libui_import_SOURCE_DIR}/darwin/attrstr.m
  ${libui_import_SOURCE_DIR}/darwin/autolayout.m
  ${libui_import_SOURCE_DIR}/darwin/box.m
${libui_import_SOURCE_DIR}/darwin/button.m
${libui_import_SOURCE_DIR}/darwin/checkbox.m
${libui_import_SOURCE_DIR}/darwin/colorbutton.m
${libui_import_SOURCE_DIR}/darwin/combobox.m
${libui_import_SOURCE_DIR}/darwin/control.m
${libui_import_SOURCE_DIR}/darwin/datetimepicker.m
${libui_import_SOURCE_DIR}/darwin/debug.m
${libui_import_SOURCE_DIR}/darwin/draw.m
${libui_import_SOURCE_DIR}/darwin/drawtext.m
${libui_import_SOURCE_DIR}/darwin/editablecombo.m
${libui_import_SOURCE_DIR}/darwin/entry.m
${libui_import_SOURCE_DIR}/darwin/fontbutton.m
${libui_import_SOURCE_DIR}/darwin/fontmatch.m
${libui_import_SOURCE_DIR}/darwin/fonttraits.m
${libui_import_SOURCE_DIR}/darwin/fontvariation.m
${libui_import_SOURCE_DIR}/darwin/form.m
${libui_import_SOURCE_DIR}/darwin/future.m
${libui_import_SOURCE_DIR}/darwin/graphemes.m
${libui_import_SOURCE_DIR}/darwin/grid.m
${libui_import_SOURCE_DIR}/darwin/group.m
${libui_import_SOURCE_DIR}/darwin/image.m
${libui_import_SOURCE_DIR}/darwin/label.m
${libui_import_SOURCE_DIR}/darwin/main.m
${libui_import_SOURCE_DIR}/darwin/map.m
${libui_import_SOURCE_DIR}/darwin/menu.m
${libui_import_SOURCE_DIR}/darwin/multilineentry.m
${libui_import_SOURCE_DIR}/darwin/opentype.m
${libui_import_SOURCE_DIR}/darwin/progressbar.m
${libui_import_SOURCE_DIR}/darwin/radiobuttons.m
${libui_import_SOURCE_DIR}/darwin/scrollview.m
${libui_import_SOURCE_DIR}/darwin/separator.m
${libui_import_SOURCE_DIR}/darwin/slider.m
${libui_import_SOURCE_DIR}/darwin/spinbox.m
${libui_import_SOURCE_DIR}/darwin/stddialogs.m
${libui_import_SOURCE_DIR}/darwin/tab.m
${libui_import_SOURCE_DIR}/darwin/table.m
${libui_import_SOURCE_DIR}/darwin/tablecolumn.m
${libui_import_SOURCE_DIR}/darwin/text.m
${libui_import_SOURCE_DIR}/darwin/undocumented.m
${libui_import_SOURCE_DIR}/darwin/util.m
${libui_import_SOURCE_DIR}/darwin/window.m
${libui_import_SOURCE_DIR}/darwin/winmoveresize.m
)

set(LIBUI_SOURCES_COMMON
	${libui_import_SOURCE_DIR}/common/attribute.c
	${libui_import_SOURCE_DIR}/common/attrlist.c
	${libui_import_SOURCE_DIR}/common/attrstr.c
	${libui_import_SOURCE_DIR}/common/areaevents.c
	${libui_import_SOURCE_DIR}/common/control.c
	${libui_import_SOURCE_DIR}/common/debug.c
	${libui_import_SOURCE_DIR}/common/matrix.c
	${libui_import_SOURCE_DIR}/common/opentype.c
	${libui_import_SOURCE_DIR}/common/shouldquit.c
	${libui_import_SOURCE_DIR}/common/tablemodel.c
	${libui_import_SOURCE_DIR}/common/tablevalue.c
	${libui_import_SOURCE_DIR}/common/userbugs.c
	${libui_import_SOURCE_DIR}/common/utf.c
  )

set(LIBUI_LIBS_DARWIN "-framework Foundation" "-framework AppKit")


set(LIBUI_SOURCES ${LIBUI_SOURCES_COMMON} ${LIBUI_SOURCES_DARWIN})
set(LIBUI_LIBS ${LIBUI_LIBS_DARWIN})

add_library(libui STATIC ${LIBUI_SOURCES})

add_library(libui-shared SHARED ${LIBUI_SOURCES})
target_link_libraries(libui-shared ${LIBUI_LIBS})
set_target_properties(libui-shared
        PROPERTIES OUTPUT_NAME libui)

install(TARGETS libui
        EXPORT libui
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include
        )
export(TARGETS libui FILE libui.cmake)
export(TARGETS libui-shared FILE libui-shared.cmake)
export(PACKAGE LIBUI)
