web: bundle exec passenger start -p $PORT --max-pool-size 3 --engine=nginx
worker: bundle exec sidekiq -C config/sidekiq.yml