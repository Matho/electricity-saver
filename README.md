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
Rename `secrets.yml.example` to `secrets.yml` and specify your secret value for production

Build the app on the Raspberry PI:  
``` 
$ sudo docker build --build-arg RAILS_ENV=production --build-arg RAILS_MASTER_KEY=XXX -t mathosk/electricity-saver:latest_aarch64 .
```

Push the builded image:  
``` 
$ sudo docker push mathosk/electricity-saver:latest
```

## Start the app
Allow port for main app  
`$ ufw allow 8090`

Create docker network  
`$ sudo docker network create electricity-saver-nw`

Start the docker-compose via:  (use `-d` for detached at the end of command)  
`sudo docker-compose -f docker-compose_aarch64.yml up`  
`sudo docker-compose -f docker-compose_aarch64.yml stop`

Optional, if you want to seed some initial data:  
`$ sudo docker-compose -f docker-compose_aarch64.yml run electricity_saver rake db:seed RAILS_ENV=production`

`sudo docker-compose -f docker-compose_aarch64.yml up -d`  

Visit `http://10.0.2.5:8090/users/sign_up`  

Select container with rails project and copy hash:  
`$ sudo docker container ls -a`  
`$ sudo docker container exec -it c82b39edfa70 bash`

Execute rails console in rails project  
`$ bundle exec rails c`

Activate your admin user:  
`User.last.update!(confirmed_at: Time.now)`
