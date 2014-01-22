window.App.factory('User', ['$resource', function($resource) {
  return $resource('/api/users');
}]);
