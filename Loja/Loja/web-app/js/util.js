	function printPage() {
		$('.nav').hide()				
		$(":button").hide()
		$(":submit").hide()
		$("#grailsLogo").hide()
		
		window.print()

		setTimeout(showComponents, 3000); //3 segundos
    }

    function showComponents() {
		$('.nav').show()				
		$(":button").show()
		$(":submit").show()
		$("#grailsLogo").show()
    }	

	function updateSelect(e, nameSelect, optionValue, optionText) {
		
		var list = eval("(" + e.responseText + ")")	// evaluate JSON
		
		if (list) {
			var rselect = document.getElementById(nameSelect)
			removeAllItemsSelect(nameSelect)
	
			// Rebuild the select
			for (var i=0; i < list.length; i++) {
				var obj = list[i]
				var opt = document.createElement('option');
				opt.text = eval('obj.' + optionText)
				opt.value = eval('obj.' + optionValue)
			  	try {
			    	rselect.add(opt, null) // standards compliant; doesn't work in IE
			  	}
		  		catch(ex) {
		    		rselect.add(opt) // IE only
		  		}
			}
		}
	}
	
	function updateSelectJson(json, nameSelect, optionValue, optionText) {
		
		var list = json	// evaluate JSON
		
		if (list) {
			var rselect = document.getElementById(nameSelect)
			removeAllItemsSelect(nameSelect)
	
			// Rebuild the select
			for (var i=0; i < list.length; i++) {
				var obj = list[i]
				var opt = document.createElement('option');
				opt.text = eval('obj.' + optionText)
				opt.value = eval('obj.' + optionValue)
			  	try {
			    	rselect.add(opt, null) // standards compliant; doesn't work in IE
			  	}
		  		catch(ex) {
		    		rselect.add(opt) // IE only
		  		}
			}
			
		}
	}	
	
	function removeAllItemsSelect(nameSelect) {
		var rselect = document.getElementById(nameSelect)
		var l = rselect.length
		while (l > 1) {
			l--
			rselect.remove(l)
		}
	}
	
	
	function formatDate(date) {
		var curr_date = date.getDate();
		var curr_month = date.getMonth();
		curr_month++;
		var curr_year = date.getFullYear();
		var dateFormat = curr_date + "/" + curr_month + "/" + curr_year
		
		timeFormat = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds(); 						
		return dateFormat + " " + timeFormat; 
	}	
	
	 function setCheckedIndex(radio, index) {
			for (var i=0; i<radio.length; i++) {
				radio[i].checked = false;
			}
			radio[index].checked = true;
		 }

	 function disableRadio(radio, disabled) {
		for (var i=0; i<radio.length; i++) {
			radio[i].disabled = disabled;
		}
	 }	
	 
	 
	 function VerificaCPF() {
		if (vercpf(document.frmcpf.cpf.value)) {
			document.frmcpf.submit();
		} else {
			errors = "1";
			if (errors)
				alert('CPF NÃO VÁLIDO');
			document.retorno = (errors == '');
		}
	}
	 
	 function floatNumber(numberFormated) {
		 var number = numberFormated.replace('.', '');
		 number = number.replace(',', '.');
		 number = parseFloat(number);
		 
		 return number;
	 } 
	 
	 function formatNumber(number) {
		 number = number.toFixed(2); 
		 number = number.replace('.', ',');
		 return number;
	 }
	 
