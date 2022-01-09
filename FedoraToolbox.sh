#!/bin/bash

echo "Welcome to Fedora Toolbox please select an option"

updateSystem() {
  echo "Updating packages"

  sudo yum update

  flatpak update
}

cleanupSystem() {
  echo "Cleaning up Fedora"

  sudo yum erase
  sudo yum clean all

  flatpak uninstall --unused --delete-data
}

upgradeSystem() {
  echo "Upgrading to the latest Fedora version"
}

malwareScan() {
  echo "Running chkrootkit package"

  sudo yum install chkrootkit

  sudo chkrootkit
}

killGraphicalEnviroment() {
  echo "Killing Gnome Shell Session"

  killall -3 gnome-shell
}

resetDisplayManager() {
  echo "Restarting the Display Manager"

  sudo systemctl restart gdm
}

resetNetworking() {
  echo "Restarting the networking service"

#  sudo systemctl restart networking NEED TO WORK OUT WHAT SERVICE TO RESTART
}

rpmRecovery() {
  echo "Attempting to recover rpm..." #Need to work out basic recovery script

#Need the rpm version of this

  #sudo dpkg --configure -a
  #sudo apt update
  #sudo apt install --fix-broken
  #sudo apt install --fix-missing
}

flatpakRepair() {
  echo "Attempting to repair flatpak..."

  flatpak repair
}

startupServices() {
  echo "Displaying CRITICAL chain of on boot starup services"

  sudo systemd-analyze critical-chain

  echo "Use:"
  echo "systemctl enable/disable <service>"
  echo "To enable/disable services as daemons"
}

installRpmPackage() {
  echo "Install an rpm package"
  read -p "Enter package name to install: " package

  sudo yum install ${package}
}

removeRpmPackage() {
  echo "Remove an rpm package"
  read -p "Enter package name to remove: " package

  sudo yum remove ${package}
}

findInstalledRpmPackage() {
  echo "Find an installed rpm package"
  read -p "Enter search query: " searchQuery

  yum list --installed | grep ${searchQuery} --ignore-case --color=auto #Doesn't work
}

findRemoteRpmPackage() {
  echo "Find an installed apt package"
  read -p "Enter search query: " searchQuery

  rpm list | grep ${searchQuery} --ignore-case --color=auto #Doesn't work
}

listAllInstalledRpmPackages() {
  echo "Listing all installed apt packages"

  rpm list --installed #Doesn't work
}

listAllRemoteRpmPackages() {
  echo "Listing all remote apt packages"

  rpm list | more #Doesn't work
}

installFlatpakPackage() {
  echo "Install a flatpak package"
  read -p "Enter package name to install: " package

  flatpak install ${package}
}

uninstallFlatpakPackage() {
  echo "Uninstall a flatpak package"
  read -p "Enter package name to install: " package

  flatpak uninstall ${package}
}

findInstalledFlatpakPackage() {
  echo "Find an installed flatpak package"
  read -p "Enter search query: " searchQuery

  flatpak list | grep ${searchQuery} --ignore-case --color=auto
}

findRemoteFlatpakPackage() {
  echo "Find an installed flatpak package"
  read -p "Enter search query: " searchQuery

  flatpak remote-ls | grep ${searchQuery} --ignore-case --color=auto
}

listAllInstalledFlatpakPackages() {
  echo "Listing installed flatpak packages"

  flatpak list
}

listAllRemoteFlatpakPackages() {
  echo "Listing all remote flatpak packages"

  flatpak remote-ls | more
}

systemManagement() {
  local PS3='Please enter your choice: '
  local options=("Back" "Fedora Update System" "Fedora Cleanup System" "Fedora Upgrade To The Next OS Version (WIP)" "Run Malware Scan")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Fedora Update System")
      updateSystem
      ;;
    "Fedora Cleanup System")
      cleanupSystem
      ;;
    "Fedora Upgrade To The Next OS Version (WIP)")
      upgradeSystem
      ;;
    "Run Malware Scan")
      malwareScan
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

rpmQuery() {
  local PS3='Please enter your choice: '
  local options=("Back" "Install An rpm Package" "Remove An rpm Package" "Find Installed rpm Package (WIP)" "Search For Remote rpm Package (WIP)" "List All Installed rpm Packages (WIP)" "List All Remote rpm Packages (WIP)")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Install An rpm Package")
      installRpmPackage
      ;;
    "Remove An rpm Package")
      removeRpmPackage
      ;;
    "Find Installed rpm Package (WIP)")
      findInstalledAptPackage
      ;;
    "Search For Remote rpm Package (WIP)")
      findRemoteRpmPackage
      ;;
    "List All Installed rpm Packages (WIP)")
      listAllInstalledRpmPackages
      ;;
    "List All Remote rpm Packages (WIP)")
      listAllRemoteRpmPackages
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

flatpakQuery() {
  local PS3='Please enter your choice: '
  local options=("Back" "Install A Flatpak Package" "Uninstall A Flatpak Package" "Find Installed Flatpak Package" "Search For Remote Flatpak Package" "List All Installed Flatpak Packages" "List All Remote Flatpak Packages")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Install A Flatpak Package")
      installFlatpakPackage
      ;;
    "Uninstall A Flatpak Package")
      uninstallFlatpakPackage
      ;;
    "Find Installed Flatpak Package")
      findInstalledFlatpakPackage
      ;;
    "Search For Remote Flatpak Package")
      findRemoteFlatpakPackage
      ;;
    "List All Installed Flatpak Packages")
      listAllInstalledFlatpakPackages
      ;;
    "List All Remote Flatpak Packages")
      listAllRemoteFlatpakPackages
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

packageQuery() {
  local PS3='Please enter your choice: '
  local options=("Back" "rpm Package Querying" "Flatpak Package Querying")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "rpm Package Querying")
      rpmQuery
      ;;
    "Flatpak Package Querying")
      flatpakQuery
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

performance() {
  local PS3='Please enter your choice: '
  local options=("Back" "Check On Boot Startup Services")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Check On Boot Startup Services")
      startupServices
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

systemRecovery() {
  local PS3='Please enter your choice: '
  local options=("Back" "Kill Graphical Enviroment" "Hard Reset Of Display Manager" "Reset Networking (WIP)" "rpm Recovery (WIP)" "Flatpak Repair")
  local opt
  select opt in "${options[@]}"; do
    case $opt in
    "Back")
      return
      ;;
    "Kill Graphical Enviroment")
      killGraphicalEnviroment
      ;;
    "Hard Reset Of Display Manager")
      resetDisplayManager
      ;;
    "Reset Networking (WIP)")
      resetNetworking
      ;;
    "rpm Recovery (WIP)")
      rpmRecovery
      ;;
    "Flatpak Repair")
      flatpakRepair
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

main() {
  PS3='Please enter your choice: '
  options=("Quit" "Fedora Management" "Fedora Package Query" "Fedora Performance" "Fedora Recovery")
  select opt in "${options[@]}"; do
    case $opt in
    "Quit")
      break
      ;;
    "Fedora Management")
      systemManagement
      ;;
    "Fedora Package Query")
      packageQuery
      ;;
    "Fedora Performance")
      performance
      ;;
    "Fedora Recovery")
      systemRecovery
      ;;
    *) echo "invalid option $REPLY" ;;
    esac
  done
}

main
