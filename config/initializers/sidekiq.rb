require 'sidekiq'
require 'sidekiq-cron'

Sidekiq::Cron::Job.load_from_hash({
  'recalculate_inss_job' => {
    'class' => 'RecalculateInssJob',
    'cron' => '*/2 * * * *',
    'queue' => 'default'
  }
},)
