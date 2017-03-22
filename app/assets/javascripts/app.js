'use strict'
var Module = Module || {};


$(document).ready(function() {
	console.log('Ready!')
    Module.bindings();
    Module.toolbar_resize();
    $(document).foundation();
});

Module.bindings = function () {

$('#password_update').bind('input', function() { 
    $('#password_confirm').removeClass("hidden")
    $('#password_fields').addClass("password_border")
});

$( "#newGroup" ).click(function() {
    console.log('Toggle New Group')
    $( "#group_form" ).toggle();
});

$( "#newTopic" ).click(function() {
    console.log('Toggle New Topic')
    $( "#topicform" ).toggle();
});

$( "#newPost" ).click(function() {
    console.log('Toggle New Topic')
    $( "#postform" ).toggle();
});

$( window ).resize(function() {
    Module.toolbar_resize();
});

$( window ).scroll(function() {
    Module.toolbar_resize();
});

}

Module.toolbar_resize = function () {
    console.log('resize')
    var c= $('#yield').height();
    var h = $(window).height();
    var n = 0
    // console.log(h, c)
    if (h < c) {
        n = c
    } else {
        n = h
    };
    $('#toolbar').height(n);
}

Module.toolbar_slide = function () {
	// $('#toolbar-switch').click(function() {
	if( $('#toolbar').hasClass("toolbar-hidden")) {
    	// console.log('Slide Out')
        $('#toolbar').animate({"margin-left": '+=220'});
        $('#yield').animate({"width": '-=220'});
        $('#toolbar').removeClass("toolbar-hidden");
    } else {
    	// console.log('Slide In')
        $('#toolbar').animate({"margin-left": '-=220'});
        $('#yield').animate({"width": '+=220'});
        $('#toolbar').addClass("toolbar-hidden"); }

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

Module.index_filter = function (state) {
    // console.log('Sort by ' + state)
    if (Module.index_filter_state === state) {
        state = 'reset'
        $('#success-badge').removeClass("inactive");
        $('#alert-badge').removeClass("inactive");
        $('#warning-badge').removeClass("inactive");
        $('#default-badge').removeClass("inactive");
    } else if (state === 'valid') {
        $('#success-badge').removeClass("inactive");
        $('#alert-badge').addClass("inactive");
        $('#warning-badge').addClass("inactive");
        $('#default-badge').addClass("inactive");
    } else if (state === 'error') {
        $('#success-badge').addClass("inactive");
        $('#alert-badge').removeClass("inactive");
        $('#warning-badge').addClass("inactive");
        $('#default-badge').addClass("inactive");
    } else if (state === 'warning') {
        $('#success-badge').addClass("inactive");
        $('#alert-badge').addClass("inactive");
        $('#warning-badge').removeClass("inactive");
        $('#default-badge').addClass("inactive");
    } else if (state === 'incoming') {
        $('#success-badge').addClass("inactive");
        $('#alert-badge').addClass("inactive");
        $('#warning-badge').addClass("inactive");
        $('#default-badge').removeClass("inactive");
    };
    Module.index_filter_state = state;
    // console.log(state)
    var list = $( ".index_content" ).find( ".index_entry" )
    for (var i = 0; i < list.length; i++) {
        // console.log(list[i].getAttribute('id'))
        if ($('#' + list[i].getAttribute('id')).hasClass(Module.index_filter_state) === false && Module.index_filter_state !== 'reset') {
            $('#' + list[i].getAttribute('id')).addClass("hidden");
        } else {
            $('#' + list[i].getAttribute('id')).removeClass("hidden");
        }
    }
}
