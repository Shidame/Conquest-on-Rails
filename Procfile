web:        bundle exec rails server
redis:      redis-server
scheduler:  bundle exec rake resque:scheduler
resque:     QUEUE=* JOBS_PER_FORK=5 bundle exec rake resque:work
juggernaut: juggernaut --port 8080
