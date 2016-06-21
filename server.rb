require 'webrick'
require 'webrick/https'
require 'json'

# default port to 3000 or overwrite with PORT variable by running
# $ PORT=3001 ruby server.rb
port = ENV['PORT'] ? ENV['PORT'].to_i : 443

cert_name = [
  %w(CN localhost),
]

puts "Server started: https://localhost:#{port}/"

root = File.expand_path './public'

server = WEBrick::HTTPServer.new Port: port, DocumentRoot: root

server.mount_proc '/' do |req, res|
  generate_response(res, './json_responses/default.json')
end

server.mount_proc '/mhv-api/patient/v1/session' do |req, res|
  res['Date'] = 'Tue, 10 May 2016 16:30:17 GMT'
  res['Server'] = 'Apache/2.2.15 (Red Hat)'
  res['Content-Length'] = 0
  res['Expires'] = 'Tue, 10 May 2016 16:40:17 GMT'
  res['Token'] = 'GkuX2OZ4dCE=48xrH6ObGXZ45ZAg70LBahi7CjswZe8SZGKMUVFIU88='
  res['Set-Cookie'] = 'JSESSIONID=QWMKXyMZmBfnC15xJKTQRMPvpMpsRhPJNwc9PGQMhSR8QQ8gQLL8!1523265843; path=/; HttpOnly'
  res['X-Powered-By'] = 'Servlet/2.5 JSP/2.1'
  res['Connection'] = 'close'
  res['Content-Type'] = 'text/plain; charset=UTF-8'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = nil
end

server.mount_proc '/mhv-api/patient/v1/prescription/gethistoryrx' do |req, res|
  generate_response(res, './json_responses/history.json')
end

server.mount_proc '/rx/v1/history' do |req, res|
  generate_response(res, './json_responses/history.json')
end

server.mount_proc '/mhv-api/patient/v1/prescription/getactiverx' do |req, res|
  generate_response(res, './json_responses/prescription.json')
end

server.mount_proc '/rx/v1/prescription' do |req, res|
  generate_response(res, './json_responses/prescription.json')
end

server.mount_proc '/mhv-api/patient/v1/prescription/1435525' do |req, res|
  generate_response(res, './json_responses/prescription1435525.json')
end

server.mount_proc '/rx/v1/prescription/1435525' do |req, res|
  generate_response(res, './json_responses/prescription1435525.json')
end

server.mount_proc '/mhv-api/patient/v1/prescription/rxtracking/1435525' do |req, res|
  generate_response(res, './json_responses/tracking1435525.json')
end

server.mount_proc '/rx/v1/tracking/1435525' do |req, res|
  generate_response(res, './json_responses/tracking1435525.json')
end

def generate_response(res, file_location)
  comments = JSON.parse(File.read(file_location, encoding: 'UTF-8'))

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

trap('INT') { server.shutdown }

server.start
