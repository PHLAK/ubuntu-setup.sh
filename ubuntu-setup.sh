#!/bin/bash

# Request root priveleges

echo "Requesting root privileges... "

if [ $(sudo whoami) != "root" ]; then
    echo "ERROR: This script requires root priveleges to run"
    exit
fi


# Import resources

source ./resources/functions.sh


# Set some default variables.

CONFIRM=false
APTUPDATE=false
SYSUPGRADE=false


# ==============================================================================
# Prompt to install everything
# ==============================================================================

INSTALLALL=false

echo ""
echo -n "Install everything? (y/n) [n] "
read YN

if [ "${YN}" == "n" ]; then
    INSTALLALL=false
else
    INSTALLALL=true
fi


# ==============================================================================
# If $INSTALLALL is false then prompt for each action
# ==============================================================================

if [ $INSTALLALL == false ]; then
    while [ $CONFIRM == false ]; do

        # Prompt for each action to be performed

        echo ""
        echo -n "Install system updates? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ]; then
            APTUPDATE=true
            SYSUPGRADE=true
        fi


        # Confirm all actions to be performed
        
        echo ""
        echo "The following actions will be performed:"
        echo ""

        if [ $SYSUPGRADE == true ]; then
            echo "  -> System updates will be applied"
        fi
        
        echo ""
        echo -n "Do you wish to proceed with these actions? (y/n) "
        read YN
        
        if [ "${YN}" == "y" ]; then
            CONFIRM=true
        fi
    
    done
fi
    

# ==============================================================================
# Process the actions
# ==============================================================================

# if [ $APTUPDATE == true ]; then
#     sudo apt-get update
# fi

if [ $SYSUPGRADE == true ] || [ $INSTALLALL == true ]; then
    systemUpgrade
fi


# ==============================================================================
# Prompt user for system cleanup
# ==============================================================================

echo ""
echo -n "Perform system cleanup now? (y/n) [y] "
read YN

if [ $YN == "y" ]; then
    systemCleanup
fi

# ==============================================================================
# Show exit message
# ==============================================================================

echo ""
echo "All actions completed successfully. Exiting script now."

exit




