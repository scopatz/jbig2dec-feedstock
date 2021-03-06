setlocal EnableDelayedExpansion
::
:: Build EXE
::
nmake /f msvc.mak LIBPNGDIR=%LIBRARY_LIB% ZLIBDIR=%LIBRARY_LIB%
if errorlevel 1 exit 1

copy .\\jbig2dec.exe %LIBRARY_BIN%\\jbig2dec.exe
if errorlevel 1 exit 1

::
:: Build library and header
::
copy "%RECIPE_DIR%\\CMakeLists.txt" .
if errorlevel 1 exit 1

:: Make a build folder and change to it.
mkdir build
cd build

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles" ^
      -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
      -DCMAKE_BUILD_TYPE:STRING=Release ^
      ..
if errorlevel 1 exit 1

:: Build!
nmake
if errorlevel 1 exit 1

:: Install!
nmake install
if errorlevel 1 exit 1
