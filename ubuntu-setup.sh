#!/bin/bash

# Request root priveleges
echo "Requesting root privileges... "

if [ $(sudo whoami) != "root" ]; then
    echo "ERROR: This script requires root priveleges to run"
    exit
fi

# Import resources
source ./resources/functions.sh

# Set some default variables
APT_UPDATE=false
SYSTEM_UPDATE=false

INSTALL_SYSTEM_EXTRAS=false
INSTALL_DEV_TOOLS=false
INSTALL_DESIGN_TOOLS=false
INSTALL_MEDIA_TOOLS=false
INSTALL_SEC_TOOLS=false
INSTALL_COM_TOOLS=true
INSATLL_SUN_JAVA=false
  REMOVE_OPENJDK=false
INSTALL_DROPBOX=false
  DROPBOX_ICONS=false
INSTALL_WEB_SERVER=false


# ==============================================================================
# Prompt to install everything at once
# ==============================================================================

INSTALL_ALL=false

echo ""
echo -n "Install everything? (y/n) [n] "
read YN

if [ "${YN}" == "n" ] || [ "${YN}" == "" ]; then
    INSTALL_ALL=false
else
    INSTALL_ALL=true
fi


# ==============================================================================
# If $INSTALL_ALL is false then prompt for each action
# ==============================================================================

CONTINUE=false

if [ $INSTALL_ALL == false ]; then
    while [ $CONTINUE == false ]; do
    
        # ==================================================
        # Prompt for each action to be performed
        # ==================================================

        # Perform system update?
        echo ""
        echo -n "Perform system update? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            APT_UPDATE=true
            SYSTEM_UPDATE=true
        fi
        
        # Install system extras?
        echo ""
        echo -n "Install system extras? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_SYSTEM_EXTRAS=true
        fi
         
        # Install developer tools?
        echo ""
        echo -n "Install developer tools? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_DEV_TOOLS=true
        fi
        
        # Install design tools?
        echo ""
        echo -n "Install design tools? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_DESIGN_TOOLS=true
        fi
        
        # Install media tools?
        echo ""
        echo -n "Install media tools? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_MEDIA_TOOLS=true
        fi
        
        # Install security tools?
        echo ""
        echo -n "Install security tools? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_SEC_TOOLS=true
        fi
         
        # Install communication tools?
        echo ""
        echo -n "Install communication tools? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_COM_TOOLS=true
        fi
         
        # Install Sun Java?
        echo ""
        echo -n "Install Sun Java? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSATLL_SUN_JAVA=true

            echo -n "  Remove OpenJDK? (y/n) [y] "
            read YN

            if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
                REMOVE_OPENJDK=true
            fi
        fi
          
        # Install Dropbox?
        echo ""
        echo -n "Install Dropbox? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            INSTALL_DROPBOX=true
            
            echo -n "  Install custom Dropbox icons? (y/n) [y] "
            read YN

            if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
                DROPBOX_ICONS=true
            fi
        fi
         
        # Install local web server?
        echo ""
        echo -n "Install local web server? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ]; then
            INSTALL_WEB_SERVER=true
        fi


        # ==================================================
        # Confirm all actions to be performed
        # ==================================================
        echo ""
        echo "The following actions will be performed:"
        echo ""

        if [ $SYSTEM_UPDATE == true ]; then
            echo "  -> System updates will be applied"
        fi
        
        if [ $INSTALL_SYSTEM_EXTRAS == true ]; then
            echo "  -> System extras will be installed"
        fi
        
        if [ $INSTALL_DEV_TOOLS == true ]; then
            echo "  -> Developer tools will be installed"
        fi
        
        if [ $INSTALL_DESIGN_TOOLS == true ]; then
            echo "  -> Design tools will be installed"
        fi
        
        if [ $INSTALL_MEDIA_TOOLS == true ]; then
            echo "  -> Media tools will be installed"
        fi
        
        if [ $INSTALL_SEC_TOOLS == true ]; then
            echo "  -> Security tools will be installed"
        fi
        
        if [ $INSTALL_COM_TOOLS == true ]; then
            echo "  -> Communication tools will be installed"
        fi
        
        if [ $INSATLL_SUN_JAVA == true ]; then
            echo "  -> Sun Java will be installed"
        fi
        
            if [ $REMOVE_OPENJDK == true ]; then
                echo "      -> OpenJDK will be removed"
            fi
            
        if [ $INSTALL_DROPBOX == true ]; then
            echo "  -> Dropbox will be installed"
        fi
        
            if [ $DROPBOX_ICONS == true ]; then
                echo "      -> Custom Dropbox icons will be installed"
            fi
        
        if [ $INSTALL_WEB_SERVER == true ]; then
            echo "  -> Local web server will be installed"
        fi
        
        echo ""
        echo -n "Do you wish to proceed with these actions? (y/n) [y] "
        read YN
        
        if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
            CONTINUE=true
        else
            # Reset variables
            APT_UPDATE=false
            SYSTEM_UPDATE=false
            
            INSTALL_SYSTEM_EXTRAS=false
            INSTALL_DEV_TOOLS=false
            INSTALL_DESIGN_TOOLS=false
            INSTALL_MEDIA_TOOLS=false
            INSTALL_SEC_TOOLS=false
            INSTALL_COM_TOOLS=true
            INSATLL_SUN_JAVA=false
              REMOVE_OPENJDK=false
            INSTALL_DROPBOX=false
              DROPBOX_ICONS=false
            INSTALL_WEB_SERVER=false
        fi
    
    done
fi
    

# ==============================================================================
# Process the actions
# ==============================================================================

# if [ $APT_UPDATE == true ]; then
#     sudo apt-get update
# fi

if [ $SYSTEM_UPDATE == true ] || [ $INSTALL_ALL == true ]; then
    systemUpdate
fi


# ==============================================================================
# Prompt user for system cleanup
# ==============================================================================

echo ""
echo -n "Perform system cleanup now? (y/n) [y] "
read YN

if [ "${YN}" == "y" ] || [ "${YN}" == "" ]; then
    systemCleanup
fi


# ==============================================================================
# Show exit message
# ==============================================================================

echo ""
echo "All actions completed successfully. Exiting script now."

exit
