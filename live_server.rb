#! ruby -EUTF-8
require 'webrick'
require './to_tategaki'

input_file = ARGV[0] || 'nex.txt'
mode = (ARGV[1] || "1").to_i
port = 8000

# HTMLに自動リロードスクリプトを注入
def inject_reload_script(html)
  script = <<~JS
  <script>
  setInterval(() => {
    fetch('/timestamp')
      .then(r => r.text())
      .then(time => {
        if (window.lastTime && time !== window.lastTime) {
          location.reload();
        }
        window.lastTime = time;
      });
  }, 1000);
  </script>
  JS
  
  html.gsub('</body>', "#{script}</body>")
end

server = WEBrick::HTTPServer.new(Port: port)

server.mount_proc '/' do |req, res|
  begin
    content = File.read(input_file)
    html = to_tategaki(content, input_file, mode).join
    res.body = inject_reload_script(html)
    res.content_type = 'text/html; charset=utf-8'
  rescue => e
    res.body = "<h1>Error</h1><pre>#{e.message}</pre>"
  end
end

server.mount_proc '/timestamp' do |req, res|
  res.body = File.mtime(input_file).to_i.to_s
end

trap('INT') { server.shutdown }

puts "Server started at http://localhost:#{port}"
puts "Watching #{input_file} (mode: #{mode})"
puts "Press Ctrl+C to stop"

server.start