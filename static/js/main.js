jQuery(function($) {
    $('#test_button').on('click', function() {
        var xhr = $.ajax({
            method: 'POST',
            url: '/publish',
            headers: {
                'Content-Type': 'application/json',
            },
            data: JSON.stringify({
                lat: Number($('#lat').val()),
                lon: Number($('#lon').val()),
                radius: Number($('#radius').val()),
                message: $('#message').val()
            })
         });
         xhr.done(function() {
             console.log('OKKK');
         });
    });
});
