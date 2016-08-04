'use strict'
var Module = Module || {};


$(document).ready(function() {
	console.log('Ready!')
});

Module.toolbar_slide = function () {
	// $('#toolbar-switch').click(function() {
		if( $('#toolbar').hasClass("hidden")) {
    	// console.log('Slide Out')
    	// $('#toolbar').animate({"width": '+=110'});
        // $('#toolbar').animate({"margin-left": '+=110'});
        $('#toolbar').animate({"margin-left": '+=220'});
    	$('#toolbar').removeClass("hidden");
    } else {
    	// console.log('Slide In')
    	// $('#toolbar').animate({"width": '-=110'});
        // $('#toolbar').animate({"margin-left": '-=110'});
        $('#toolbar').animate({"margin-left": '-=220'});
    	$('#toolbar').addClass("hidden"); }
    // });
}

Module.toolbar_rotate = function () {
	console.log('rotate')
	if( $('#toolbar-switch').hasClass("active")) {
    	$('#toolbar-switch').rotate({ animateTo:-25, duration: 500})
    	$('#toolbar-switch').removeClass("active");
    } else {
    	$('#toolbar-switch').rotate({ animateTo:0, duration: 500})
    	$('#toolbar-switch').addClass("active"); }
}
