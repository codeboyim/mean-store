'use strict'

#Setting up route
angular.module('mean').config [
        '$stateProvider'
        ($stateProvider) ->
            # For unmatched routes:
            # $urlRouterProvider.otherwise '/'

            # states for my app
            $stateProvider
                .state('all articles'
                    url: '/articles',templateUrl: 'views/articles/list.html',anonymous: true
                )
                .state('create article'
                    url: '/articles/create', templateUrl: 'views/articles/create.html'
                )
                .state('edit article'
                    url: '/articles/:articleId/edit', templateUrl: 'views/articles/edit.html'
                )
                .state('article by id'
                    url: '/articles/:articleId', templateUrl: 'views/articles/view.html'
                )
                .state('home'
                    url: '/', templateUrl: 'views/index.html', anonymous: true
                )
    
]

#Setting HTML5 Location Mode
angular.module('mean').config ['$locationProvider',

    ($locationProvider) ->

        $locationProvider.hashPrefix('!').html5Mode true

]

angular.module('mean').run ['Global', '$rootScope','$window',
    
    (Global, $rootScope, $window) ->
        
        $rootScope.$on '$stateChangeStart',

            (event, toState) ->

                if !Global.authenticated and !toState.anonymous
                    event.preventDefault()
                    $window.location.href = '/signin'
                    null
]
