Scene 	= require('../js/scene')
Script 	= require('../js/script')
Box 	= require('../js/box')
Spawn 	= require('../js/spawn')
Model 	= require('../js/model')
Link 	= require('../js/link')
Sky 	= require('../js/sky')
Fog 	= require('../js/fog')
Audio 	= require('../js/audio')

describe 'constructor', ->
  it 'should create', ->
    s = new Scene "scene"
    expect(s instanceof Scene).toBeTruthy()
    expect(s.nodeName).toEqual 'scene'

describe 'scene', ->
  it 'should load scene', ->
    Scene.load process.cwd() + '/spec/fixtures/hello.xml', (scene) ->
      expect(scene.childNodes.length).toEqual(7)

      box = scene.childNodes[1]
      expect(box instanceof Box).toBeTruthy()
      expect(box.position.y).toEqual 10.0

      script = scene.childNodes[5]
      expect(script instanceof Script).toBeTruthy()

  it 'should load scene with <script /> tags', ->
    Scene.load process.cwd() + '/spec/fixtures/script_tag.xml', (scene) ->
      expect(scene.childNodes.length).toEqual(5)

      script = scene.childNodes[3]
      expect(script instanceof Script).toBeTruthy()
      expect(script.textContent).toMatch /10 < 20/

xdescribe 'compartmentalization', ->
  xml1 = "<scene><script>document.foo = 'bar';</script></scene>"
  xml2 = "<scene><script>console.dump(document.foo)</script></scene>"

  it 'should have seperate document instances', ->
    dumped = {}

    console.dump = (obj) ->
      dumped = obj

    Scene.load xml1, (scene1) ->
      Scene.load xml2, (scene2) ->
        expect(dumped).toBeUndefined()

describe 'all_tags', ->
  it 'should load', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.childNodes.length).toBeGreaterThan 3

  it 'should parse spawn', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("spawn").length).toEqual 1
      expect(scene.getElementsByTagName("spawn")[0] instanceof Spawn).toBeTruthy()

  it 'should parse billboard', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("billboard").length).toEqual 1
      expect(scene.getElementsByTagName("billboard")[0].innerHTML).toMatch /<h1>Welcome/
      expect(scene.getElementsByTagName("billboard")[0].innerHTML).toMatch /<!\[CDATA\[/
      expect(scene.getElementsByTagName("billboard")[0].innerHTML).toMatch /stuff and things/

  it 'should parse model', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("model").length).toEqual 1
      expect(scene.getElementsByTagName("model")[0].src).toMatch /blah.obj/
      expect(scene.getElementsByTagName("model")[0] instanceof Model).toBeTruthy()

  it 'should parse link', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("link").length).toEqual 1
      expect(scene.getElementsByTagName("link")[0].href).toMatch /test/
      expect(scene.getElementsByTagName("link")[0] instanceof Link).toBeTruthy()

  it 'should parse sky', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("sky").length).toEqual 1
      expect(scene.getElementsByTagName("sky")[0].src).toMatch /blah/
      expect(scene.getElementsByTagName("sky")[0] instanceof Sky).toBeTruthy()

  it 'should parse audio', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("audio").length).toEqual 1
      expect(scene.getElementsByTagName("audio")[0].src).toMatch /drone/
      expect(scene.getElementsByTagName("audio")[0] instanceof Audio).toBeTruthy()

  it 'should parse fog', ->
    Scene.load process.cwd() + '/spec/fixtures/all_tags.xml', (scene) ->
      expect(scene.getElementsByTagName("fog").length).toEqual 1
      expect(scene.getElementsByTagName("fog")[0].style.color).toMatch '#fff'
      expect(scene.getElementsByTagName("fog")[0].near).toMatch '100'
      expect(scene.getElementsByTagName("fog")[0] instanceof Fog).toBeTruthy()

