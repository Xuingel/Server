@echo off
rem # Valhelsia Enhanced Vanilla Server Startup Script

rem # Edit the below values to change JVM Arguments or Allocated RAM for the server:
set ALLOCATED_RAM=4G
set JVM_ARGUMENTS=-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch

rem # Make sure this matches the Fabric version of the server if you update:
set FABRIC_VERSION=fabric-0.10.2
set FABRIC_LOADER_VERSION=0.12.12
set MC_VERSION=1.18.1

rem # Install Minecraft Fabric if it isn't already installed:
if not exist .\%FABRIC_VERSION%-%FABRIC_LOADER_VERSION%.jar (
    echo Installing Minecraft Fabric Server
    java -jar %FABRIC_VERSION%-installer.jar server -mcversion %MC_VERSION% -loader %FABRIC_LOADER_VERSION% -downloadMinecraft
)
if not exist .\%MC_VERSION%.jar (
    ren server.jar minecraft_server.%MC_VERSION%.jar
)
if not exist .\%FABRIC_VERSION%-%FABRIC_LOADER_VERSION%.jar (
    ren fabric-server-launch.jar %FABRIC_VERSION%-%FABRIC_LOADER_VERSION%.jar
)

rem # Delete installer file.
if exist .\%FABRIC_VERSION%-installer.jar (
    if exist .\%FABRIC_VERSION%-%FABRIC_LOADER_VERSION%.jar (
	echo Deleting the installer file.
    	del %FABRIC_VERSION%-installer.jar
    )
)

rem # Start server.
echo Starting Valhelsia Enhanced Vanilla Server
java -jar -Xms%ALLOCATED_RAM% -Xmx%ALLOCATED_RAM% %JVM_ARGUMENTS% %FABRIC_VERSION%-%FABRIC_LOADER_VERSION%.jar nogui

pause
