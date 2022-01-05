#!/bin/sh
# Valhelsia Enhanced Vanilla Server Startup Script

# Edit the below values to change JVM Arguments or Allocated RAM for the server:
ALLOCATED_RAM="4G"
JVM_ARGUMENTS="-XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=100 -XX:+DisableExplicitGC -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:G1MixedGCLiveThresholdPercent=50 -XX:+AlwaysPreTouch"

# Make sure this matches the Fabric version of the server if you update:
FABRIC_VERSION="fabric-0.10.2"
FABRIC_LOADER_VERSION="0.12.12"
MC_VERSION="1.18.1"

# Install Minecraft Fabric if it isn't already installed.
FILE=./${FABRIC_VERSION}-${FABRIC_LOADER_VERSION}.jar
if [ ! -f "${FILE}" ]; then
	echo "Installing Minecraft Fabric Server."
    java -jar ./${FABRIC_VERSION}-installer.jar server -mcversion ${MC_VERSION} -loader ${FABRIC_LOADER_VERSION} -downloadMinecraft
fi
MC_FILE=./${MC_VERSION}.jar
if [ ! -f "${MC_FILE}" ]; then
    mv server.jar minecraft_server.${MC_VERSION}.jar
fi
FABRIC_FILE=./${FABRIC_VERSION}-${FABRIC_LOADER_VERSION}.jar
if [ ! -f "${FABRIC_FILE}" ]; then
    mv fabric-server-launch.jar ${FABRIC_VERSION}-${FABRIC_LOADER_VERSION}.jar
fi

# Delete installer file.
INSTALLER_FILE=./${FABRIC_VERSION}-installer.jar
if [ -f "${INSTALLER_FILE}" ]; then
    if [ -f "${FILE}" ]; then
        echo "Deleting the installer file."
        rm ${FABRIC_VERSION}-installer.jar
    fi    
fi

# Start server.
echo "Starting Valhelsia Enhanced Vanilla Server."
java -jar -Xms${ALLOCATED_RAM} -Xmx${ALLOCATED_RAM} ${JVM_ARGUMENTS} ${FILE} nogui

read -p "Press enter to continue."