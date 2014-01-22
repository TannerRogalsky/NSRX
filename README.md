# Hello Kik

A skeleton app for the Kik Hadouken day

## Development setup

Think of a lowercase name for your app, e.g. "myapp". Then type (replacing your name accordingly)

    APP_NAME=myapp

and paste the commands below:

    git clone git@github.com:uken/hellokik.git 
    cd hellokik
    git remote remove origin
    bundle install
    bundle exec rails g rename:app_to $APP_NAME
    cd ..
    cd $APP_NAME
    find app    -type f | xargs perl -pi -e s/hellokik/$APP_NAME/g
    find config -type f | xargs perl -pi -e s/hellokik/$APP_NAME/g
    rm -Rf slides
    git commit -am "renamed to $APP_NAME"
    bundle exec rake db:setup
    RAILS_ENV=test bundle exec rake db:migrate
    
### Running on a browser

Chrome is recommended with these two extensions:

- [Kik Cards Debugger](https://chrome.google.com/webstore/detail/kik-cards-debugger/occbnccdhakfaomkhhdkmmknjbghmllm)
- [Batarang](https://chrome.google.com/webstore/detail/angularjs-batarang/ighdmehidhipcmcojjgiloacoafjmpfk) (AngularJS debugger)

Start your server as usual (`bundle exec rails server`), open http://localhost:3000 and put Developer Tools at the side. You'll notice two extra developer tabs for Kik and Angular.

### Running on a real device (iOS/Android)

- Start your server
- Find which is your [developer port port](https://sites.google.com/a/uken.com/team/developer-resources/ports) (edit the document and add one if you need).

Let's say it is `1234` (replace as needed):

- Start a tunnel (`uken tunnel 1234`)
- [Install Kik](http://kik.com/) on your device
- On iOS go to `card://tunnel.uken.com:1234`
- On Android send `card://tunnel.uken.com:1234` to a contact and click the link

### Deployment

To put your app on a server, use [PowerUp](https://github.com/uken/powerup), Uken's upcoming [Heroku](https://www.heroku.com/)-style highly scalable hosting system. Let's say its name is `myapp`:

## Setup

**Once in your life**: Create your app within PowerUp with these settings:

- Environment tab: add these two variables
    - *RAILS_ENV*: `staging`
    - *DATABASE_URL*: `mysql2://USER:PASS@MACHINE.uken.local/DB` - your Hadouken Day team should have a USER/PASS/MACHINE/DB.
- Hostnames tab: add `myapp.daybreak.io`
- Danger tab: "Deploy release automatically on github" 

**Once per dev box**:

      uken powerup config myapp

### Deploy

    uken powerup push myapp --force

