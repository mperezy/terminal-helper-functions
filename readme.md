# Terminal Helper Functions

## How to use

- We need to import these functions in our `~/.bashrc` file, but first let's copy the `.terminal-functions.sh` and `reset_teamviewer.sh` files in user home directory `~`.

- After te first step, we must change the permissions of both files:
    ```
    $ sudo chmod 777 .terminal-functions.sh reset_teamviewer.sh
    ```

- We're almost done, given the first step, we must to import the functions into our `~/.bashrc` file inserting the next as follows:
    ```
    . ~/.terminal-functions.sh
    ```

# GoPro Webcam Service
- I bought a GoPro action camera and I use it as a webcam in Linux, so in order to use it I followed this [Github repo](https://github.com/jschmid1/gopro_as_webcam_on_linux). JIC: This repo only works with GoPro Hero 8 and Hero 9.

- The commands added for this GoPro webcam are: **`goProWebcamService`** and **`editGoProWebcamService`**.

- Now we must reset or open a new terminal and we're done. Enjoy!

## Examples about how to use some scripts

- 
<img src="./.img/img1.png" width=80%>

-
<img src="./.img/img2.png" width=80%>

-
<img src="./.img/img3.png" width=80%>