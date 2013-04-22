
CM = angular.module('ChatModule', [])

CM.controller('ChatCtrl', ($scope)->
  $scope.public_msg = []

  $scope.reserved_username = ['system']

  $scope.register = ->
    if _.contains($scope.reserved_username, $scope.name.toLowerCase())
      $scope.failed_msg = "Hmmm, reserved username cant be used"
    else
      socket = io.connect("#{location.protocol}//#{location.host}")
      # how to move the socket feature in a standalone function
      socket.on('init_chatters', (members)->
        $scope.chatters = members
        $scope.open_msg_box = true
        $scope.failed_msg = null
        $scope.$apply()
      )
      socket.on 'repeated_name_error', ->
        $scope.failed_msg = "Sorry, #{$scope.name} was existed. Please choose another name"
        # socket.emit('disconnect') # we cant emit it, the log said debug: ignoring blacklisted event `disconnect`
        $scope.$apply()
      socket.on('chatters', (members)->
        $scope.chatters = members
        $scope.open_msg_box = true
        $scope.$apply()
      )
      socket.on('notice', (msg_object)->
        $scope.public_msg.push(msg_object)
        $scope.$apply()
      )
      socket.emit('join', $scope.name)

)
