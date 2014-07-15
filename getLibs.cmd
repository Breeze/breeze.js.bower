@echo off
REM Creates the bower package files by copying
REM them here from their sources in other repos.
REM The package maintainers call this command before publishing.
REM Assumes the source breeze repos are siblings to this repo
if not exist "%1..\breeze.js\build" GOTO :skip
if not exist "%1..\breeze.js\src\" GOTO :skip
if not exist "%1..\breeze.js.labs\" GOTO :skip
GOTO :libsExist

:skip
echo Skipping file copy because can't find one (or more) source folders
GOTO :done

:libsExist
if not exist "%1adapters" MKDIR "%1adapters"
if not exist "%1labs" MKDIR "%1labs"

echo Copying breeze client files into the breeze.js.bower repo
@echo on
XCOPY "%1..\breeze.js\build\*.js" "%1." /Y 

XCOPY "%1..\breeze.js\src\breeze.dataService.mongo.js" "%1adapters" /Y 
XCOPY "%1..\breeze.js\src\breeze.modelLibrary.backbone.js" "%1adapters" /Y 

XCOPY "%1..\breeze.js.labs\*.js" "%1labs" /Y 
XCOPY "%1..\breeze.js.labs\*.css" "%1labs" /Y 

@echo off
REM Exclude certain files
@echo on
DEL "%1labs\b00_breeze.modelLibrary.new-backingstore.js" 2>nul
DEL "%1labs\breeze.ajaxrestinterceptor.js" 2>nul
DEL "%1labs\breeze.to$q.shim.js" 2>nul

@echo off
@echo.
@echo CONFIRM that all files copied successfully 

:done
@echo.
pause 