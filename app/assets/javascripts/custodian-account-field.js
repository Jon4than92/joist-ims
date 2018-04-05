$(function() {
    // show custodian account field if account type "custodian" selected
    $('#employee_account_attributes_account_type_id').change(function() {
        if ($(this).val() === '2') {
            $('#employee_custodian_account_ids_input').css('display', 'block');
        } else {
            $('#employee_custodian_account_ids_input').css('display', 'none');
        }
    });

    // hide custodian account field on load if account type "custodian" not selected
    if ($('#employee_account_attributes_account_type_id').val() === '') {
        $('#employee_custodian_account_ids_input').css('display', 'none');
    }

    // show custodian account field on load if account type "custodian" selected
    if ($('#employee_account_attributes_account_type_id').val() === '2') {
        $('#employee_custodian_account_ids_input').css('display', 'block');
    }
});