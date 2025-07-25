/**
 * WPComment Validate
 * @Since version 24.2
 * By: Najeeb Ahmad
 * Date: January 19, 2022
 **/
 
/*global jQuery wpcomment_get_element_value wpcomment_input_vars*/
 
const WPComment_Validate = {
 
    field_meta: wpcomment_input_vars.field_meta.filter(f => f.required === "on" ),
    passed: true,
    $wpcomment_input: jQuery('.wpcomment-input.wpcomment-required'),
    $wpcomment_input_texts: jQuery('.wpcomment-input.wpcomment-required.text, .wpcomment-input.wpcomment-required.email, .wpcomment-input.wpcomment-required.number,.wpcomment-input.wpcomment-required.quantityoption'),
    
    init : async () => {
        
        jQuery(document).bind('wpcomment_uploaded_file_removed', async function(e) {
            WPComment_Validate.validate_data()
            .then(WPComment_Validate.enable_button, WPComment_Validate.disable_button);
        });
        
        jQuery(document).bind('wpcomment_field_shown', async function(e) {
            WPComment_Validate.validate_data()
            .then(WPComment_Validate.enable_button, WPComment_Validate.disable_button);
        });
        
        jQuery(document).bind('wpcomment_field_hidden', async function(e) {
            WPComment_Validate.validate_data()
            .then(WPComment_Validate.enable_button, WPComment_Validate.disable_button);
        });
        
        jQuery(document).on('change', WPComment_Validate.$wpcomment_input,  async function(e){
            WPComment_Validate.validate_data()
            .then(WPComment_Validate.enable_button, WPComment_Validate.disable_button);
        });
        
        // keyup events for texts input e.g: text,email,number
        WPComment_Validate.$wpcomment_input_texts.keyup(async function(e){
            WPComment_Validate.validate_data()
            .then(WPComment_Validate.enable_button, WPComment_Validate.disable_button);
        });
        
        WPComment_Validate.validate_data()
        .then(WPComment_Validate.enable_button, WPComment_Validate.disable_button);
        
    },
    
    validate_data: () => {
        
        return new Promise( function(resolve, reject){
            
            // console.log(WPComment_Validate.field_meta);
            const invalid_fields = WPComment_Validate.field_meta.filter(f => !WPComment_Validate.field_has_valid_data(f) && !WPComment_Validate.is_field_hidden(f.data_name))
            const validate_result = invalid_fields.length > 0 ? false : true;
            
            return validate_result ? resolve() : reject(invalid_fields);
        });
    },
    
    is_field_hidden: (data_name) => {
        
        // console.log(data_name, jQuery(`.wpcomment-field-wrapper.${data_name}.wpcomment-c-hide`).length > 0);
       return jQuery(`.wpcomment-field-wrapper.${data_name}.wpcomment-c-hide`).length > 0;
    },
    
    /**
	 * When a variation is hidden.
	 */
	disable_button: (invalid_fields) => {
		const $form = jQuery('form.comment-form');
		$form
			.find( 'input[type="submit"]' )
			.prop('disabled', true);
	   // console.log('disabled', invalid_fields);
		WPComment_Validate.show_errors(invalid_fields);
	},
	
	enable_button: () => {
		const $form = jQuery('form.comment-form');
		$form
			.find( 'input[type="submit"]' )
			.prop('disabled', false);
	    
	    //hide error
	    jQuery('#wpcomment-error-container').html('');
	},
	
	show_errors: (invalid_fields) => {
	   // console.log(invalid_fields);
	    const $container = jQuery('#wpcomment-error-container').html('');
	    const $ul_container = jQuery('<ul/>').addClass('woocommerce-error').appendTo($container);
	    invalid_fields.map(f => $ul_container.append( `<li>${WPComment_Validate.get_message(f)}</li>`) );
	},
	
	get_message(field_meta){
	    
	    return field_meta.error_message !== "" ? `<b>${field_meta.title}</b> ${field_meta.error_message}` : `<b>${field_meta.title}</b> ${wpcomment_input_vars.validate_msg}`;
	},
	
	field_has_valid_data(field) {
        
        // console.log(field);
        const data_name = field.data_name;
        const wpcomment_type = field.type === 'imageselect' ? 'imageselect' : WPComment_Validate.get_input_dom_type(data_name);
        let element_value = '';
        
        switch (wpcomment_type) {
            case 'switcher':
            case 'radio':
                element_value = jQuery(`.wpcomment-input[data-data_name="${data_name}"]:checked`).length;
                return element_value !== 0;
                break;
            case 'palettes':
            case 'checkbox':
                element_value = jQuery('input[name="wpcomment[fields][' + data_name + '][]"]:checked').length;
                if( (field.min_checked && element_value < Number(field.min_checked) ) ||
                (field.max_checked && element_value > Number(field.max_checked) )
                ){
                    // console.log('no ok');
                    return false;
                }else{
                    return element_value !== 0;
                }
                break;
            case 'image':
                element_value = jQuery(`.wpcomment-input[data-data_name="${data_name}"]:checked`).length;
                if( (field.min_checked && element_value < Number(field.min_checked) ) ||
                (field.max_checked && element_value > Number(field.max_checked) )
                ){
                    // console.log('no ok');
                    return false;
                }else{
                    return element_value !== 0;
                }
                break;
            case 'imageselect':
                element_value = jQuery(`.wpcomment-input[data-data_name="${data_name}"]:checked`).length;
                // element_value = 0;
                return element_value !== 0;
                break;
            case 'fixedprice':
                var render_type = jQuery(`.wpcomment-input-${data_name}`).attr('data-input');
                if( render_type == 'radio' ){
                    element_value = jQuery(`.wpcomment-input[data-data_name="${data_name}"]:checked`).length;
                }else{
                    element_value = jQuery(`.wpcomment-input[data-data_name="${data_name}"]`).val().length;
                }
                return element_value !== 0;
                break;
    
            default:
                element_value = jQuery(`.wpcomment-input[data-data_name="${data_name}"]`).val() != null ? jQuery(`.wpcomment-input[data-data_name="${data_name}"]`).val().length : 0;
                return element_value !== 0;
                break;
        }
        
    },
    
    
    text_events(e) {
        console.log(e.target)        
    },
    
    get_input_dom_type(data_name) {

        // const field_obj = jQuery(`input[name="wpcomment[fields][${data_name}]"], input[name="wpcomment[fields][${data_name}[]]"], select[name="wpcomment[fields][${data_name}]"]`);
        const field_obj = jQuery(`.wpcomment-input[data-data_name="${data_name}"]`);
        const wpcomment_type = field_obj.closest('.wpcomment-field-wrapper').data('type');
        return wpcomment_type;
    }
	
}

WPComment_Validate.init();