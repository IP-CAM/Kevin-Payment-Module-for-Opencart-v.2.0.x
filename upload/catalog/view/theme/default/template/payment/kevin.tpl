<?php if ($kevin_instr) { ?> 
	<h2><?php echo $kevin_instr_title; ?></h2>
	<div class="well well-sm"><p><?php echo $kevin_instr; ?></p></div>
<?php } ?>
<div id="kevin-container">
<?php if ($text_sandbox_alert) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $text_sandbox_alert; ?> 
     <!-- <button type="button" class="close" data-dismiss="alert">&times;</button>-->
    </div>
<?php } ?>
<?php if ($error_currency) { ?> 
<div class="alert-currency"></div>  
<?php } ?>
<div class="alert-bank"></div> 
<?php if ($error_bank_missing) { ?> 	
<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_bank_missing; ?><button type="button" class="close" data-dismiss="alert">&times;</button></div>
<?php } ?>	
<div class="bank-container">
	
	<ul class="list-unstyled row kevin-search-list"> 
		<li class="col-sm-6">
		<div>
          <div id="kevin-select-country" class="form-group input-group input-group-sm">
            <label class="input-group-addon" for="input-country"><?php echo $text_countries; ?></label>
            <select name="country_id" id="input-country" class="form-control" >
			  <option value="" disabled="disabled" selected="selected"><?php echo $text_select_country; ?></option>
              <?php foreach ($countries as $country) { ?>
              <?php if ($country['iso_code_2'] == $current_country_code) { ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php } else { ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php } ?>
              <?php } ?>
            </select>
          </div>
        </div>
		</li>
		<li class="col-sm-6">
	<div id="kevin-bank-search">
	<div ><div id="search" class="input-group input-group input-group-sm">
  		<input type="text" id="country-code" name="search_bank" value="" data-country_code="<?php echo $current_country_code; ?>" placeholder="<?php echo $help_serch_bank; ?>" class="form-control input-group-sm" >
		<label class="input-group-addon" for="country-code" data-toggle="tooltip" title="<?php echo $button_search; ?>"><i class="fa fa-search"></i> </label>
  		<!--<span class="input-group-btn">
   		<button type="button"  disabled="disabled" class="btn btn-default btn-sm"><i class="fa fa-search"></i></button>
  		</span>-->
	</div> 
	</div>	

	</div>
	</li>
	</ul>
	
	
<div id="kevin-payment">	
	<ul class="list-unstyled row li-grid"> 
		<?php foreach ($payment_methods as $payment_method) { ?>	
			<?php if ($payment_method == 'card') { ?>	
				<li class="col-md-2 col-sm-4 col-xs-12 "> 
				<p class="card-grid">
					 <input type="image" src="<?php echo $credit_card_icon; ?>" alt="Credit &#47; Debit carrd" title="Credit &#47; Debit carrd" id="card-selected" class="payment-card card-logo card-grid-img img-responsive" onclick="return selectPayment('card');" />
					<?php if ($bank_name_enable) { ?>
					<span class="cardgrid-title title-color-card"><?php echo $text_card_name; ?></span>
					<?php } else { ?>
					<span class="bankgrid-title title-color-card">&nbsp;</span>
					<?php } ?>
				</p>
			   </li>
	
			<form id="kevin_form-<?php echo $payment_method; ?>" action="<?php echo $action; ?>&bankId=<?php echo $payment_method; ?>&payment_method=<?php echo $payment_method; ?>" enctype="multipart/form-data" method="POST">
				<input  type="hidden" name="bankId" value="<?php echo $payment_method; ?>"/>
			</form>
			<?php } ?>
			<?php if ($payment_method == 'bank') { ?>	
				<?php foreach ($banks as $bank) { ?>
				<li class="col-md-2 col-sm-4 col-xs-12 ">
				<p class="bank-grid">
					 <input type="image" src="<?php echo $bank['imageUri']; ?>" alt="<?php echo $bank['name']; ?>" title="<?php echo $bank['name']; ?>" id="bank-selected" class="payment-<?php echo $bank['id']; ?> bank-logo bank-grid-img img-responsive" onclick="return selectPayment('<?php echo $bank['id']; ?>');"/>
					<?php if ($bank_name_enable) { ?>
					<span class="bankgrid-title title-color-<?php echo $bank['id']; ?>"><?php echo $bank['name']; ?></span>
					<?php } else { ?>
					<span class="bankgrid-title title-color-<?php echo $bank['id']; ?>">&nbsp;</span>
					<?php } ?>
				</p>
				</li>

				<form id="kevin_form-<?php echo $bank['id']; ?>" action="<?php echo $action; ?>&bankId=<?php echo $bank['id']; ?>&payment_method=<?php echo $payment_method; ?>" enctype="multipart/form-data" method="POST">
				   <input  type="hidden" name="bankId" value="<?php echo $bank['id']; ?>"/>
				</form>
				<?php } ?>
			<?php } ?>
		<?php } ?>
	</ul>	
</div>
</div>
</div>
<div class="buttons">
    <div class="pull-right">
        <input  type="button"  value="<?php echo $button_confirm; ?>" id="button-confirm" class="btn btn-primary"  data-loading-text="<?php echo $text_loading; ?>" />
    </div>
</div>

<script type="text/javascript"><!--
	
	var windowWidth = $(window).width();
	function scrollUp() {
		if (windowWidth < 1024) {
			$('html, body').animate({
				scrollTop: $("#kevin-container").offset().top + (-50)
			}, 200);
		}
	}
		 
	$(document).ready(function(){ 
		window.selectPayment = selectPayment;

		$("#bank-selected, #card-selected").click(function(event) {	
			event.preventDefault();
		});
	});

	var currency = '<?php echo $currency ? $currency : 0; ?>';
	var error_currency = '<?php echo $error_currency ? $error_currency : ''; ?>';
	var error_bank = '<?php echo $error_bank ? $error_bank : ''; ?>';
	//$('#button-confirm, #quick-checkout-button-confirm').prop('disabled', true);
	function selectPayment(bankId) {
		//event.preventDefault();
		$('.bankgrid-title, .cardgrid-title').css({'color': ''});
		$('.bank-logo, .card-logo').css({'border': ''});
		$('.payment-' + bankId).css({'border': 'solid 2px #26a5d6'});
		$('.title-color-' + bankId).css({'color': '#26a5d6'});
		$('#button-confirm').attr('data-id', bankId);
		//$('#button-confirm, #quick-checkout-button-confirm').prop('disabled', false);
		$('.alert-bank').children().eq(0).remove();
		$('#quick-checkout-button-confirm').button('reset');
		return false;
	}
		
	$('#button-confirm').on('click', function(event) {
		event.preventDefault();
		$('.alert-currency').children().eq(0).remove();
		$('.alert-bank').children().eq(0).remove();
		var bankId = $(this).attr('data-id');
		
		if (!currency) {

			scrollUp();
			$('.alert-currency').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + error_currency + '<button type="button" class="close" data-dismiss="alert">&times;</button>');
		} else if (!bankId) {

			scrollUp();
			$('#quick-checkout-button-confirm').button('reset');
			$('.alert-bank').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + error_bank + '<button type="button" class="close" data-dismiss="alert">&times;</button>');
			
		} else {
			$('#kevin_form-'+bankId).submit();
		}
    });		
//--></script>
 
<script type="text/javascript"><!--

$('input[name=\'search_bank\']').autocomplete({
	//'minLength': 3,	
	'source': function(request, response) {
		var country_code = $('#country-code').data('country_code');
		//console.log(request);
		$.ajax({
			url: 'index.php?route=payment/kevin/autocomplete&country_code=' + country_code + '&filter_name=' +  encodeURIComponent(request),
			dataType: 'json',
			success: function(json) {

				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['id'],
						name: item['name'],
						id: item['id'],
						country_code: item['country_code'],
						banks: item['banks'],
						imageUri: item['imageUri']
					}
				}).slice(0, 5));
				
			}
		});
	},
	'select': function(item) {
	//	var item = val['item'];
		//console.log(item['banks']);
	if (item['banks']) {
		
		html3 = '<ul class="list-unstyled row li-grid">'; 
		<?php foreach ($payment_methods as $payment_method) { ?>	
			<?php if ($payment_method == 'card') { ?>		
		html3 += '<li class="col-md-2 col-sm-4 col-xs-12 ">'; 
    	html3 += '<p class="card-grid">';
		html3 += '<input type="image" src="<?php echo $credit_card_icon; ?>" alt="Credit &#47; Debit carrd" title="Credit &#47; Debit carrd" id="card-selected" class="payment-card card-logo card-grid-img img-responsive" onclick="return selectPayment(\'card\');" />';
		<?php if ($bank_name_enable) { ?>
		html3 += '<span class="cardgrid-title title-color-card"><?php echo $text_card_name; ?></span>';
		<?php } else { ?>
		html3 += '<span class="bankgrid-title title-color-card">&nbsp;</span>';
		<?php } ?>
		html3 += '</p>';
   		html3 += '</li>';
	
		html3 += '<form id="kevin_form-<?php echo $payment_method; ?>" action="<?php echo $action; ?>&bankId=<?php echo $payment_method; ?>&payment_method=<?php echo $payment_method; ?>" enctype="multipart/form-data" method="POST"><input  type="hidden" name="bankId" value="<?php echo $payment_method; ?>"/>';
	  	html3 += '</form>';

			<?php } ?>
	
			<?php if ($payment_method == 'bank') { ?>	

		for (i = 0; i < item['banks'].length; i++) {
			if (item['banks'][i]['id'] == item['id'] ) {

		html3 += '<li class="col-md-2 col-sm-4 col-xs-12 ">';
    	html3 += '<p class="bank-grid">';
        html3 += '<input type="image" src="' + item['banks'][i]['imageUri'] + '" alt="' + item['banks'][i]['name'] + '" title="' + item['banks'][i]['name'] + '" id="bank-selected" class="payment-' + item['banks'][i]['id'] + ' bank-logo bank-grid-img img-responsive" onclick="return selectPayment(\'' + item['banks'][i]['id'] + '\');"/>';
		<?php if ($bank_name_enable) { ?>
		html3 += '<span class="bankgrid-title title-color-' + item['banks'][i]['id'] + '">' + item['banks'][i]['name'] + '</span>';
		<?php } else { ?>
		html3 += '<span class="bankgrid-title title-color-' + item['banks'][i]['id'] + '">&nbsp;</span>';
		<?php } ?>
		html3 += '</p></li>';
    

		html3 += '<form id="kevin_form-' + item['banks'][i]['id'] + '" action="<?php echo $action; ?>&bankId=' + item['banks'][i]['id'] + '&payment_method=<?php echo $payment_method; ?>" enctype="multipart/form-data" method="POST"><input  type="hidden" name="bankId" value="' + item['banks'][i]['id'] + '" />';
	   	html3 += '</form>';
			
 			}
		}
												  
		<?php } ?>
	<?php } ?>		
		html3 += '</ul>';	
		 $('#kevin-payment').html(html3);
		 $('#button-confirm').removeAttr('data-id');
		
		
		$('.alert-bank').children().eq(0).remove();
	} else {
		$('#kevin-payment').html('');
	}
		$('input[name=\'search_bank\']').val(item['name']);
	}
});
	
//--></script>


<script type="text/javascript"><!--
$('select[name=\'country_id\']').on('change', function(e) {
	e.preventDefault();
	$('.alert-bank').children().eq(0).remove();
	$('#button-confirm').removeAttr('data-id');
    var country_id = this.value;
	if (country_id) {
	//	$('select[name=\'country_id\']').prop('disabled', true);
		$.ajax({
			url: 'index.php?route=payment/kevin/selectCountry&country_id=' + country_id,
			dataType: 'json',
			beforeSend: function() {

			},
			complete: function() {
		//		$('.fa-spin').remove();
			},
			success: function(json) {
				
		
			//var payment_method = json['payment_methods'];
				
		html = '<ul class="list-unstyled row li-grid">'; 
		<?php foreach ($payment_methods as $payment_method) { ?>	
			<?php if ($payment_method == 'card') { ?>		
		html += '<li class="col-md-2 col-sm-4 col-xs-12 ">'; 
    	html += '<p class="card-grid">';
		html += '<input type="image" src="<?php echo $credit_card_icon; ?>" alt="Credit &#47; Debit carrd" title="Credit &#47; Debit carrd" id="card-selected" class="payment-card card-logo card-grid-img img-responsive" onclick="return selectPayment(\'card\');" />';
		<?php if ($bank_name_enable) { ?>
		html += '<span class="cardgrid-title title-color-card"><?php echo $text_card_name; ?></span>';
		<?php } else { ?>
		html += '<span class="bankgrid-title title-color-card">&nbsp;</span>';
		<?php } ?>
		html += '</p>';
   		html += '</li>';
	
		html += '<form id="kevin_form-<?php echo $payment_method; ?>" action="<?php echo $action; ?>&bankId=<?php echo $payment_method; ?>&payment_method=<?php echo $payment_method; ?>" enctype="multipart/form-data" method="POST"><input  type="hidden" name="bankId" value="<?php echo $payment_method; ?>"/>';
	  	html += '</form>';

			<?php } ?>
	
			<?php if ($payment_method == 'bank') { ?>	
		
		var bank = json['banks'];
		$.each(bank, function(i, item) {
	
		html += '<li class="col-md-2 col-sm-4 col-xs-12 ">';
    	html += '<p class="bank-grid">';
        html += '<input type="image" src="' + bank[i]['imageUri'] + '" alt="' + bank[i]['name'] + '" title="' + bank[i]['name'] + '" id="bank-selected" class="payment-' + bank[i]['id'] + ' bank-logo bank-grid-img img-responsive" onclick="return selectPayment(\'' + bank[i]['id'] + '\');"/>';
		<?php if ($bank_name_enable) { ?>
		html += '<span class="bankgrid-title title-color-' + bank[i]['id'] + '">' + bank[i]['name'] + '</span>';
		<?php } else { ?>
		html += '<span class="bankgrid-title title-color-' + bank[i]['id'] + '">&nbsp;</span>';
		<?php } ?>
		html += '</p></li>';
    

		html += '<form id="kevin_form-' + bank[i]['id'] + '" action="<?php echo $action; ?>&bankId=' + bank[i]['id'] + '&payment_method=<?php echo $payment_method; ?>" enctype="multipart/form-data" method="POST"><input  type="hidden" name="bankId" value="' + bank[i]['id'] + '" />';
	   	html += '</form>';
			
 		});	
												  
		<?php } ?>
	<?php } ?>		
		html += '</ul>';	

		$('#kevin-payment').html(html);
		
		var country_code = json['country_code'];
				
		$('input[name=\'search_bank\']').val('');	
				
		$('#country-code').data('country_code', country_code);

			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});	

//--></script>


<style>
#kevin-bank-search {
	/*float: right;*/
    width: 100%;
}
ul.list-unstyled.row.kevin-search-list {
    /* display: -webkit-box; */
    /* width: 100%; */
    white-space: nowrap;
    /* display: -webkit-inline-box; */
    /* display: flex; */
    position: relative;
    /* flex-wrap: nowrap; */
}
.input-group-addon:last-child {
    /* border-left: 0; */
}
.input-group-addon:first-child {
    /* border-left: 0; */
}
#kevin-bank-search .input-group-addon {
	height: auto;	
}
#kevin-select-country .input-group-addon {
	height: auto;	
}
div#kevin-select-country {
    display: -webkit-inline-flex;
	display: -webkit-box;       /* iOS 6-, Safari 3.1-6 */
	display: -moz-box;         /* Firefox 19 */
    display: -ms-flexbox;      /* IE 10 */
    display: -webkit-flex;     /* Chrome */
    display: flex;             /* Opera 12.1, Firefox 20+ */
    flex-wrap: nowrap;
    align-items: flex-start;
    /* margin-left: -10px; */
    width: 100%;

}
label.input-group-addon {
    width: auto;
}
div#search.input-group {
	display: flex;
    flex-direction: row;
    align-items: flex-start;
	width: 100%;
}
input#country-code {
  /**/ height: auto;
}
@media only screen and (max-width: 1367px) and (min-width: 1365px) {
	input#country-code {
		height: 100%;
	}	
}

	
select#input-country {
   /* width: auto;*/
}
.bank-container {
    margin-top: 10px;
/*	margin-right: -15px;
    margin-left: -15px;
	padding-left: 15px;
    padding-right: 15px;*/
}
div#kevin-payment {
    max-height: 270px;
    overflow-y: auto;
    overflow-x: hidden;
    padding: 10px;
    margin: -10px;
}
.li-grid {
	display: flex;
	flex-wrap: wrap;
	/*margin-left: -15px;*/
    /*margin-right: -15px;*/
	}
.bank-logo:hover {
    border: solid 2px #dddddd; 
    overflow: hidden;
    moz-box-shadow: 0px 0px 8px 2px rgba(119,119,119,0.2);
    -webkit-box-shadow: 0px 0px 8px 2px rgba(119,119,119,0.2);
    box-shadow: 0px 0px 8px 2px rgba(119,119,119,0.2);
    -webkit-transition: all .1s ease-in-out;
    -moz-transition: all .1s ease-in-out;
    -o-transition: all .1s ease-in-out;
    -ms-transition: all .1s ease-in-out;
    transition: all .1s ease-in-out;
    -webkit-transform: scale(1.02);
    transform: scale(1.02);
}
	
.card-logo:hover {
    border: solid 2px #dddddd; 
    overflow: hidden;
    moz-box-shadow: 0px 0px 8px 2px rgba(119,119,119,0.2);
    -webkit-box-shadow: 0px 0px 8px 2px rgba(119,119,119,0.2);
    box-shadow: 0px 0px 8px 2px rgba(119,119,119,0.2);
    -webkit-transition: all .1s ease-in-out;
    -moz-transition: all .1s ease-in-out;
    -o-transition: all .1s ease-in-out;
    -ms-transition: all .1s ease-in-out;
    transition: all .1s ease-in-out;
    -webkit-transform: scale(1.02);
    transform: scale(1.02);
}

.bank-grid-img, .card-grid-img {
	display:block; 
	max-width: 100%;
    height: auto;
	margin-left:auto; 
	margin-right:auto;
}
	
.bankgrid-title, .cardgrid-title {
	text-align: center;
	padding-top: 5px;
	font-size: 14px;
    margin-bottom: 15px;
    display: block;
}

input:focus{
    outline: none;
}

.bank-logo, .card-logo {
	display:block;
    margin:auto;
	max-height: 100px; 
	text-align: center; 
	border: solid 2px #dddddd; 
}
</style>
	
