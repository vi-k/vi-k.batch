@echo off
set bcc=C:\Program Files\Embarcadero\RAD Studio\7.0
set vc=D:\Program Files\Microsoft Visual Studio 9.0\VC
set vc-sdk=C:\Program Files\Microsoft SDKs\Windows\v6.0A
set vc-path=%vc%\Common7\IDE
set intel=D:\Program Files\Intel\Compiler\11.1\054

if "%1"=="bcc" (
  set boost=@bcc-boost
) else (
  set boost=@boost-1-42
)

set boost-1-42=D:\Program Files\boost_1_42_0
set boost-1-42-to=boost
set bcc-boost=%bcc%\include\boost_1_39
set bcc-boost-to=boost
set boost-trunk=D:\Program Files\boost-trunk
set boost-trunk-to=boost

set wx=D:\Program Files\wxWidgets-2.8.10

set win32=user32.lib

.build.bat %*
