Sidekiq.default_job_options = { "backtrace" => true }

class EnqueueLogger
  include Sidekiq::ServerMiddleware

  def call(job_class, job, queue, _redis_pool)
    logger.debug "enqueue worker=#{job_class} jid=#{job['jid']} queue=#{queue} args=#{job['args'].inspect}"
    yield
  end
end

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add EnqueueLogger
  end
end
