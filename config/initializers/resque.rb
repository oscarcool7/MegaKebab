Resque.logger = Logger.new(Rails.root.join("log", "#{Rails.env}_resque.log"))
Resque.logger.level = Logger::DEBUG

uri = URI.parse("redis://localhost:6379")
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
Resque.redis = REDIS
