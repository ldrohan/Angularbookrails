BookApp = angular.module("BookApp", [])

BookApp.controller("BooksCtrl", ["$scope", "$http", ($scope, $http)->
	$scope.books = []
	
	$http.get("/books.json").success (data)->
		$scope.books = data

	$scope.addBook = -> 
		$http.post("/books.json", $scope.newBook).success (data)->
			console.log "Book Saved"
			$scope.newBook = {}
			$scope.books.push(data)

	$scope.deleteBook = ->
		console.log @book	
		index = @$index
		$http.delete("/books/#{@book.id}.json" ).success (data)->
		$scope.books.splice(index,1)

])

BookApp.config(["$httpProvider", ($httpProvider)->
	$httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
	])