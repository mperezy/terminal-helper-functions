# Printers scripts
# --- Reference: https://linuxcommand.org/lc3_adv_tput.php
header() {
  printf " $(tput sgr 0 1)$(tput setaf 6)$(tput bold)$1$(tput sgr0)\n"
}

greenLog() {
  printf " \xE2\x9C\x94 $(tput setaf 2)$(tput bold)$1$(tput sgr0)\n"
}

yellowLog() {
  printf "$(tput setaf 3)$(tput bold)$1$(tput sgr0)"
}

error() {
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
createBranchWording() {
  # $2 = Branch wording
  title=$(echo $2 | tr " " -)

  echo $(greenLog "Your branch could be ->" && header "\"$1-$title\"")
}

setYourGithubUsernameCredentials() {
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

# get head hash commit given a git repository
getHeadHashCommit() {
  echo "$(greenLog "The HEAD commit hash is =>")$(header $(getLastCommitsHash yes 1 | cut -d' ' -f 2 | cut -c-7))"
}

# docker exec
dockerInside() {
    # $1 = container name
    # $2 = bash | sh
    docker exec -it $1 $2
}

# SSH scripts
checkSSHKeyAvailable() {
    ls -l ~/.ssh/
}

addSSHKey() {
  # $1 = SSH Key filename

  if [ "$(uname)" = "Darwin" ]; then
    ssh-add -K ~/.ssh/$1
  else
    ssh-add ~/.ssh/$1
  fi
}

# Droidcam installation
installDroidcam() {
    _PWD="$(pwd)"
    header "Changing to /tmp/ directory..."
    cd /tmp/
    greenLog "Placed in /tmp/"

    header "Downloading droidcam..."
    wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.3.zip
    greenLog "Droidcam downloaded!"

    header "Unzipping Droidcam..."
    unzip droidcam_latest.zip -d droidcam
    greenLog "Droidcam unzipped"

    header "Changing to droidcam/ directory..."
    cd droidcam
    greenLog "Placed in droidcam/"

    header "Installing Droidcam..."
    sudo ./install-video
    greenLog "Droidcam installed"
    cd $_PWD
}

# Teamviewer reset
resetTeamViewer() {
    _PWD="$(pwd)"
    cd ~

    if [ "$(uname)" = "Darwin" ]; then
      sudo reset_teamviewer_macos.py
    else
      sudo ./reset_teamviewer.sh
    fi

    cd $_PWD
}

# Restart internet interfaces
restartInternet() {
  greenLog "Restarting internet interfaces..."
   sudo ifdown -a && sudo ifup -a
}

# GoPro service actions
goProWebcamService() {
  # $1 = status or restart

  whitelist=("enable-gopro", "disable-gopro", "start-stream", "stop-stream")

  if [[ " ${whitelist[@]} " =~ $1 ]]; then
    gopro_interface=$(ifconfig | grep enx | sed 's/:.*//')
    gopro_ip=$(ip -4 addr show dev $gopro_interface | grep -Po '(?<=inet )[\d.]+')
    gopro_internal_ip=$(echo $gopro_ip | awk -F"." '{print $1"."$2"."$3".51"}')
  fi

  if [ -z $1 ]; then
    greenLog "status | restart | start | stop: $(yellowLog "make some action in gopro service.")"
    greenLog "check-trail: $(yellowLog "to check service's log trail.")"
    greenLog "start-stream | stop-stream: $(yellowLog "to start/stop the GoPro expose to O.S.")"
    greenLog "disable-gopro | enable-gopro: $(yellowLog "to enabe/disable gopro webcam mode. Use 'goProWebcamService start' if the gopro_webcam is already started.")"
    greenLog "h: $(yellowLog "dispay options.")"
  else
    if [ $1 = "h" ]; then
      greenLog "status | restart | start | stop: $(yellowLog "make some action in gopro service.")"
      greenLog "check-trail: $(yellowLog "to check service's log trail.")"
      greenLog "start-stream | stop-stream: $(yellowLog "to start/stop the GoPro expose to O.S.")"
      greenLog "disable-gopro | enable-gopro: $(yellowLog "to enabe/disable gopro webcam mode. Use 'goProWebcamService start' if the gopro_webcam is already started.")"
      greenLog "h: $(yellowLog "dispay options.")"
    else
      if [ "$(uname)" = 'Darwin' ]; then
        error "This will works only in Linux"
      else
        if [ $1 = "check-trail" ]; then
          sudo journalctl -u gopro_webcam -f
        else
          if [ $1 = "start-stream" ]; then
            goProWebcamService start
          else
            if [ $1 = "stop-stream" ]; then
              # To stop v4l2loopback
              # lsmod | grep v4l2loopback
              # sudo systemctl stop gopro_webcam.service
              # sudo modprobe -r v4l2loopback v4l2loopback

              goProWebcamService stop
              sudo modprobe -r v4l2loopback v4l2loopback
              curl http://$gopro_internal_ip/gp/gpWebcam/STOP
            else
              if [ $1 = "enable-gopro" ]; then
                curl http://$gopro_internal_ip/gp/gpWebcam/START
              else
                if [ $1 = "disable-gopro" ]; then
                  curl http://$gopro_internal_ip/gp/gpWebcam/STOP
                else
                  sudo systemctl $1 gopro_webcam.service
                  greenLog "I've finished!!"
                fi
              fi
            fi
          fi
        fi
      fi
    fi
  fi
}

# Edit GoPro service file
editGoProWebcamService() {
  greenLog "Openning nano editor"

  sudo nano /etc/systemd/system/gopro_webcam.service
}
