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
Build the app on the Raspberry PI:  
``` 
$ sudo docker build --build-arg RAILS_ENV=production --build-arg RAILS_MASTER_KEY=XXX -t mathosk/electricity-saver:latest .
```

Push the builded image:  
``` 
$ sudo docker push mathosk/electricity-saver:latest
```
