require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write("Hurray we passed!")
  res.finish
end

# Rack::Server.start(app: app, Port: 3000)

redirect_app = Proc.new do |env| 
  req = Rack::Request.new(env)
  res = Rack::Response.new
  case req.path
  when '/lindy'
   res.write('oh well...')
  when '/squash'
    res.write('Squash!')
  when '/school'
    res.write('school...')
  end

  res.finish
end

# Rack::Server.start(app: redirect_app, Port: 3000)