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

## References

- https://neverthenetwork.com/notes/udpknock