ChatChannel = require('../js/chat_channel')
Scene 		= require('../js/scene')

describe 'constructor', ->
  it 'should create', ->
    n = new ChatChannel
    expect(n instanceof ChatChannel).toBeTruthy()

describe 'sendMessage', ->
  it 'should send message', ->
    c = new ChatChannel { scene : new Scene('scene') }
    expect(c.sendMessage { broadcast : ( -> ), player : { name : 'ben' } }, 'hello world').toMatch /^<event.+chat/
