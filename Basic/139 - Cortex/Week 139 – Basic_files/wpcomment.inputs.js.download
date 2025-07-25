/**
 * PPOM input scripts
 **/

"use strict"

/* global wpcomment_input_vars */

var wpcomment_bulkquantity_meta = '';
var wpcomment_pricematrix_discount_type = '';

jQuery(function($) {

    // Tooltip Init
    // $('.wpcomment-tooltip').powerTip({
    //     placement: 'n',
    //     smartPlacement: true,
    //     mouseOnToPopup: true
    // });

    // Remove Emoji from text input
    // $('.wpcomment-wrapper').on('input keyup', 'input[type="text"]', function(e) {

    //     const input_val = $(this).val();
    //     const new_val = input_val.replace(/([\u2700-\u27BF]|[\uE000-\uF8FF]|\uD83C[\uDC00-\uDFFF]|\uD83D[\uDC00-\uDFFF]|[\u2011-\u26FF]|\uD83E[\uDD10-\uDDFF])/g, '');
    //     $(this).val(new_val);
    // });



    // $('[data-toggle="tooltip"]').tooltip({container:'body', trigger:'hover'});
    
    if ($('.wpcomment-modals').length > 0) {
        $('.wpcomment-modals').appendTo('body');
    }

    wpcomment_init_js_for_wpcomment_fields(wpcomment_input_vars.field_meta);

});

// JS Init PPOM Inputs
function wpcomment_init_js_for_wpcomment_fields(wpcomment_fields) {
    
    
    // Fixed the form button issue
    if (wpcomment_fields && wpcomment_fields.length > 0) {
        const css_type = jQuery('form.cart').css('display');
        if (css_type === 'flex') {
            jQuery('form.cart').addClass('wpcomment-flex-controller');
        }
    }

    jQuery.each(wpcomment_fields, function(index, input) {

        // console.log(input.type);
        var InputSelector = jQuery("#" + input.data_name);

        // Applying JS on inputs
        switch (input.type) {

            // masking
            case 'text':
                if (input.input_mask == undefined || input.input_mask == '') break;
                InputSelector.inputmask();
                if (input.type === 'text' &&
                    input.input_mask !== '' &&
                    input.use_regex !== 'on') {
                    InputSelector.inputmask(input.input_mask);
                }
                break;


                // only allow numbers and periods in number fields
            case "number":
                InputSelector.bind("keydown keyup keypress", function(event) {
                    if (event.key === "Backspace" || event.key === "Delete" || event.key === "Tab" ||
                        (event.ctrlKey === true && event.key === "a") ||
                        (event.ctrlKey === true && event.key === "x") ||
                        (event.ctrlKey === true && event.key === "Backspace") ||
                        (event.which >= 48 && event.which <= 57) ||
                        (event.which >= 96 && event.which <= 105) ||
                        (event.key === "." && $(this).val().indexOf(".") <= 1)) {
                        // think happy thoughts :-)
                    }
                    else { event.preventDefault(); }
                }).bind("focus blur", function() {
                    if (typeof InputSelector.attr("max") !== 'undefined') {
                        if (parseFloat(InputSelector.val()) > parseFloat(InputSelector.attr("max"))) {
                            InputSelector.val(InputSelector.attr("max"));
                        }
                    }
                });
                break;

            case 'date':
                if (input.jquery_dp === 'on') {

                    InputSelector.datepicker("destroy");
                    InputSelector.datepicker({
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: input.date_formats.wpcomment_js_stripSlashes(),
                        yearRange: input.year_range,
                    });

                    if( input.past_dates === 'on' ){
                        InputSelector.datepicker('option', 'minDate', 0);
                    }
                    
                    if (typeof input.past_dates !== 'max_date') {
                        if (input.past_dates.length > 0) {
                            var max_date = input.max_date.trim();
                            InputSelector.datepicker('option', 'maxDate', max_date);
                        }
                    }

                    if (input.no_weekends === 'on') {
                        InputSelector.datepicker('option', 'beforeShowDay', jQuery.datepicker.noWeekends);
                    }
                }
                break;

            case 'image':

                var img_id = input.data_name;
                // Image Tooltip
                if (input.show_popup === 'on' && !wpcomment_input_vars.is_mobile) {
                    jQuery('.wpcomment-zoom-' + img_id).imageTooltip({
                        xOffset: 5,
                        yOffset: 5
                    });
                }

                // Data Tooltip
                // $(".pre_upload_image").tooltip({container: 'body'});
                break;
                // date_range
            case 'daterange':

                InputSelector.daterangepicker({
                    autoApply: (input.auto_apply == 'on') ? true : false,
                    locale: {
                        format: (input.date_formats !== '') ? input.date_formats : "YYYY-MM-DD"
                    },
                    showDropdowns: (input.drop_down == 'on') ? true : false,
                    showWeekNumbers: (input.show_weeks == 'on') ? true : false,
                    timePicker: (input.time_picker == 'on') ? true : false,
                    timePickerIncrement: (input.tp_increment !== '') ? parseInt(input.tp_increment) : '',
                    timePicker24Hour: (input.tp_24hours == 'on') ? true : false,
                    timePickerSeconds: (input.tp_seconds == 'on') ? true : false,
                    drops: (input.open_style !== '') ? input.open_style : 'down',
                    startDate: (input.start_date == '') ? false : input.start_date,
                    endDate: (input.end_date == '') ? false : input.end_date,
                    minDate: (input.min_date == '') ? false : input.min_date,
                    maxDate: (input.max_date == '') ? false : input.max_date,
                });
                break;

                // color: iris
            case 'color':

                InputSelector.css('background-color', input.default_color);
                var iris_options = {
                    'palettes': wpcomment_get_palette_setting(input),
                    'hide': input.show_onload == 'on' ? false : true,
                    'color': input.default_color,
                    'mode': input.palettes_mode != '' ? input.palettes_mode : 'hsv',
                    'width': input.palettes_width != '' ? input.palettes_width : 200,
                    change: function(event, ui) {

                        InputSelector.css('background-color', ui.color.toString());
                        InputSelector.css('color', '#fff');

                        // Getting Color Code for update price
                        InputSelector.val(ui.color.toString())
                    }
                }

                console.log(iris_options);

                InputSelector.iris(iris_options);

                // Following script is added to close picker 
                // when color is picked
                jQuery(document).click(function(e) {
                    if (!jQuery(e.target).is(".wpcomment-input.color, .iris-picker, .iris-picker-inner")) {
                        jQuery('.wpcomment-input.color').iris('hide');
                        return e;
                    }
                });

                jQuery('.wpcomment-input.color').click(function(event) {
                    jQuery('.wpcomment-input.color').iris('hide');
                    jQuery(this).iris('show');
                    return event;
                });
                break;

                // Palettes
            case 'palettes':

                const max_selected = parseInt(input.max_selected) || undefined;
                if (!max_selected) break;

                jQuery(document).on('click', `.wpcomment-palettes-${input.data_name} input.wpcomment-input`, function(e) {
                    if (jQuery(`.wpcomment-palettes-${input.data_name} input.wpcomment-input:checked`).length > max_selected) {
                        alert(`You can only select a maximum of ${max_selected} ${input.title} colors`);
                        e.preventDefault();
                        //   return false;
                    }
                });
                break;
                // Bulk quantity
            case 'bulkquantity':

                setTimeout(function() { jQuery('.quantity.buttons_added').hide(); }, 50);
                jQuery('form.cart').find('.quantity').hide();

                // setting formatter
                /*if ($('form.cart').closest('div').find('.price').length > 0){
                	wc_price_DOM = $('form.cart').closest('div').find('.price');
                }*/

                wpcomment_bulkquantity_meta = input.options;

                var min_quantity_value = jQuery('.wpcomment-bulkquantity-qty').val();

                // Starting value
                wpcomment_bulkquantity_price_manager(min_quantity_value);
                break;

            case 'pricematrix':

                wpcomment_pricematrix_discount_type = input.discount_type;

                if (input.show_slider === 'on' && jQuery('.wpcomment-range-slide').length > 0) {
                    var slider = new Slider('.wpcomment-range-slide', {
                        formatter: function(value) {
                            jQuery.event.trigger({
                                type: "wpcomment_range_slider_updated",
                                qty: value,
                                time: new Date()
                            });
                            return wpcomment_input_vars.text_quantity + ": " + value;
                        }
                    });
                }

                jQuery('.wpcomment-range-bs-slider').on('change', function(e) {
                    jQuery.event.trigger({
                        type: "wpcomment_range_slider_updated",
                        qty: jQuery(this).val(),
                        time: new Date()
                    });
                });
                break;
            case 'quantities':
                var enable_plusminus = input.enable_plusminus;
                var field_selectot = jQuery('.wpcomment-input-' + input.data_name);
                if (enable_plusminus == 'on') {
                    jQuery('.wpcomment-quantity', field_selectot).niceNumber();
                }
                break;

        }


    });
}



function wpcomment_get_palette_setting(input) {

    var palettes_setting = false;
    // first check if palettes is on
    if (input.show_palettes === 'on') {
        palettes_setting = true;
    }
    if (palettes_setting && input.palettes_colors !== '') {
        palettes_setting = input.palettes_colors.split(',');
    }

    return palettes_setting;
}

function wpcomment_get_field_type_by_id(field_id) {

    var field_type = '';
    jQuery.each(wpcomment_input_vars.field_meta, function(i, field) {

        if (field.data_name === field_id) {
            field_type = field.field_type;
            return;
        }
    });

    return field_type;
}

// Get all field meta by id
function wpcomment_get_field_meta_by_id(field_id) {

    var field_meta = '';
    jQuery.each(wpcomment_input_vars.field_meta, function(i, field) {

        if (field.data_name === field_id) {
            field_meta = field;
            return;
        }
    });

    return field_meta;
}

function wpcomment_get_field_meta_by_type(type) {

    var field_meta = Array();
    jQuery.each(wpcomment_input_vars.field_meta, function(i, field) {

        if (field.type === type) {
            field_meta.push(field);
            return;
        }
    });

    return field_meta;
}

String.prototype.wpcomment_js_stripSlashes = function() {
    return this.replace(/\\(.)/mg, "$1");
}