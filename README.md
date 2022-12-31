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

NOTE: If you want to switch on/off your smart plug, you need to have smart plug compatible with Home Assistant software. Also, you need some version of Raspberry PI, where Home Assistant software and this project will be running.


## ENV Credentials
HOW TO: [https://blog.saeloun.com/2019/10/10/rails-6-adds-support-for-multi-environment-credentials.html](https://blog.saeloun.com/2019/10/10/rails-6-adds-support-for-multi-environment-credentials.html)

Edit ENV for development:  
```
$ EDITOR=vim rails credentials:edit
```


## Start project on localhost
```
$ rake db:create
$ rake db:schema:load
$ rake db:seed
```

Open `http://localhost:3000/users/sign_up` in your browser and fill in registration form. Then change the `confirmed_at` column in the users table - fill it with current time.

Then navigate to `http://localhost:3000/users/sign_in` and login via your password. You should be correctly signed in the app.

## Build Docker image
In config dir rename `secrets.yml.example` to `secrets.yml` and specify your secret value for production

Build the app on the Raspberry PI (provide RAILS_MASTER_KEY env, which is output of config/master.key)  
``` 
$ sudo docker build --build-arg RAILS_ENV=production --build-arg RAILS_MASTER_KEY=XXX -t mathosk/electricity-saver:latest_aarch64 .
```

Push the builded image:  
``` 
$ sudo docker push mathosk/electricity-saver:latest
```
Alternatively, tag the build with release version

## Start the app
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

## First steps
- create your network
- create devices
- create smart plug
- create custom rules
- check if ping works
- check if automat is scheduling the events