# Make Ubuntu Great Again

### Description
This script is designed to enhance your Ubuntu experience by removing Snap packages and Snapd, installing Flatpak, and setting up Firefox and Thunderbird according to Mozilla's guidelines.

## Features
- Removes Snap packages and Snapd
- Installs Flatpak and adds the Flathub repository
- Installs Gnome Software
- Downloads and installs the latest versions of Firefox and Thunderbird
- Creates desktop entries for Firefox and Thunderbird

## Prerequisites
- You must have `sudo` privileges to run this script.
- The script is intended for Ubuntu-based distributions.

## Usage
You can run the script directly from the command line using `curl`. Open a terminal and execute the following command:

```bash
curl -sSL https://raw.githubusercontent.com/GNU-Alex/firefox-installer-ubuntu/main/firefox-installer.sh | sudo bash
```

## Important Notes

  - This script will remove Snap packages and Snapd from your system. Make sure you do not need any Snap applications before running it.
  - After the script completes, it is recommended to restart your system to apply all changes.

## License

This project is licensed under the GNU General Public License (GPL) v3. See the LICENSE file for details.
Acknowledgments

  - Thanks to Mozilla for providing the latest versions of Firefox and Thunderbird.
  - Thanks to the Flatpak community for their contributions.

Contact

For any questions or issues, please contact the author at [pop.alex.rs@proton.me].
