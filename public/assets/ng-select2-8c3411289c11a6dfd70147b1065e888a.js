angular.module("ui.select2",[]).value("uiSelect2Config",{}).directive("uiSelect2",["uiSelect2Config","$timeout",function(e,t){var i={};return e&&angular.extend(i,e),{require:"ngModel",compile:function(e,n){var l,a,u,r=e.is("select"),c=angular.isDefined(n.multiple);return e.is("select")&&(a=e.find("option[ng-repeat], option[data-ng-repeat]"),a.length&&(u=a.attr("ng-repeat")||a.attr("data-ng-repeat"),l=jQuery.trim(u.split("|")[0]).split(" ").pop())),function(e,a,u,o){var s=angular.extend({},i,e.$eval(u.uiSelect2)),d=function(e){var t;return s.simple_tags?(t=[],angular.forEach(e,function(e){t.push(e.id)})):t=e,t},g=function(e){var t=[];return e?(s.simple_tags?(t=[],angular.forEach(e,function(e){t.push({id:e,text:e})})):t=e,t):t};if(r?(delete s.multiple,delete s.initSelection):c&&(s.multiple=!0),o&&(e.$watch(n.ngModel,function(e,t){e&&e!==t&&o.$render()},!0),o.$render=function(){r?a.select2("val",o.$viewValue):s.multiple?a.select2("data",g(o.$viewValue)):angular.isObject(o.$viewValue)?a.select2("data",o.$viewValue):o.$viewValue?a.select2("val",o.$viewValue):a.select2("data",null)},l&&e.$watchCollection(l,function(e){e&&t(function(){a.select2("val",o.$viewValue),a.trigger("change")})}),o.$parsers.push(function(e){var t=a.prev();return t.toggleClass("ng-invalid",!o.$valid).toggleClass("ng-valid",o.$valid).toggleClass("ng-invalid-required",!o.$valid).toggleClass("ng-valid-required",o.$valid).toggleClass("ng-dirty",o.$dirty).toggleClass("ng-pristine",o.$pristine),e}),!r&&(a.bind("change",function(){e.$$phase||e.$apply(function(){o.$setViewValue(d(a.select2("data")))})}),s.initSelection))){var v=s.initSelection;s.initSelection=function(e,t){v(e,function(e){o.$setViewValue(d(e)),t(e)})}}a.bind("$destroy",function(){a.select2("destroy")}),u.$observe("disabled",function(e){a.select2("enable",!e)}),u.$observe("readonly",function(e){a.select2("readonly",!!e)}),u.ngMultiple&&e.$watch(u.ngMultiple,function(){a.select2(s)}),t(function(){a.select2(s),a.val(o.$viewValue),o.$render(),s.initSelection||r||o.$setViewValue(d(a.select2("data")))})}}}}]);