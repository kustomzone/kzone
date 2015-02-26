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
DOWNLOAD = false

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
    `curl #{uri.to_s} -s -o scene/images/#{SITE}-#{i}#{extension}` || next
    `mogrify -resize 500x450 scene/images/#{SITE}-#{i}#{extension}` || next
  end
  
  x = i % 5
  z = (i / 5).floor
  y = 1
  
  v  = GMath3D::Vector3.new(x, 0.05, -z) * 5
  v += GMath3D::Vector3.new(5, y, -5)
  
  height = `identify scene/images/#{SITE}-#{i}#{extension}`.match(/x(\d+)/)[1].to_i + 300
  height2 = height - 220
  margin = (512 - height) / 3

  xml += <<-EOF
    <billboard position="#{v.x} #{v.y} #{v.z}" rotation="0 0 0" scale="2 2 0.05">
      <![CDATA[
        <center style='margin-top: #{margin}px; font-size: 1.2em;'>
          <img src='/images/#{SITE}-#{i}#{extension}' style='max-width: 100%; height: 60px;'> #{title}
				<table style='background-color: #000000; font-size: 0.45em; width: 100%;'>
				 <tr>
				  <td style='vertical-align: top;' height= '#{height2}'>
				    <div id='box1' height='#{height2}'>
					  <p style='color: #00F020; vertical-align: top;'> </p>
					</div>
					<div id='box2' height='#{height2}'>
					  <p style='color: #00F020; vertical-align: top;'> </p>
					</div>
				</td></tr></table>
		  
		  <script>
		  
		   // dynamically load a Gist without an iframe:
		   
		   // loadGist(element, 5446951);
		   
			if (#{i}== 1) { 
				
				var parent = document.getElementById('box1');
				var child  = parent.childNodes[1];
				var node   = document.createElement('p');
				node.setAttribute('color', '#FF0000');
				var textnode = document.createTextNode('Hello World');
				node.appendChild(textnode);
				child.appendChild(node);
				alert(child.innerHTML);
				
				// setAttribute("src", file);
			}
			
			if (#{i}== 2) { 
				
				var parent2 = document.getElementById('box2');
				var child2 = parent2.childNodes[1];
				// alert(child2.innerHTML);
				var gistId = 5446951;
				var script = document.createElement('script');
				script.setAttribute('src', 'https://gist.github.com/' + gistId + '.json');
				child2.appendChild(script);
				alert(child2.innerHTML);
			}
			
			if (#{i}== 3) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 4) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 5) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 6) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 7) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 8) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 9) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 10) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 11) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 12) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 13) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 14) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			if (#{i}== 15) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			if (#{i}== 16) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			if (#{i}== 17) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
			if (#{i}== 18) { 
		   
				// alert('hello world =' + #{i}); 
				
			}
			
           
		   </script>
		   
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

File.open("./scene/test.xml", "w") { |f| f.write xml }

puts "Visit /test.xml to see the gallery."

