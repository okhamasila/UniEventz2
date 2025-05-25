@echo off
"D:\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HD:\\flutter\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86" ^
  "-DANDROID_NDK=D:\\Android\\sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_ANDROID_NDK=D:\\Android\\sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_TOOLCHAIN_FILE=D:\\Android\\sdk\\ndk\\27.0.12077973\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=D:\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\\semester 6\\Pengembangan Aplikasi mobile\\UAS\\unieventz\\build\\app\\intermediates\\cxx\\Debug\\52585k66\\obj\\x86" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=D:\\semester 6\\Pengembangan Aplikasi mobile\\UAS\\unieventz\\build\\app\\intermediates\\cxx\\Debug\\52585k66\\obj\\x86" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BD:\\semester 6\\Pengembangan Aplikasi mobile\\UAS\\unieventz\\android\\app\\.cxx\\Debug\\52585k66\\x86" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
