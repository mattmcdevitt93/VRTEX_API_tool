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
        window.scrollTo(0,document.body.scrollHeight);
        Module.toolbar_resize();
    });

    $( "#newPost" ).click(function() {
        console.log('Toggle New Topic')
        $( "#postform" ).toggle();
        window.scrollTo(0,document.body.scrollHeight);
        Module.toolbar_resize();
    });

    $( window ).resize(function() {
        Module.toolbar_resize();
    });

    $( window ).scroll(function() {
        Module.toolbar_resize();
    });


    $( "#required_group_form" ).change(function() {
        Module.topic_form_toggle();
    });

    Module.inherit_parent_width_check = null;
}

Module.topic_form_toggle = function () {
    var text = $("#required_group_form :selected").text();
    console.log('Topic form check: ' + text);
    if (text === "Require Group") {
        $( "#required_group_entry" ).show();
    } else {
        $( "#required_group_entry" ).hide();
    };
};

Module.toolbar_resize = function () {
    console.log('resize')
    var c = $('#yield').height();
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

Module.inherit_parent_width = function (id, parent) {
    // Check Bindings for reset
    var width = $( parent ).width();
    if (Module.inherit_parent_width_check == null) {
        Module.inherit_parent_width_check = width
    };
    $( id ).css("max-width", Module.inherit_parent_width_check);
    // console.log('resize frame' + Module.inherit_parent_width_check);
};

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

Module.clock_offset = function (offset) {

    var display = $('#Local_time')

    var x = setInterval(function() {
        var time = new Date().getTime()
        time = time - (offset*1000)
        var t = moment(time).format("dddd, MMMM Do YYYY, h:mm:ss a");
        display.text(t);
    }, 1000);

}

Module.UTC_clock = function () {

    var display = $('#UTC_clock')

    var x = setInterval(function() {
        var time = new Date().getTime()
        var t = moment(time).format("dddd, MMMM Do YYYY, h:mm:ss a");
        display.text(t);
        // console.log("Tick!")
    }, 1000);
}

Module.countdown_timer = function (duration, display) {

    var completion = new Date().getTime() + duration * 1000;

    var x = setInterval(function() {

      var current_time = new Date().getTime();
      var distance = completion - current_time
      var days = Math.floor(distance / (1000 * 60 * 60 * 24));
      var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      var seconds = Math.floor((distance % (1000 * 60)) / 1000);

      display.text(days + " Days " + hours + " Hours, "
          + minutes + " Minutes " + seconds + " Seconds");

      // console.log(distance)
      if (distance < 0) {
        clearInterval(x);
        display.text("EVENT STARTED");
    }
    }, 1000);
}