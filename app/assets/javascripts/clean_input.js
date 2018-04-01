$(function() {
    var regExp = /[a-z]/i;
    $('[type="tel"]').on('keydown keyup', function(e) {
        var value = String.fromCharCode(e.which) || e.key;

        // No letters
        if (regExp.test(value)) {
            e.preventDefault();
            return false;
        }
    });
});