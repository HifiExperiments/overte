# 
#  Copyright 2015 High Fidelity, Inc.
#  Copyright 2025 Overte e.V.
#  Created by Bradley Austin Davis on 2015/10/10
#
#  Distributed under the Apache License, Version 2.0.
#  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
# 
macro(TARGET_GLM)
    find_package(glm CONFIG REQUIRED)
    target_link_libraries(${TARGET_NAME} glm::glm)
    target_compile_definitions(${TARGET_NAME} PUBLIC GLM_FORCE_RADIANS)
    target_compile_definitions(${TARGET_NAME} PUBLIC GLM_ENABLE_EXPERIMENTAL)
    target_compile_definitions(${TARGET_NAME} PUBLIC GLM_FORCE_CTOR_INIT)
endmacro()