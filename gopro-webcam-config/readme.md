# Gopro as a Webcam in Linux

## Installation

- For installation, go to this [Github repo](https://github.com/jschmid1/gopro_as_webcam_on_linux#installation) and executed the command required to proceed.

- First let's modify a little bit the gopro program in order to use the GoPro in
OBS with a Webcam plugin:
    
    - Install the v4l2loopback [module](https://github.com/CatxFish/obs-v4l2sink) (If it's not already installed).
    
    - Install the obs-v4l2sink [plugin](https://github.com/CatxFish/obs-v4l2sink). This is a [video](https://youtu.be/Eca509IDLdM?t=283) to check how to use the OBS plugin.

    - Now let's edit the gopro program in order to create a v4l2 device for the gopro and the OBS Webcam. Place yourself in this path **`/usr/local/sbin/gopro`** and edit it with sudo permissions:

    ```bash
    ...
    module_cmd="modprobe v4l2loopback video_nr=42,43 card_label=\"GoPro,OBS Camera\"  "
    ...
    ```

- In order to start the gopro program as a service, follow [this step](https://github.com/jschmid1/gopro_as_webcam_on_linux#installation).

- Now replace the content of the gopro_webcam.service file with the content of the file of this repo [file](gopro_webcam.service) which has some specific parameters for my GoPro Hero 9 Black.

- And that's it!. Please follow the command **`goProWebcamService`** for how to use it.

## Blur background (OBS)

- Once NVIDIA Broadcast was released, I turned in a big fan of the blurred background, so in this section, I'm going to document the steps I followed to get a blurred background look-alike NVIDIA Broadcast, not so accurate but much better than Linux's Zoom does.

### obs-backgroundremoval plugin

- Official Github repository [here](https://github.com/royshil/obs-backgroundremoval).
- This plugin was kind of hard to get installed in Ubuntu 20.04 (version that I'm currently using), so let's follow the next.

- I had installed OBS from ppa repository, but I found an issue thread from the repo posted above, mentioning that it's much better tu use **`pacstall`** to make really easy the installation (to install pacstall follow [this repo](https://github.com/pacstall/pacstall)), but the guy who mentioned this plugin won't be able to be use it in a OBS installed from a ppa repository so I had to uninstall it doing the next:

```bash
$ sudo apt remove obs-studio --auto-remove # to remove the current OBS
$ sudo add-apt-repository ppa:obsproject/obs-studio -r # to remove the ppa repository
$ sudo apt update && sudo apt install obs-studio # to install OBS from Ubuntu repo
```
- Once I have the OBS from Ubuntu's repo, I was able to install the plugin from `pacstall`

```bash
$ pacstall -I obs-backgroundremoval-git # to install the latest version from repo
```

- Now we have `obs-backgroundremoval` plugin installed.

### StreamFX plugin

- Official Github repository [here](https://github.com/xaymar/obs-streamfx/wiki/Installation#manual-installation-).

- To get the blurred background, we must need this plugin unless there exists another plugin, but this works so good.

- The installation is really easy, but given I installed OBS from Ubuntu's repo, this installed `OBS v25.0.3` and the latest version of `StreamFX` requires `OBS v27.x.x`, so we must install `StreamFX v0.10.1`.

- In future releases of Ubuntu, OBS will be updated to the latest version so will be able to update StreamFX to the latest version.

### Usage

- In order to get the blurred background I have to create two gopro sources, the first one to apply the blur backgroun on all the video capture and finally in the second one apply the background removal plugin and a chroma key effect, that's all.

- Additionally I added an 16:9 image with a black border and applied the blur effect.

- In my setup, the priority of the sources will:

    1. Black border blurred (optional).
    2. A gopro video capture with blur background effect and chroma key to completely delete the background.
    3. A second gopro video capture with background removed and applied chrome key image effect.

### Results

<img src="https://user-images.githubusercontent.com/29245884/137222085-6d0e595c-cec1-418c-8f3d-5ad44a52c149.png" width=80% />

The effects combined looks quite close as NVIDIA Broadcast.

## References

- GoPro REST API: https://neverthenetwork.com/notes/udpknock
- Github issue thread from obs-backgroundremoval: https://github.com/royshil/obs-backgroundremoval/issues/34#issuecomment-942689271