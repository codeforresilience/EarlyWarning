(function($) {
    $(function() {
        $('#test_button').on('click', function() {
            var xhr = $.ajax({
                method: 'POST',
                url: '/publish',
                data: JSON.stringify({
                    lat: $('#lat').val(),
                    lon: $('#lon').val(),
                    radius: $('#radius').val(),
                    message: $('#message').val()
                })
             });
             xhr.done(function() {
                 console.log('OKKK');
             });
            
        });
    });
})(jQuery);
