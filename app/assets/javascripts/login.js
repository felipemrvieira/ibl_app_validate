//= require bootstrap

$(document).ready(function () {
    $('input[type="password"]').on('focus', function () {
        $('*').addClass('password');
        }).on('focusout', function () {
        $('*').removeClass('password');
    });
});

// $(document).ready(function () {

//     var angle = 0;
//     var test = $('main');
//     function changeAngle() {
//         angle = (angle + 1) % 360;
//         test.css({
//             'background': '-moz-linear-gradient(' + angle + 'deg ,#03b8cb 1%,#5fdb85 50%,#bcff3f 100%)',
//             'background': '-webkit-linear-gradient(' + angle + 'deg ,#03b8cb 1%,#5fdb85 50%,#bcff3f 100%)',
//             'background': 'linear-gradient(' + angle + 'deg ,#03b8cb 1%,#5fdb85 50%,#bcff3f 100%)'

//             // 'background': '-webkit-linear-gradient(' + angle + 'deg ,#03b8cb 1%,#5fdb85 50%,#bcff3f 100%)'

//         });
//     }
//      setInterval(changeAngle, 50);
// });