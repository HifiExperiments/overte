#
#  Created by Brad Hefta-Gaub on 6/9/2016
#  Copyright 2016 High Fidelity, Inc.
#  Copyright 2025 Overte e.V.
#
#  Distributed under the Apache License, Version 2.0.
#  See the accompanying file LICENSE or http:#www.apache.org/licenses/LICENSE-2.0.html
#

set(TARGET_NAME pcmCodec)
setup_hifi_client_server_plugin()
link_hifi_libraries(shared audio plugins)

if (OVERTE_BUILD_SERVER)
  install_beside_console()
endif ()
