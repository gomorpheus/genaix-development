# genaix-development

Genaix is a set of projects to develop Gen AI projects. This repo shows you how to get setup for development.

## Prerequisites

Setup Ollama on a "bare metal" host with native HW GPU's. One good example of this is your HPE issued Macbook Pro M1.
 - Visit https://ollama.com and see how to do this.
 - On your host, create a file to initialize Ollama. This is needed because out of the box, Ollama is configured to only listen on ```http://localhost```. The initialization consists of reconfiguring it to listen on all network interfaces instead. For a Mac, this script is:
 ```
 #!/bin/bash
set -e
# Make sure the Ollama server listens on all local addresses.
launchctl setenv OLLAMA_HOST "0.0.0.0"
launchctl setenv OLLAMA_FLASH_ATTENTION "true"
# MacOS osacript to stop Ollama (so it can pick up the above change).
osascript -e 'tell app "Ollama" to quit'
# MacOS osacript to start Ollama (so it starts with the above change).
osascript -e 'tell application "Ollama" to activate'
 ```

**Note***: Sometimes, when your Mac restarts, or when Ollama is updated, you need to re-run this script.

## Development system

Genaix development is performed on Linux. Typically, you'd setup a Linux VM to develop Genaix apps. If this is true for you, setup a Linux VM using your favourite Hypervisor, such as Parallels or VMWare Fusion/Workstation. The simplest way to do this is:

### Install a development VM

 - Download the Ubuntu 24.04 ISO: If you're targeting a Mac Hypervisor, you need the ARM64 build of the ISO. Download the Ubuntu 24.04 sserver ISO for ARM by visiting https://ubuntu.com/download/server/arm and downloading the 24.0.4.2 LTS version.
 - Create a Linux VM using the Server ISO with 2 CPU's, 16GB of RAM, a "shared" network adaptor and optionally, a bridged network adaptor.
 - Once the server VM is ready, login to it and perform the following steps:
  - ```sudo apt update && sudo apt upgrade -y```
  - If you're using VMWare Fusion or Workstation, install the VMWare tools packages: ```sudo apt install - y open-vm-tools*```
  - ```sudo apt install ubuntu-desktop-minimal```
  - ```sudo apt update && sudo apt upgrade -y```
  - ```sudo apt -y autoremove```
  - Restart your VM using ```sudo shutdown -r now```

### Setup the development VM

Install some tools and packages on your new VM:
 - Create a ```~/bin``` directory and add it to your PATH in your ```~/.bashrc``` file:
 ```
 PATH=~/bin:PATH
  ```
  and source the file: ```. ~/.bashrc```
 - Copy the files under ```script``` to your ```~/bin``` directory and run ```./install-dev.sh```
 - Restart your VM.

### Test the VM

 - Try running ```docker run hello-world``` and check the output to make sure everything looks good.
 - Try running ```curl <your-host-IP>:11434```. This should return ```Ollama is running```. **Notes** The "host-IP" in this command is an IP address for the underlying host (e.g. your Mac), not your development VM!

As a convenience, consider adding these aliases to your ```~/.bashrc``` file to save yourself some typing during python development in the genaix projects:
```
alias sa="source ./activate.sh"
alias da="deactivate"
alias sac="rm -rf dev3.11 && source ./activate.sh"
alias dac="deactivate && rm -rf dev3.11"
```
and source the ```~/.bashrc``` file.

# Clone the genaix projects.

Choose a base development directory for your genaix workspaces, e.g. ```./dev```. Change to this directory and clone these genaix projects:

```
git clone git@github.com:gomorpheus/genaix.git genaix
git clone git@github.com:gomorpheus/genaix-services.git genaix-services
git clone git@github.com:gomorpheus/genaix-slacklistener.git genaix-slacklistener
git clone git@github.com:gomorpheus/genaix-chatbot.git genaix-chatbot
git clone git@github.com:gomorpheus/genaix-tools.git genaix-tools
```

## Repositories

 - genaix: A common base project for the other repositories.
 - genaix-services: A project with several containerized modules which serve as "helpers" for many Gen AI functions.
 - genaix-slacklistener: The project for the Morpheus Slack bot.
 - genaix-chatbot: The project for the Morpheus chatbot (Edge installation).
 - genaix-tools: A project containing tools and scripts, serving as a development playground for specialized generative AI tasks like source-code documentation generation, etc..
