set(BINARY_DESTINATION_DIR "bin")
set(DATA_DESTINATION_DIR "share/games/freerct")

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
	set(ARCHITECTURE "amd64")
else()
	string(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}" ARCHITECTURE)
endif()
if(WIN32)
	if(CMAKE_SIZEOF_VOID_P EQUAL 8)
		set(ARCHITECTURE "win64")
	else()
		set(ARCHITECTURE "win32")
	endif()
endif()
set(CPACK_SYSTEM_NAME "${ARCHITECTURE}")

set(CPACK_PACKAGE_NAME "freerct")
set(CPACK_PACKAGE_VENDOR "FreeRCT")
set(CPACK_PACKAGE_DESCRIPTION "FreeRCT aims to be a free and open source game which captures the look, feel and gameplay of the popular games RollerCoaster Tycoon 1 and 2.")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Game in the style of RollerCoaster Tycoon")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://freerct.net")
set(CPACK_PACKAGE_CONTACT "Benedikt Straub <benedikt-straub@web.de>")  # TODO A FreeRCT dev team mailing list would be better.
set(CPACK_PACKAGE_INSTALL_DIRECTORY "FreeRCT")
set(CPACK_PACKAGE_CHECKSUM "SHA256")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE-gpl-2.0.txt")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.rst")
set(CPACK_MONOLITHIC_INSTALL YES)
set(CPACK_PACKAGE_EXECUTABLES "freerct;FreeRCT")
set(CPACK_STRIP_FILES YES)
set(CPACK_OUTPUT_FILE_PREFIX "bundles")
set(CPACK_PACKAGE_VERSION "${VERSION_STRING}")

if(WIN32)
	set(CPACK_GENERATOR "ZIP;NSIS")
	include(cpack/PackageNSIS.cmake)
	set(CPACK_PACKAGE_FILE_NAME "freerct-${VERSION_STRING}-windows-${CPACK_SYSTEM_NAME}")
elseif(UNIX)
	set(CPACK_GENERATOR "DEB;TXZ")
	include(cpack/PackageDeb.cmake)
	set(CPACK_PACKAGE_FILE_NAME "freerct-${VERSION_STRING}-linux-${CPACK_SYSTEM_NAME}")
else()
	message(FATAL_ERROR "Unknown OS found for packaging; please consider creating a Pull Request to add support for this OS.")
endif()

include(CPack)
