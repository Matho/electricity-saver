# README

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