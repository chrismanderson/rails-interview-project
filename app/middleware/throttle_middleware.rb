class ThrottleMiddleware
  def initialize app
    @app = app
  end

  def call env
    request = Rack::Request.new(env)

    if request.params.keys.include?("api_key")
      key = request.params["api_key"]
      t = Tenant.find_by(api_key: key)

      if t.request_count > 100 && t.last_accessed_at < Time.current - 10.seconds 
        [403, {}, ["Request exceeded"]]
      else
        @app.call(env)
      end
    else
      @app.call(env)
    end
  end
end
