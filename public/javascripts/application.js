// Generated by CoffeeScript 1.6.2
(function() {
  var CM, socket;

  socket = io.connect("" + location.protocol + "//" + location.host);

  CM = angular.module('ChatModule', []);

  CM.controller('ChatCtrl', function($scope) {
    $scope.public_msg = [];
    socket.on('chatters', function(members) {
      $scope.chatters = members;
      return $scope.$apply();
    });
    socket.on('notice', function(msg_object) {
      $scope.public_msg.push(msg_object);
      return $scope.$apply();
    });
    socket.emit('current_chatters');
    $scope.ready_to_join = function() {
      return $scope.chatters !== void 0 && !$scope.open_msg_box;
    };
    $scope.reserved_username = ['System'];
    return $scope.register = function() {
      if (_.contains($scope.chatters, $scope.name)) {
        return $scope.failed_msg = "Sorry, " + $scope.name + " was existed. Please choose another name";
      } else if (_.contains($scope.reserved_username, $scope.name)) {
        return $scope.failed_msg = "Hmmm, reserved username cant be used";
      } else {
        $scope.open_msg_box = true;
        return socket.emit('join', $scope.name);
      }
    };
  });

}).call(this);
