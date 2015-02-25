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

SITE = "gist".downcase
DOWNLOAD = true

puts "Fetching json..."

json = JSON.parse(open("http://www.colourlovers.com/api/palettes/top?format=json").readlines.join)

# json = JSON.parse(open("https://gist.github.com/anonymous/5446989.json").readlines.join)

xml = "<scene>\n"
xml += <<-EOF
  <spawn position="0 0 0" />

EOF

i = 0

json.each do |json|

  title = json["title"].slice(0,70)
  
  if title.length == 70
    title = title.sub(/\.+$/, '') + "..."
  end
  
  uri = URI.parse(URI.encode(json["imageUrl"]))
  extension = File.extname(uri.path).downcase
  
  # jpg, jpeg, png...
  
  next unless extension == ".jpg" || extension == ".jpeg" || extension == ".png"
  
  puts " * #{uri.to_s}"
  
  if DOWNLOAD
    `curl #{uri.to_s} -s -o scene/images/#{SITE}-#{i}#{extension}` || next
    `mogrify -resize 500x450 scene/images/#{SITE}-#{i}#{extension}` || next
  end
  
  x = i % 5
  z = (i / 5).floor
  
  v  = GMath3D::Vector3.new(x, 0.05, -z) * 5
  v += GMath3D::Vector3.new(5, 0.5, -5)
  
  height = `identify scene/images/#{SITE}-#{i}#{extension}`.match(/x(\d+)/)[1].to_i + 50
  margin = (512 - height) / 2

  xml += <<-EOF
    <billboard position="#{v.x} #{v.y} #{v.z}" rotation="0 0 0" scale="1.2 1.2 0.05">
      <![CDATA[
        <center style="margin-top: #{margin}px; font-size: 3em">
          <img src="/images/#{SITE}-#{i}#{extension}" style="max-width: 100%" />
		  <br>
          #{title}
		  <br>
		  <p style="font-size: 1em"> For a given gist, e.g. https://gist.github.com/anonymous/5446951, you can access a JSON object containing
		  the HTML markup and CSS URI for the Gist at https://gist.github.com/anonymous/5446989.json </p>
		  <br>
		  <script>
		   // dynamically load a Gist without an iframe:
		   
		   loadGist(element, 5446951);
		   
		   alert(element);
  
  // temp
  function loadGist(element, gistId) {
    var callbackName = "gist_callback";
    window[callbackName] = function (gistData) {
        delete window[callbackName];
        var html = '<link rel="stylesheet" href="' + escapeHtml(gistData.stylesheet) + '"></link>';
        html += gistData.div;
        element.innerHTML = html;
        script.parentNode.removeChild(script);
    };
    var script = document.createElement("script");
    script.setAttribute("src", "https://gist.github.com/" + gistId + ".json?callback=" + callbackName);
    document.body.appendChild(script);
  }
          </script>
		
        </center>
      ]]>
    </billboard>
	
EOF

  v.y = 0.2
  v  += GMath3D::Vector3.new(1.2, 0, 0)

  json["colors"].each do |color|
    xml += "<box style='color:##{color};' scale='0.4 0.4 0.4' position='#{v.x} #{v.y.round(2)} #{v.z}' />"
    v += GMath3D::Vector3.new(0, 0.4, 0)
  end

  i += 1
end

xml += "</scene>"

File.open("./scene/gist.xml", "w") { |f| f.write xml }

puts "Visit /gist.xml to see the gallery."

