class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 

  # Limit requests to 5 requests per 5 seconds
  throttle('req/ip', limit: 5, period: 5.seconds) do |req|
    req.ip
  end

    # Limit requests to 1 request per 15 seconds to the /users endpoint
    throttle('create_user/ip', limit: 1, period: 15.seconds) do |req|
    if req.path == '/users' && req.post?
      req.ip
    end
  end
end