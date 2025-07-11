#
#  AddCrashpad.cmake
#  cmake/macros
#
#  Created by Clement Brisset on 01/19/18.
#  Copyright 2018 High Fidelity, Inc.
#  Copyright 2025 Overte e.V.
#
#  Distributed under the Apache License, Version 2.0.
#  See the accompanying file LICENSE or http:#www.apache.org/licenses/LICENSE-2.0.html
#

macro(add_crashpad)
  set (USE_CRASHPAD TRUE)
  message(STATUS "Checking crashpad config")

  if (OVERTE_BACKTRACE_URL STREQUAL "")
    message(STATUS "Checking crashpad config - -DOVERTE_BACKTRACE_URL is empty, disabled.")
    set(USE_CRASHPAD FALSE)
  endif()

  if (OVERTE_BACKTRACE_TOKEN STREQUAL "")
    message(STATUS "Checking crashpad config - -DOVERTE_BACKTRACE_TOKEN is empty, disabled.")
    set(USE_CRASHPAD FALSE)
  endif()

  if (CMAKE_SYSTEM_NAME STREQUAL "Linux" AND CMAKE_SYSTEM_PROCESSOR STREQUAL "aarch64")
    message(STATUS "Checking crashpad config - Linux aarch64 is not supported by crashpad, disabled.")
    set(USE_CRASHPAD FALSE)
  endif()

  if (USE_CRASHPAD)
    message(STATUS "Checking crashpad config - enabled.")
    get_property(CRASHPAD_CHECKED GLOBAL PROPERTY CHECKED_FOR_CRASHPAD_ONCE)
    if (NOT CRASHPAD_CHECKED)
      find_package(Crashpad REQUIRED)

      set_property(GLOBAL PROPERTY CHECKED_FOR_CRASHPAD_ONCE TRUE)
    endif()

    add_definitions(-DHAS_CRASHPAD)
    add_definitions(-DOVERTE_BACKTRACE_URL=\"${OVERTE_BACKTRACE_URL}\")
    add_definitions(-DOVERTE_BACKTRACE_TOKEN=\"${OVERTE_BACKTRACE_TOKEN}\")

    target_include_directories(${TARGET_NAME} PRIVATE ${CRASHPAD_INCLUDE_DIRS})
    target_link_libraries(${TARGET_NAME} ${CRASHPAD_LIBRARY} ${CRASHPAD_UTIL_LIBRARY} ${CRASHPAD_BASE_LIBRARY})

    if (WIN32)
      set_target_properties(${TARGET_NAME} PROPERTIES LINK_FLAGS "/ignore:4099")
    elseif (APPLE)
      find_library(Security Security)
      target_link_libraries(${TARGET_NAME} ${Security})
      target_link_libraries(${TARGET_NAME} "-lbsm")
    endif()

    add_custom_command(
      TARGET ${TARGET_NAME}
      POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy ${CRASHPAD_HANDLER_EXE_PATH} "$<TARGET_FILE_DIR:${TARGET_NAME}>/"
    )
  endif ()
endmacro()
