package loja


import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

class NumberTagLib {
	
	private static final String formato = "###,###,##0.00"
	
	def numberTextField = {attrs ->

		def precision = 2
		if (attrs.precision) {
			precision = attrs.precision
		}
		
		def valorFormatado = "${attrs.value}"
		if (attrs.value != null && precision.toInteger() > 0) {
			NumberFormat nf = getNumberFormat()
			
			Double valor = 0.0
			if (attrs.value instanceof Double) {
				valor = attrs.value
			} else {
				if (attrs.value.trim().length() > 0) {
					String valorDouble = attrs.value.replace('.', '')
					valor = valorDouble.replace(',', '.').toDouble()
				} 
			}
			
			valorFormatado = nf.format(valor)
			valorFormatado = valorFormatado.replace('.', '')
			
		}
		
		def text = "<input type=\"text\" name=\"${attrs.name}\" id=\"${attrs.name}\" style=\"${attrs.style}\" "

		if (attrs.disabled) {
			text += " disabled=\"${attrs.disabled}\" "
		} 
		if (attrs.onblur) {
			text += " onblur=\"${attrs.onblur}\"  "	
		}
		
		text +=	"value=\"${valorFormatado}\" size=\"${attrs.size}\" maxlength=\"${attrs.maxlength}\"  />" 
		
		text += "<script type=\"text/javascript\">" +
		            "\$(\"input[name=${attrs.name}]\").format({precision: ${precision}, negative:false, decimal:',', autofix:true});" +
				"</script>"   		

		out << text
	}
	
	def formatNumber = {attrs ->
		
		def valorFormatado = ""
		
		if (attrs.value != null) {
			NumberFormat nf = getNumberFormat()
			valorFormatado = nf.format(attrs.value)
		}
		
		out << valorFormatado
	}
	
	private NumberFormat getNumberFormat() {
		Locale locale = new Locale("pt", "BR")
		NumberFormat nf = NumberFormat.getNumberInstance(locale)
		((DecimalFormat) nf).applyPattern(formato);
		return nf
	}

}
