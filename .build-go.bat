@echo off
set bcc=C:\Program Files\Embarcadero\RAD Studio\7.0

set vc=C:\Program Files\Microsoft Visual Studio 9.0
set vc-sdk=C:\Program Files\Microsoft SDKs\Windows\v6.0A
set vc-path=%vc%\Common7\IDE

set intel=C:\Program Files\Intel\Compiler\11.1\054

set vc10=C:\Program Files\Microsoft Visual Studio 10.0
set vc10-sdk=C:\Program Files\Microsoft SDKs\Windows\v7.0A
set vc10-path=%vc10%\Common7\IDE

if "%1"=="bcc" (
  set boost=@bcc-boost
) else (
  set boost=@boost-1-43
)

set boost-1-43=D:\Program Files\boost_1_43_0
set boost-1-43-to=boost
set bcc-boost=%bcc%\include\boost_1_39
set bcc-boost-to=boost
set boost-trunk=D:\Program Files\boost-trunk
set boost-trunk-to=boost

set wx=D:\Program Files\wxWidgets-2.8.10

set win32=user32.lib

d:\My\C++\batch\.build.bat %*
