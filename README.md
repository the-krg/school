# README
Project specs and dependencies:
- Ruby 3.2.2
- Rails 8
- psql 17

Gems used (other than Rails included ones):
- `sidekiq` - jobs processor
- `HTTParty` - for http requests
- `dotenv` - for storing sensitive information such as the api key
- `tailwind-rails` -  for quicker view setup
- `rspec` + `shoulda-matchers` + `rails-controller-testing` - testing

## How to run this project

1. If you're on git, clone the repo; if you downloaded the provided .zip, unpack it;
2. Install required dependencies, such as Ruby, Rails, PostgreSQL, Bundler.
3. Run the following
```
# install gem dependencies
bundle install 

# set up database
rails db:create
rails db:migrate

# start sidekiq (I recommend doing that in a separate tab)
# it will be needed for syncing enrollments
sidekiq
```
4. Create a `.env` file and add your `API_KEY`
```
cp .env.example .env

vim .env
```

5. Run the following rake task to populate the database
```
rake sync:all
```
6. Run the project
```
./bin/dev
```
7. Go to [localhost:3000/courses](http://localhost:3000/courses)
8. 🎉 you should see your school's published courses!

## Notes
1. I started to write about my decisions here, but we can discuss it later since I'm running out of time!

ps.: Please disregard the commit messages on GitHub, since this is a one-man project + delivered in a zip file.
I took the liberty to code everything in ~4 hours.
They do not represent my actual git commit practices.
It's on git just for saving and cloud file check purposes.