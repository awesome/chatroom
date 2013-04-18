socket = io.connect('http://localhost:3333')

CM = angular.module('ChatModule', [])

CM.controller('ChatCtrl', ($scope)->
  $scope.public_msg = []

  socket.on('chatters', (members)->
    $scope.chatters = members
    $scope.$apply()
  )
  socket.on('notice', (msg_object)->
    $scope.public_msg.push(msg_object)
    $scope.$apply()
  )

  socket.emit 'current_chatters'

  $scope.ready_to_join = ->
    $scope.chatters != undefined and !$scope.open_msg_box

  $scope.register = ->
    if _.contains($scope.chatters, $scope.name)
      $scope.register_failed = true
      $scope.failed_msg = "Sorry, #{$scope.name} was existed. Please choose another name"
    else
      $scope.open_msg_box = true
      socket.emit('join', $scope.name)
)
