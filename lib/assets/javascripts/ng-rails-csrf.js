angular.module('ng-rails-csrf', []).config(['$httpProvider', function($httpProvider) {
  var headers = $httpProvider.defaults.headers.common;
  var token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  headers['X-CSRF-Token'] = token;
}]);
