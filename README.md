# README
Electricity-saver is self-hosted uptime monitoring tool with ability to switch on/off smart plug via Home Assistant REST API

Why should you should use this project?  
- you want to monitor your network via ping requests
- you want to track the history of your ping requests 
- you want devices in your network switch on/off by cron, e.g. turn on your Starlink internet in specific times
- you want to see, how much electricity your Starlink took for each day
- you want to see changes of turn on / turn off in event log
- you want to schedule on/off events to your smart plug
- you want to schedule automatic start for your Starlink connected in your smart plug
- you want to see history of states of your smart plug device
- you want to login to this app without need of public IP address (reverse tunnel via Pgrok) 

For more info, check [screenshots](https://github.com/Matho/electricity-saver/blob/screenshots/screenshots/screenshots_index.md)


Project is written in Ruby on Rails framework and Docker image is based on Ubuntu. 

**NOTE**: If you want to switch on/off your smart plug, you need to have smart plug compatible with Home Assistant software. Also, you need some version of Raspberry PI, where Home Assistant software and this project will be running. I'm using Raspberry PI 4 with 8GB ram, but 2GB version should be good enough.

## Postgresql development credentials
Development credentials are encrypted. To be able edit the credentials, execute following command from this root of project:  

`$ echo '2ef7e3a8a8aec9a980640a99e5523eb4' >> config/master.key`

Edit ENV for development: 
```
$ EDITOR=vim rails credentials:edit
```

## 1. Start project on localhost in development mode
If you need, you can play with the project on your localhost.   
**NOTE:** You need smart plug and Home Assistant installed to be able switch your smart plug
```
$ rake db:create
$ rake db:schema:load
```

If you want to import some pre-defined data:  
`$ rake db:seed`

Open `http://localhost:3000/users/sign_up` in your browser and fill in registration form. Then change the `confirmed_at` column in the users table - fill it with current time.

Then navigate to `http://localhost:3000/users/sign_in` and login via your password. You should be correctly signed in the app.

## 2. Build Docker image on Raspberry PI
I recommend Raspberry PI 4 with minimum of 2GB ram. 

In config dir rename `secrets.yml.example` to `secrets.yml` and specify your secret value for production

Build the app on the Raspberry PI (provide RAILS_MASTER_KEY env, which is output of config/master.key)  
``` 
$ sudo docker build --build-arg RAILS_ENV=production --build-arg RAILS_MASTER_KEY=2ef7e3a8a8aec9a980640a99e5523eb4 -t mathosk/electricity-saver:latest_aarch64 .
```

## 2.1 Start the app via Docker on Raspberry PI
Allow port for main app, if you need to do it  
`$ sudo ufw allow 8090`

Create docker network  
`$ sudo docker network create electricity-saver-nw`

Specify your postgres password in docker-compose file 

Start the docker-compose via:  (use `-d` for detached state at the end of command)  
`sudo docker-compose -f docker-compose_aarch64.yml up`  
`sudo docker-compose -f docker-compose_aarch64.yml stop`

Optional, if you want to seed some initial data:  
`$ sudo docker-compose -f docker-compose_aarch64.yml run electricity_saver rake db:seed RAILS_ENV=production`

`sudo docker-compose -f docker-compose_aarch64.yml up -d`  

Visit `http://your-ip:8090/users/sign_up` and register yourself. It will generate 5xx error, because email sending is not configured.
If you configure email sending in project, you need to ensure, nobody is possible to login to this tool.

Select container with rails project and copy hash:  
`$ sudo docker container ls -a`  
`$ sudo docker container exec -it be94a012b66a bash`

Execute rails console in rails project  
`$ bundle exec rails c`

Activate your admin user:  
`User.last.update!(confirmed_at: Time.now)`

Logout from docker container and visit `http://your-ip:8090` Sign in via the password you set during registration

## 2.2 First steps after login to electricity-saver
- create your network
- create devices
- create smart plug
- create custom rules
- check if ping works
- check if automat is scheduling the events

## 3. Installation of HA and smart plug

### 3.1 Home Assistant installation
Currently (17.7.2022) the Home Assistant software supports Python v3.9+. Because I was running my existing rpi based on Ubuntu 20.04, I needed
to upgrade system to 22.04 and to upgrade Python to v3.10 package.

I have done steps written in this article [https://www.techrepublic.com/article/how-to-upgrade-ubuntu-server-from-20-04-to-22-04/](https://www.techrepublic.com/article/how-to-upgrade-ubuntu-server-from-20-04-to-22-04/)

Once your Ubuntu is upgraded to 22.04 we can continue with Home Assistant installation.
At first, ensure, you have Docker and Docker-compose already installed. The tutorial how to install
Home Assistant via Docker is at [https://www.home-assistant.io/installation/raspberrypi/#install-home-assistant-container](https://www.home-assistant.io/installation/raspberrypi/#install-home-assistant-container)

`mkdir ~/HA`  
`cd ~/HA`

`vim docker-compose-ha.yml`

Include following:
```
version: '3'
services:
  homeassistant:
    container_name: homeassistant
    image: "ghcr.io/home-assistant/home-assistant:stable"
    volumes:
      - /home/ubuntu/HA:/config
      - /etc/localtime:/etc/localtime:ro
    restart: unless-stopped
    privileged: true
    network_mode: host
```
Start the docker-compose via:  
`sudo docker-compose -f docker-compose-ha.yml up -d`

Restart OS, does it starts after reboot? Navigate in browser to `http://<host>:8123` If you are
using firewall , open 8123 port via `ufw`

We will use wifi-based smart plug, so we do not need to install any Z-wave or Zigbee device integrations.

Now we can continue in installation. Next step is to install [Home Assistant Core](https://www.home-assistant.io/installation/raspberrypi/#install-home-assistant-core)

Detect the Python version. It should be 3.9+ at the time of writing this tutorial. Home Assistant supports 2 latest minor Python releases, check the info of supported Python version by Home Assistant.

```
sudo apt-get update
sudo apt-get upgrade -y
```

Instal the dependencies via:
```
sudo apt-get install -y python3 python3-dev python3-venv python3-pip libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libopenjp2-7 libtiff5 libturbojpeg0-dev tzdata
```

Then create account:
`sudo useradd -rm homeassistant`

Create virtual environment:
```
sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant

sudo -u homeassistant -H -s
cd /srv/homeassistant
python3 -m venv .
source bin/activate

python3 -m pip install wheel
pip3 install homeassistant

hass
```
The hass command could take up to 10 minutes.

The Home Assistant endpoint is available on the `http://your-ip-here:8123`
If you are using firewall, open the port via `sudo ufw allow 8123`
Try reboot, if it auto starts.

#### 3.1.1 Home Assistant settings
Navigate to the profile and generate long-lived token. This token you will use when doing REST queries to Home Assistant REST Api.
Insert the token to `config/settings.yml`

### 3.2 Smart Plug installation
I have bought [TP-LINK Wi-Fi Smart Plug HS100](https://www.tp-link.com/cz/home-networking/smart-plug/hs100/). It is compatible with Home Assistant, but is end-of-life. Check compatibility with Home Assistant, before you buy some smart plug.

Install the `Tplink's` [Kasa Smart](https://play.google.com/store/apps/details?id=com.tplink.kasa_android&hl=sk&gl=US) mobile application and follow the instructions in mobile app.
After successfull pairing, add the device in Home Assistant.

To add new smart plug to Home Assistant, follow doc at [https://www.home-assistant.io/integrations/tplink/](https://www.home-assistant.io/integrations/tplink/)

If you are connecting to SSID lets say X, you need the X network be the same, like the network where your Home Assistant node is available.
If the networks do not mach (like at my situation) you will need to add port forwarding from network X to network Y.
I have tried to scan open ports on smart plug via `nmap -Pn 10.0.2.105`
The response is:
```
PORT     STATE SERVICE
9999/tcp open  abyss
```

So I need to set port forwarding from port `9999` on the router, to port `9999` on the smart plug.
Note: The port depents on your smart plug model. If you have TPlink router, login to router IP and navigate
advanced > nat forwarding > virtual servers. There add port forwarding for port 9999.

If the smart plug was not auto discovered by Home Assistent, do following steps: (source: [https://www.home-assistant.io/integrations/tplink/](https://www.home-assistant.io/integrations/tplink/))
- Browse to your Home Assistant instance.
- In the sidebar click on  Settings.
- From the configuration menu select: Devices & Services.
- In the bottom right, click on the  Add Integration button.
- From the list, search and select “TP-Link Kasa Smart”.

Follow the instruction on screen to complete the set up.

In the modal, insert the IP of your router, where you have set port forwarding. Do not write the IP of the smart plug, as it is in another network and is not reachable.

You can check to turn on/off the plug via Home Assistant, or via REST API. The REST APIs doc is at [https://developers.home-assistant.io/docs/api/rest/](https://developers.home-assistant.io/docs/api/rest/)

### 3.2.1 Postman requests
Replace `10.0.3.3:8123` with the IP of Home Assistant node and 8123 with the port. If you havent changed it, the default port is `8123`

### 3.2.1.1 Turn on/off the plug
**Turn on:**  
POST url: `http://10.0.3.3:8123/api/services/switch/turn_on`

**Turn off:**  
POST url: `http://10.0.3.3:8123/api/services/switch/turn_off`

**Headers section:**  
For Bearer, set your long lived token from Home Assistant:
```
Content-Type: application/json
Authorization: Bearer eyJ0eXA...
```

**Body:**
- select raw
- select application/json
- Body value: (change the `smart_zasuvka_1090` to your name)
```
{
    "entity_id": "switch.smart_zasuvka_1090"
}
```

### 3.2.1.2 Get status of plug
(change the `smart_zasuvka_1090` to your name)

GET url: `http://10.0.3.3:8123/api/states/switch.smart_zasuvka_1090`

**Headers section:**  
For Bearer, set your long lived token from Home Assistant:
```
Content-Type: application/json
Authorization: Bearer eyJ0eXA...
```
