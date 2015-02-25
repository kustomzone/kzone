# Dynamically generate a gallery from a gist.

# (work in progress)

# api spec: https://developer.github.com/v3/

# For a given gist, e.g. https://gist.github.com/anonymous/5446951, you can access a JSON object containing
# the HTML markup and CSS URI for the Gist at https://gist.github.com/anonymous/5446989.json 


require 'open-uri'
require 'json'
require 'uri'

require 'net/http'
require 'net/https'

# For the vector class
# (note: install gmath3D gem if not already installed)
require 'gmath3D'

SITE = "test".downcase
DOWNLOAD = true

puts "Fetching json..."

json = JSON.parse(open("http://www.colourlovers.com/api/palettes/top?format=json").readlines.join)


# json = JSON.parse(open("https://gist.github.com/anonymous/5446989.json").readlines.join)


xml = "<scene>\n"
xml += <<-EOF
  <spawn position="0 0 0" />

EOF

i = 0

json.each do |palette|

  title = palette["title"].slice(0,70)
  
  if title.length == 70
    title = title.sub(/\.+$/, '') + "..."
  end
  
  uri = URI.parse(URI.encode(palette["imageUrl"]))
  extension = File.extname(uri.path).downcase
  
  # jpg, jpeg, png...
  
  next unless extension == ".jpg" || extension == ".jpeg" || extension == ".png"
  
  puts " * #{uri.to_s}"
  
  if DOWNLOAD
    `curl #{uri.to_s} -s -o scenes/images/#{SITE}-#{i}#{extension}` || next
    `mogrify -resize 500x450 scenes/images/#{SITE}-#{i}#{extension}` || next
  end
  
  x = i % 5
  z = (i / 5).floor
  
  v  = GMath3D::Vector3.new(x, 0.05, -z) * 5
  v += GMath3D::Vector3.new(5, 0.5, -5)
  
  height = `identify scenes/images/#{SITE}-#{i}#{extension}`.match(/x(\d+)/)[1].to_i + 320
  margin = (512 - height) / 2

  xml += <<-EOF
    <billboard position="#{v.x} #{v.y} #{v.z}" rotation="0 0 0" scale="1.2 1.2 0.05">
      <![CDATA[
        <center style="margin-top: #{margin}px; font-size: 1em;">
          <img src="/images/#{SITE}-#{i}#{extension}" style="max-width: 100%; height: 100px;" />
		  <br>
          #{title}
		  <br>
		  <table style='background-color: #000000' width='100%' height='100%'><tr><td>
		  <p style='color: #00F020'> For a given gist, e.g. https://gist.github.com/anonymous/5446951, you can access a JSON object containing
		  the HTML markup and CSS URI for the Gist at https://gist.github.com/anonymous/5446989.json </p>
		  
		  <script>
		   // dynamically load a Gist without an iframe:
		   
		   // loadGist(element, 5446951);
		   
		   if (#{i}== 1) { alert('hello world =' + #{i}); }
  
           // temp
           function loadGist(element, gistId) {
            // something here
           }
		   </script>
		   
		  </td></tr></table>
		  <br>
        </center>
      ]]>
    </billboard>
	
EOF

  v.y = 0.2
  v  += GMath3D::Vector3.new(1.2, 0, 0)

  palette["colors"].each do |color|
    xml += "<box style='color:##{color};' scale='0.4 0.4 0.4' position='#{v.x} #{v.y.round(2)} #{v.z}' />"
    v += GMath3D::Vector3.new(0, 0.4, 0)
  end

  i += 1
end

xml += "</scene>"

File.open("./scenes/test.xml", "w") { |f| f.write xml }

puts "Visit /test.xml to see the gallery."

