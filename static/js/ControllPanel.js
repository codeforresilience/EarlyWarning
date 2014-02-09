jQuery(function($) {
    var sending = false;
    $('#publish_button').on('click', function() {
        if (sending) {
            return;
        }
        sending = true;
        $('#publish_button').text('Wait...');

        var circle = window.controller.circle;
        var xhr = $.ajax({
            method: 'POST',
            url: '/publish',
            headers: {
                'Content-Type': 'application/json',
            },
            data: JSON.stringify({
                lat: Number(circle.center.d),
                lon: Number(circle.center.e),
                radius: Number(circle.radius),
                message: $('#message').val()
            })
         });
         xhr.done(function() {
             alert('Message succesfully published');
            $('#publish_button').text('Publish');
             sending = false;
         });
         xhr.error(function() {
            $('#publish_button').text('Publish');
             sending = false;
         });
    });

    function update_latlon(loc) {
        $('#lat').text(Math.floor(loc.lat * 100)/100);
        $('#lon').text(Math.floor(loc.lon * 100)/100);
    }

    function update_radius(val) {
        $('#radius').text(Math.floor(val/1000));
    }

    window.controller.on_center_changed = function(loc) {
        update_latlon({
            lat: loc.d,
            lon: loc.e
        });
    };
    window.controller.on_radius_changed = function(radius) {
        update_radius(radius);
    };

    // Initial
    update_latlon({
        lat: 22.74,
        lon: 90.75
    });
    update_radius(100000);

});
