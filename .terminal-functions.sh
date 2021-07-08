# Printers scripts
# --- Reference: https://linuxcommand.org/lc3_adv_tput.php
function header() {
  printf " $(tput sgr 0 1)$(tput setaf 6)$(tput bold)$1$(tput sgr0)\n"
}

function log() {
  printf " \xE2\x9C\x94 $(tput setaf 2)$(tput bold)$1$(tput sgr0)\n"
}

function error() {
  printf " x $(tput setaf 1)$(tput bold)$1$(tput sgr0)\n"
}

# Heroku CLI scripts
deployAndReleaseHerokuContainer() {
    # $1 = heroku app name
    # $2 = heroku dyno type
    heroku container:push --recursive --app $1 && heroku container:release $2 --app $1

    echo "Your app is now available in https://$1.herokuapp.com"
}

checkHerokuAppLogs() {
    # $1 = heroku app name
    heroku logs --tail --app $1
}

# git branch script
function createBranchWording() {
  # $2 = Branch wording
  title=$(echo $2 | tr " " -)

  echo $(log "Your branch could be ->" && header "\"$1-$title\"")
}

function setYourGithubUsernameCredentials() {
   git config --local user.name "Your name"
   git config --local user.email "your@email.com"
}

# command to get commits with whole information otherwise only hashes given a number from
getLastCommitsHash() {
    if [ $1 = 'yes' ]; then
        git log -n $2 | grep commit
    elif [ $1 = 'no-stat' ]; then
	git log -n $2 --stat
    else
        git log -n $2
    fi
}

# docker exec
dockerInside() {
    # $1 = container name
    # $2 = bash | sh
    docker exec -it $1 $2
}

# SSH scripts
function checkSSHKeyAvailable() {
    ls -l ~/.ssh/
}

function addSSHKey() {
  # $1 = SSH Key filename
  # For Linux
  #ssh-add ~/.ssh/$1

  # For Mac
  #ssh-add -K ~/.ssh/$1
}

# Droidcam installation
function installDroidcam() {
    _PWD="$(pwd)"
    header "Changing to /tmp/ directory..."
    cd /tmp/
    log "Placed in /tmp/"

    header "Downloading droidcam..."
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.3.zip
    log "Droidcam downloaded!"

    header "Unzipping Droidcam..."
    unzip droidcam_latest.zip -d droidcam
    log "Droidcam unzipped"

    header "Changing to droidcam/ directory..."
    cd droidcam
    log "Placed in droidcam/"

    header "Installing Droidcam..."
    sudo ./install-video
    log "Droidcam installed"
    cd $_PWD
}

# Teamviewer reset
function resetTeamViewer() {
    _PWD="$(pwd)"
    cd ~
    # For Linux
    # sudo ./reset_teamviewer.sh
    
    # For mac
    #sudo reset_teamviewer_macos.py
    cd $_PWD
}