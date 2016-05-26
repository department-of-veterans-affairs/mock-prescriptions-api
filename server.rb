require 'webrick'
require 'json'

# default port to 3000 or overwrite with PORT variable by running
# $ PORT=3001 ruby server.rb
port = ENV['PORT'] ? ENV['PORT'].to_i : 3004

puts "Server started: http://localhost:#{port}/"

root = File.expand_path './public'
server = WEBrick::HTTPServer.new Port: port, DocumentRoot: root

server.mount_proc '/' do |req, res|
  comments = JSON.parse(File.read('./json_responses/default.json', encoding: 'UTF-8'))

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

server.mount_proc '/rx/v1/history' do |req, res|
  comments = JSON.parse(File.read('./json_responses/history.json', encoding: 'UTF-8'))

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

server.mount_proc '/rx/v1/prescription' do |req, res|
  comments = JSON.parse(File.read('./json_responses/prescription.json', encoding: 'UTF-8'))

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

server.mount_proc '/rx/v1/prescription/1435525' do |req, res|
  comments = JSON.parse(File.read('./json_responses/prescription1435525.json', encoding: 'UTF-8'))

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

server.mount_proc '/rx/v1/tracking/1435525' do |req, res|
  comments = JSON.parse(File.read('./json_responses/tracking1435525.json', encoding: 'UTF-8'))

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

trap('INT') { server.shutdown }

server.start
