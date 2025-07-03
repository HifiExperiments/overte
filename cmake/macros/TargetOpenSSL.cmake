#
#  Copyright 2015 High Fidelity, Inc.
#  Copyright 2025 Overte e.V.
#  Created by Bradley Austin Davis on 2015/10/10
#
#  Distributed under the Apache License, Version 2.0.
#  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
#
macro(TARGET_OPENSSL)
    find_package(OpenSSL REQUIRED)
    target_link_libraries(${TARGET_NAME} OpenSSL::SSL OpenSSL::Crypto)
endmacro()
