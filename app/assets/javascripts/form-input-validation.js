$(function() {
    // only allow numbers and dashes in phone field
    $('input[type="tel"]').keypress(function(e) {
        var key = e.which || e.key;
        if (((key < 48 || key > 57) && key != 45 && key != 8 && key != 127) || e.shiftKey) { // (/[^-1234567890]/.test(char) && e.keyCode != 8) {
            if (e.preventDefault) e.preventDefault();
            e.returnValue = false;
            return false;
        }
    });

    // only allow letters and spaces in name fields
    $('#employee_first_name, #employee_middle_initial, #employee_last_name').on('keydown keyup', function(e) {
        var key = String.fromCharCode(e.which) || e.key;
        if (/[^a-zA-Z ]/.test(key) && e.which != 8 && e.which != 127) {
            e.preventDefault();
            return false;
        }
    });

    // show custodian account field if account type "custodian" selected
    $('#employee_account_attributes_account_type_id').change(function() {
        if ($(this).val().toString() === '2') {
            $('#employee_custodians_attributes_0_custodian_account_id_input').css('display', 'block');
        } else {
            $('#employee_custodians_attributes_0_custodian_account_id_input').css('display', 'none');
        }
    });
});