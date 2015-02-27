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

json  = JSON.parse(open("http://www.colourlovers.com/api/palettes/top?format=json").readlines.join)


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
  
  height  = `identify scene/images/#{SITE}-#{i}#{extension}`.match(/x(\d+)/)[1].to_i + 300
  height2 = height - 220
  margin  = (512 - height) / 3

  xml += <<-EOF
    <billboard position="#{v.x} #{v.y} #{v.z}" rotation="0 0 0" scale="2 2 0.05">
      <![CDATA[
        <center style='margin-top: #{margin}px; font-size: 1.2em;'>
          <img src='/images/#{SITE}-#{i}#{extension}' style='max-width: 100%; height: 60px;'> #{title} 
				<table style='background-color: #000000; font-size: 0.45em; width: 100%;'>
				 <tr>
				  <td style='vertical-align: top;' height= '#{height2}'>
				    <div id='box#{i}' height='100%'>
					  <!-- p style='color: #00FF30'>#{height} #{height2}</p -->
					</div>
				</td></tr></table>
		  
		  <script>
		  
		   // dynamically load a Gist without an iframe:
		   
		   // loadGist(element, 5446951);
		   
		    if (#{i}== 0) { 
			
				var parent = document.getElementById('box0');
				// var child  = parent.childNodes[1];
				var tnode  = document.createElement('p');
				tnode.setAttribute('color', '#FF0000');
				var textnode = document.createTextNode('Hello World');
				tnode.appendChild(textnode);
				parent.appendChild(tnode);
				// alert(child.innerHTML);
				
			}
		   
			if (#{i}== 1) { 
			
				var parent1 = document.getElementById('box1');
				var script1  = document.createElement('script');
				script1.setAttribute('src', 'http://kustomzone.github.io/kzone/app.js');
				parent1.appendChild(script1);
				alert(parent1.innerHTML);
				
			}
			
			if (#{i}== 2) { 
				
				var parent2 = document.getElementById('box2');
				var image = document.createElement('img');
				image.setAttribute('src', 'http://fate.co.nz/proton/images/wallpaper/AndroidLogo-multicolor.jpg');
				image.setAttribute('height', '500');
				image.setAttribute('width' , '500');
				parent2.appendChild(image);
				alert(parent2.innerHTML);
				
			}
			
			if (#{i}== 3) { 
		   
				var parent3 = document.getElementById('box3');
				var iframe = document.createElement('iframe');
				iframe.setAttribute('src', 'http://kustomzone.github.io/kzone/index2.htm');
				parent3.appendChild(iframe);
				alert(parent3.innerHTML);
				
			}
			
			if (#{i}== 4) { 
		   
				// var parent4 = document.getElementById('box4');
				// var child4 = parent4.childNodes[1];
				// var gistId = 5446951;
				// var script4 = document.createElement('script');
				// script4.setAttribute('src', 'https://gist.github.com/' + gistId + '.json');
				// child4.appendChild(script4);
				// alert(child4.innerHTML);
				
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
           if (#{i}== 19) { 
		   
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

