window.App.controller('HomeCtrl', ['$scope', '$location', 'User', function($scope, $location, User) {

  $scope.leaderboard = function() {
    $location.path('/leaderboard');
  }

  $scope.startPlaying = function() {
    // getUser will trigger card "linking" if needed
    cards.kik.getUser(function(user) {
      if (user) {
        // got authorized, let's grab the user's push token...
        cards.push.getToken(function (token) {
          // ...and the user info we got, with or without token...
          if (token) { user.notification_token = token }
          new User(user).$save(function(user) {
            // ...then go to /play, passing every property of the user as a "GET" parameter
            $location.path('/play').search(user);
          });
        });
      }
    });
  }

}]);
