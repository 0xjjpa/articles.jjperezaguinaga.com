title: '[AngularJS 1.x] HTML5 Autocomplete'
tags:
  - angularjs
  - autocomplete
  - datalist
  - html5
  - javascript
id: 338
categories:
  - Developer Stories
date: 2013-09-18 00:25:46
---

Autocomplete is quite a common UX pattern; for many years we have been using it through browsers and mobile applications, but because of the lack of browsers support, most of the time we have to use Javascript libraries to perform the task.

Autocomplete form used in [Airbnb](https://airbnb.com) ![AirBnb](https://assets.jjperezaguinaga.com/articles/v1/angularjs-html5-autocomplete/airbnb-autocomplete.png)

In cases where Google APIs can provide the information, using their libraries is quite a good option. The libraries perform safe XHR calls through JSONP and load dynamically a set of entries that is then handled by custom CSS in order to position the entries in a location that makes it look like an autocomplete. Most javascript libraries follow the same approach.<!--more-->

## Introducing Datalist

The `datalist` tag allows modern browsers to display a native like autocomplete. Although the support is not the [best around](http://caniuse.com/datalist), there's some [polyfills](http://css-tricks.com/relevant-dropdowns-polyfill-for-datalist/) that can make it work.

Native Autocomplete in Chrome ![Native Autofill](https://assets.jjperezaguinaga.com/articles/v1/angularjs-html5-autocomplete/native-chrome-autocomplete.png)

## How to use Datalist?

In order to use `datalist`, you need an `input` tag that allows you to specity a `list`attribute. The value of this attribute is the `id` of the `datalist` element. A datalist contains a set of `option` tags (the same way the `select` tag) which will then be displayed to the user as he/she types. The style of the dropdown depends on the browser.

## Real case usage: Search Feature

We will implement a search feature for flight destinations in different countries using`datalist` and AngularJS. This requires three key elements in order to get it work:

1.  The ability to load a data set of entries to search
2.  Reload the fetched entries depending on user's input
3.  React to user's actions in order to perform #1

### Fetching the set of entries

This can be easily done with an AngularJS service and promises. Here's a sample code:

```
        .service('Geolocator', function($q, $http){
          var API_URL = 'http://jjperezaguinaga.webscript.io/waymate?term=';
          this.searchFlight = function(term) {
            var deferred = $q.defer();
         $http.get(API_URL+term).then(function(flights){
           var _flights = {};
           var flights = flights.data;
           for(var i = 0, len = flights.length; i  len; i++) {
             _flights[flights[i].name] = flights[i].country;
           }
              deferred.resolve(_flights);
            }, function() {
              deferred.reject(arguments);
            });
            return deferred.promise;
          } 
        })
```

In this case we have an API endpoint that will receive a `term` to search. This can be one character or an entire city. This will return a bunch of possible flight destinations that will be resolved through a promise in the form of a map.

With a controller, we can retrieve this service and tie it up to our view scope:

```
     .controller('myController', function($scope, Geolocator) {
          $scope.selectedCountry = null;
          $scope.countries = {};
          $scope.searchFlight = function(term) {
            Geolocator.searchFlight(term).then(function(countries){
              $scope.countries = countries;
            });
          }
        })
```

In our view we will use the `ng-options` directive. I tried using `ng-repeat` for the`option` tags, but it seems that AngularJS doesn't render it properly. The best way was to use the fallback option (a `select` tag inside the datalist) with the `display: none;` style in order to render the options properly. Note that `countries` is a map, hence the `(k,v)`. I'll explain the `keyboard-poster` directive in the next section.

```
input type="text" keyboard-poster post-function="searchFlight" name="first_name" placeholder="Zurich, Switzerland" list="_countries" style='margin-bottom: 100px'
                datalist id="_countries"
                 select style="display: none;" id="_select" name="_select" ng-model='selectedCountry' ng-options='k as v for (k,v) in countries'/select
    /datalist
```

### Reload the fetched entries depending on user's input

In order to reload the user actions, we will use an AngularJS directive. This will call a scoped (from our controller) function under the `post-function` attribute. Since our function is `searchFlight`, we can then reload the `datalist` source whenever we want. That part of the directive looks something like this:

```  
    var model = $parse(attrs.postFunction);
      var poster = model(scope);
      poster(angular.element(element).val());
```

Where `element` is the `input` tag that handles the `keyboard-poster` directive. In this case, what we do is run the poster function (parsed from the attribute in the directive, in our case `searchFlight` from our controller) with the `input` value (whatever the user inputs).

### React to user's actions

Here's the most problematic part of all, followed by the question "To which action do we react to?". After trying many things (click, onfocus, keypress) I resorted to our lovely `input` event. This will finish our directive and then trigger the action.

```
.directive('keyboardPoster', function($parse, $timeout){
      var DELAY_TIME_BEFORE_POSTING = 0;
      return function(scope, elem, attrs) {

        var element = angular.element(elem)[0];
        var currentTimeout = null;

        element.oninput = function() {
          var model = $parse(attrs.postFunction);
          var poster = model(scope);

          if(currentTimeout) {
            $timeout.cancel(currentTimeout)
          }
          currentTimeout = $timeout(function(){
            poster(angular.element(element).val());
          }, DELAY_TIME_BEFORE_POSTING)
        }
      }
    })
```

The directive triggers `oninput` and creates a `timeout`; this allows the user to write a little bit before loading your source data. This can be done in order to avoid heavy load in your database, in which case you would bump up the`DELAY_TIME_BEFORE_POSTING` and use some kind of feedback (maybe a spinner inside the `input` tag) to tell the user that the loading is being done.

## Conclusion

<p data-height="568" data-theme-id="1773" data-slug-hash="Dmspr" data-default-tab="result" data-user="jjperezaguinaga" class='codepen'>See the Pen <a href='http://codepen.io/jjperezaguinaga/pen/Dmspr/'>[AngularJS] HTML5 Autocomplete</a> by jjperezaguinaga (<a href='http://codepen.io/jjperezaguinaga'>@jjperezaguinaga</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

Although in it's infancy, I believe modern applications can rely on `datalist` to deliver a somewhat native experience for an autocomplete input field. Some drawbacks include styling the displayed entry list as well as to have full control on when to display the list. I had some issues displaying the list, specially when my source (in my case [Webscript.io](https://www.webscript.io/) and [Waymate](https://www.waymate.de/en/searches)) would take some time to deliver the new entries. Some times it needed up to two characters to display the list, but mainly because it wasn't loaded yet; this can confuse the user, making him think that there are no entries for his input. A good approach to solve this is to use the aforementioned loading spinner.

