# ==============================================================================
# Variables
# ==============================================================================

RESOURCES=./resources
APTSOURCES=/etc/apt/sources.list.d


# ==============================================================================
# Functions
# ==============================================================================

systemUpdate() {
    sudo apt-get update
    sudo apt-get -y upgrade
    sudo apt-get -y dist-upgrade
}

systemCleanup() {
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean
}

installWebServer() {
    # Install LAMP server and PHPMyAdmin
    sudo apt-get -y install lamp-server^ phpmyadmin
    
    # Fix to allow Apache to serve from home directory
    sudo chmod 771 ~
    
    # Add webmin to the Apt repository
    if [ ! -f $APTSOURCES/webmin.list ]; then
        sudo cp $RESOURCES/webmin.list $APTSOURCES
    fi
    
    wget http://www.webmin.com/jcameron-key.asc -O /tmp/jcameron-key.asc
    apt-key add /tmp/jcameron-key.asc
    
    # Install Webmin
    sudo apt-get update
    sudo apt-get -y install webmin
}

installSystemExtras() {
    sudo add-apt-repository ppa:anton-sudak/indicators
    sudo apt-get update
    sudo apt-get -y install ubuntu-restricted-extras nautilus-open-terminal nautilus-gksu gparted ppa-purge p7zip-full htop powertop bwm-ng openssh-server indicator-cpufreq
}

installDevelopmentTools() {
    sudo apt-get -y install build-essential git
}

installDesignTools() {
    sudo apt-get -y install gimp inkscape nautilus-image-converter
}

installMediaTools() {
    sudo apt-get -y install compizconfig-settings-manager ttf-droid flashplugin-nonfree vlc transcode-utils
}

installSecurityTools() {
    sudo apt-get -y install aircrack-ng kismet
}

installCommunicationTools() {
    sudo apt-get -y install mumble pidgin
}

installSunJava() {
    # Enable Ubuntu partner repository
    if [ ! -f $APTSOURCES/maverick-partner.list ]; then
        sudo cp $RESOURCES/maverick-partner.list $APTSOURCES
    fi
    
    # Install Sun Java
    sudo apt-get update
    sudo apt-get -y install sun-java6-jre sun-java6-plugin
    
    # Remove OpenJDK if user specifies
    if [ $1 == true ]; then
        sudo apt-get -y autoremove openjdk*
    fi    
}

installDropbox() {
    # Add Dropbox to the Apt repository
    if [ ! -f $APTSOURCES/dropbox.list ]; then
        sudo cp $RESOURCES/dropbox.list $APTSOURCES
    fi
    
    sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
    
    # Install Dropbox
    sudo apt-get update
    sudo apt-get -y install nautilus-dropbox
    
    # Add custom icons if specified
    if [ $1 == true ]; then
        # Define icons folder location
        ICONFOLDER=~/.icons/ubuntu-mono-dark/status/22

        # Make icons folder if it doens't exist
        if [ ! -d $ICONFOLDER ]; then
            mkdir -p $ICONFOLDER
        fi
        
        # Copy icons to folder
        cp $RESOURCES/dropbox-icons/* $ICONFOLDER

        # Restart Dropbox
        dropbox stop
        dropbox start  
    fi
}




