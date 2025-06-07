class SidekiqConstraint
  def matches?(request)
    Rails.logger.info "Allowing Sidekiq access"
    @request = request
  end
end
