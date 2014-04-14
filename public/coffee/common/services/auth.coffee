'use strict'

angular.module('mean').factory('Auth'
	[
		'$http'
		'$window'
		($http, $window) ->
			accessLevels = routingConfig.accessLevels
			userRoles = routingConfig.userRoles
			currentUser = $window.user || { username: '', role: userRoles.public }


			login: (user, success, error) ->
				$http
					.post('/api/users/session', user)
					.success(
						(res)->
							angular.extend(currentUser, res)
							success()
					)
					.error(error)

			register: (user, success, error) ->
				$http
					.post('/users', user)
					.success(
						(res)->
							angular.extend(currentUser, res)
							success()
					)
					.error(error)

			checkIfAvailable: (user) ->
				$http
					.post '/api/users/check', user

			isLoggedIn: (user)->
				
				if user == null
					user = currentUser

				user.role isnt routingConfig.userRoles.public
					
						
			authorize: (accessLevel, role)->
				
				if role == null
					role = currentUser.role

				accessLevel is '*' or accessLevel.indexOf(role) isnt -1

			accessLevels: accessLevels
			userRoles:userRoles
	]
)