window.App.controller('LeaderboardCtrl', ['$scope', '$location', 'User', function($scope, $location, User) {
  
  User.query(function(users) {
    $scope.users = users;
  });

  $scope.kik = function(user) {
    cards.kik.send(user.username, {    
      title: 'Hello Kik',
      text: 'So you think ' + user.record + ' is high?'
    });
  }

  $scope.go_back = function() {
    $location.path('/');
  }

}]);
