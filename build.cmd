@ECHO OFF
pushd %~dp0
powershell -file %~dp0build.ps1
popd