# To Do
 - Store configurations in a serialized format (json)
 - Menu states can also be stored as json to make menus easier to generate, instead of passing an array of strings we can simply pass the state object

## Install Environment
 - Check for network conection, if not, connect with iwctl. If no wireless interface, display a prompt telling user to connect ethernet and exit.
 - Check for a Go installation, if not, set up and install go, tidy and build the program, then run it
 - Ask user if they want to partition disk. If yes, give them recommended partition layout and enter into fdisk. Remeber the disk they selected to partition for use in the next step
 - Ask user if they want to format partitions. List partitions and display in a tui menu for them to select. Upon selection, use the partition in another menu to select format. Since this is opinionated we can likely ask which drives to use for root, efi, and swap, and give the option for /home
 - Prompt user to select which partitions to mount to which location. Perhaps include an option here to decide whether or not to format.
 - Rank the mirrors
 - Pacstrap the initial install
 - Add the T2 repo to the pacman config
 - Install other essential files
 - Generate the fstab, echo to the user and confirm it looks correct
 - arch chroot into the install
 - set the clock, using bubbletea to generate a menu of Regions and then Cities. Set the hw clock. Allow the user to decide whether to use UTC or localtime
 - Generate the locales, auto-edit /etc/locale.gen, create locale.conf
 - Prompt the user to set a hostname
 - Set the root password
 - Create a user account, ask the user if they want to enable sudo
 - Enable the system fan daemon
 - Install grub
 - Exit the chroot, unmount disks, prompt user to press enter to reboot, log in to their USER account (with sudo access), and re-run the program

 ## Post Install
 - Check for network conection, if not, connect with nmcli. If no wireless interface, display a prompt telling user to connect ethernet and exit.
 - Check for a Go installation, if not, set up and install go, tidy and build the program, then run it
 - Check for T2 install
 - AUR helper
 - Desktop Environment - launch and re-run?
 - Essential tools
    - Thunderbolt
 - Dotfiles
