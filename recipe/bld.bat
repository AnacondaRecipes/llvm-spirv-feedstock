rmdir /S /Q build
mkdir build
cd build

cmake -G Ninja ^
    -DCMAKE_BUILD_TYPE=Release ^
    "-DLLVM_DIR=%LIBRARY_PREFIX%/lib/cmake/llvm" ^
    "-DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%" ^
    "-DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%" ^
    ..
IF %ERRORLEVEL% NEQ 0 exit 1

ninja -n
ninja install
IF %ERRORLEVEL% NEQ 0 exit 1

ninja llvm-spirv
copy tools\llvm-spirv\llvm-spirv.exe "%LIBRARY_PREFIX%\bin"
IF %ERRORLEVEL% NEQ 0 exit 1
