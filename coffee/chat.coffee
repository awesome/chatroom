module.exports = (socket)->
  socket.on('join', (name)->
    socket.chaterName = name
    chatters.push(name)
    socket.emit('notice', { from: 'System', content: "Welcome <b>#{name}</b>" })
    socket.emit('chatters', chatters)
    socket.broadcast.emit('notice', {from: 'System', content: "<b>#{name}</b> Join the chatroom"})
    socket.broadcast.emit('chatters', chatters)
  )
  socket.on('disconnect', ->
    name = socket.chaterName
    console.log '###disconnect ' + name
    if name?
      global.chatters = __.without(chatters, name)
      console.log chatters
      socket.broadcast.emit('chatters', chatters)
      socket.broadcast.emit('notice', {from: 'System', content: "#{name} Leave the chatroom"})
  )
  socket.on 'current_chatters', ->
    socket.emit 'chatters', chatters
