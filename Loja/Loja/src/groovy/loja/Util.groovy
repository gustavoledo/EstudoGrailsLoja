package loja

import java.text.DecimalFormat 
import java.text.NumberFormat;

class Util {

	private static final String formato = "###,###,##0.00"
	
	public static final NumberFormat getNumberFormat() {
		Locale locale = new Locale("pt", "BR")
		NumberFormat nf = NumberFormat.getNumberInstance(locale)
		((DecimalFormat) nf).applyPattern(formato);
		return nf
	}
	
}
