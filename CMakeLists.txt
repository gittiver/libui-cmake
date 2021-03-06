cmake_minimum_required(VERSION 3.12)


include(FetchContent)
FetchContent_Declare(
  libui_import
  GIT_REPOSITORY https://github.com/andlabs/libui.git
  GIT_PROGRESS TRUE
  FETCHCONTENT_QUIET FALSE
)

FetchContent_GetProperties(libui_import)
if(NOT libui_import_POPULATED)
  FetchContent_Populate(libui_import)
endif()

if (APPLE)
  enable_language(C CXX OBJC OBJCXX)
else()
  enable_language(C CXX)
endif()

project(libui)

include(FindGTK)

option(LIBUI_STATIC_LIB "build libui static library" ON)
option(LIBUI_SHARED_LIB "build libui shared library" OFF)
option(LIBUI_USE_SHARED_CRT "use shared crt library" ON)
option(LIBUI_BUILD_EXAMPLES "build examples for libui" OFF)
option(LIBUI_BUILD_TESTS "build tests for libui" OFF)


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

set(LIBUI_SOURCES_GTK
  ${libui_import_SOURCE_DIR}/unix/alloc.c
  ${libui_import_SOURCE_DIR}/unix/area.c
  ${libui_import_SOURCE_DIR}/unix/attrstr.c
  ${libui_import_SOURCE_DIR}/unix/box.c
  ${libui_import_SOURCE_DIR}/unix/button.c
  ${libui_import_SOURCE_DIR}/unix/cellrendererbutton.c
  ${libui_import_SOURCE_DIR}/unix/checkbox.c
  ${libui_import_SOURCE_DIR}/unix/child.c
  ${libui_import_SOURCE_DIR}/unix/colorbutton.c
  ${libui_import_SOURCE_DIR}/unix/combobox.c
  ${libui_import_SOURCE_DIR}/unix/control.c
  ${libui_import_SOURCE_DIR}/unix/datetimepicker.c
  ${libui_import_SOURCE_DIR}/unix/debug.c
  ${libui_import_SOURCE_DIR}/unix/draw.c
  ${libui_import_SOURCE_DIR}/unix/drawmatrix.c
  ${libui_import_SOURCE_DIR}/unix/drawpath.c
  ${libui_import_SOURCE_DIR}/unix/drawtext.c
  ${libui_import_SOURCE_DIR}/unix/editablecombo.c
  ${libui_import_SOURCE_DIR}/unix/entry.c
  ${libui_import_SOURCE_DIR}/unix/fontbutton.c
  ${libui_import_SOURCE_DIR}/unix/fontmatch.c
  ${libui_import_SOURCE_DIR}/unix/form.c
  ${libui_import_SOURCE_DIR}/unix/future.c
  ${libui_import_SOURCE_DIR}/unix/graphemes.c
  ${libui_import_SOURCE_DIR}/unix/grid.c
  ${libui_import_SOURCE_DIR}/unix/group.c
  ${libui_import_SOURCE_DIR}/unix/image.c
  ${libui_import_SOURCE_DIR}/unix/label.c
  ${libui_import_SOURCE_DIR}/unix/main.c
  ${libui_import_SOURCE_DIR}/unix/menu.c
  ${libui_import_SOURCE_DIR}/unix/multilineentry.c
  ${libui_import_SOURCE_DIR}/unix/opentype.c
  ${libui_import_SOURCE_DIR}/unix/progressbar.c
  ${libui_import_SOURCE_DIR}/unix/radiobuttons.c
  ${libui_import_SOURCE_DIR}/unix/separator.c
  ${libui_import_SOURCE_DIR}/unix/slider.c
  ${libui_import_SOURCE_DIR}/unix/spinbox.c
  ${libui_import_SOURCE_DIR}/unix/stddialogs.c
  ${libui_import_SOURCE_DIR}/unix/tab.c
  ${libui_import_SOURCE_DIR}/unix/table.c
  ${libui_import_SOURCE_DIR}/unix/tablemodel.c
  ${libui_import_SOURCE_DIR}/unix/text.c
  ${libui_import_SOURCE_DIR}/unix/util.c
  ${libui_import_SOURCE_DIR}/unix/window.c
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

#TODO set sources for gtk and windows
if (APPLE)
  set(LIBUI_SOURCES ${LIBUI_SOURCES_COMMON} ${LIBUI_SOURCES_DARWIN})
elseif(UNIX)
  set(LIBUI_SOURCES ${LIBUI_SOURCES_COMMON} ${LIBUI_SOURCES_GTK})
elseif(MSVC)
endif()

#TODO set libs for gtk and windows
if (APPLE)
  set(LIBUI_INCLUDE_DIRS ${libui_import_SOURCE_DIR})  
  set(LIBUI_LIBS "-framework Foundation" "-framework AppKit")
elseif(UNIX)
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
  pkg_check_modules(PC_PANGO REQUIRED pango)
  pkg_search_module(GLIB REQUIRED glib-2.0)
  #  target_link_directories(${GTK3_LIBRARY_DIRS})
    
  set(LIBUI_INCLUDE_DIRS ${libui_import_SOURCE_DIR}
                         ${GLIB_INCLUDE_DIRS}
                         /usr/include/gtk-3.0
			 /usr/include/pango-1.0
			 /usr/include/cairo
			 /usr/include/gdk-pixbuf-2.0
			 /usr/include/atk-1.0
			 )

  set(LIBUI_LIBS ${GLIB_LIBRARIES} ${GTK3_LIBRARIES} m dl pthread)
  set(LIBUI_DEFINITIONS ${GTK3_CFLAGS_OTHER} ${GLIB_CFLAGS_OTHER})
endif()

if (LIBUI_STATIC_LIB)
  add_library(ui STATIC ${LIBUI_SOURCES})
  target_link_libraries(ui ${LIBUI_LIBS})
  target_include_directories(ui PUBLIC ${LIBUI_INCLUDE_DIRS})
endif(LIBUI_STATIC_LIB)

if(LIBUI_SHARED_LIB)
  add_library(ui-shared SHARED ${LIBUI_SOURCES})
  target_link_libraries(ui-shared ${LIBUI_LIBS})
  target_include_directories(ui-shared PUBLIC ${LIBUI_INCLUDE_DIRS})
  set_target_properties(ui-shared PROPERTIES OUTPUT_NAME ui)
endif(LIBUI_SHARED_LIB)

##############################################################################
# build example executables 
##############################################################################
if(LIBUI_BUILD_EXAMPLES)
  set(EXAMPLE_DIR ${libui_import_SOURCE_DIR}/examples)

  add_executable(controlgallery ${EXAMPLE_DIR}/controlgallery/main.c)
  target_link_libraries(controlgallery ui ${LIBUI_LIBS})

  add_executable(histogram ${EXAMPLE_DIR}/histogram/main.c)
  target_link_libraries(histogram ui ${LIBUI_LIBS})

  add_executable(cpp-multithread ${EXAMPLE_DIR}/cpp-multithread/main.cpp)
  target_link_libraries(cpp-multithread ui ${LIBUI_LIBS})
    #   deps:    [
    #     dependency(threads,
    #       required: true),
    #   ],
    #   cpp_args:  libui_example_cpp_extra_args,
    #   link_args:  libui_example_cpp_extra_args,
    # },
  
  add_executable(drawtext ${EXAMPLE_DIR}/drawtext/main.c)
  target_link_libraries(drawtext ui ${LIBUI_LIBS})

  add_executable(timer ${EXAMPLE_DIR}/timer/main.c)
  target_link_libraries(timer ui ${LIBUI_LIBS})

  add_executable(datetime ${EXAMPLE_DIR}/datetime/main.c)
  target_link_libraries(datetime ui ${LIBUI_LIBS})
endif(LIBUI_BUILD_EXAMPLES)

##############################################################################
# build test executables 
##############################################################################
if (LIBUI_BUILD_TESTS)
  set(TEST_DIR ${libui_import_SOURCE_DIR}/test)
  set(LIBUI_TEST_SOURCES 
    ${TEST_DIR}/drawtests.c
    ${TEST_DIR}/images.c
    ${TEST_DIR}/main.c
    ${TEST_DIR}/menus.c
    ${TEST_DIR}/page1.c
    ${TEST_DIR}/page2.c
    ${TEST_DIR}/page3.c
    ${TEST_DIR}/page4.c
    ${TEST_DIR}/page5.c
    ${TEST_DIR}/page6.c
    ${TEST_DIR}/page7.c
    ${TEST_DIR}/page7a.c
    ${TEST_DIR}/page7b.c
    ${TEST_DIR}/page7c.c
  #  ${TEST_DIR}/page8.c
  #  ${TEST_DIR}/page9.c
  #  ${TEST_DIR}/page10.c
    ${TEST_DIR}/page11.c
    ${TEST_DIR}/page12.c
    ${TEST_DIR}/page13.c
    ${TEST_DIR}/page14.c
    ${TEST_DIR}/page15.c
    ${TEST_DIR}/page16.c
    ${TEST_DIR}/spaced.c
  )

  add_executable(tester ${LIBUI_TEST_SOURCES})
  target_link_libraries(tester ui ${LIBUI_LIBS})
endif(LIBUI_BUILD_TESTS)

install(TARGETS ui
        EXPORT libui
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include
        )

if (LIBUI_STATIC_LIB)
  export(TARGETS ui FILE libui.cmake)
endif(LIBUI_STATIC_LIB)

if (LIBUI_SHARED_LIB)
  export(TARGETS ui-shared FILE libui-shared.cmake)
endif(LIBUI_SHARED_LIB)

export(PACKAGE LIBUI)
