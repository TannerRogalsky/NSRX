window.App.controller('PlayCtrl', ['$scope', '$location', '$route', 'User', function($scope, $location, $route, User) {

  // We expect to receive the user object's properties as paramters.
  // Let's recreate it as a model object and make available to the views
  $scope.user = $route.current.params;

  // Our "game" has a silly counter that can be increased. We'll initialize it here

  $scope.silly_counter = 1;

  $scope.increase_silly_counter = function() {
    // Just change the model, and Angular magic will update the view
    $scope.silly_counter++;

    // Let's update our server (it keeps each player's record)
    $scope.user.score = $scope.silly_counter;
    new User($scope.user).$save();
  }

  $scope.go_back = function() {
    $location.path('/');
  }

}]);
