package loja

import java.text.DecimalFormat 
import java.text.NumberFormat;

class Pagamento {

	String nome
	Integer qtdParcelas
	Double valor
	Boolean juros
	
	@Override
	public String toString() {
		String juros = juros ? "c/ juros" : "s/ juros"

		NumberFormat nf = Util.getNumberFormat()
		String valorFormatado = nf.format(valor)

		return "${qtdParcelas}x${valorFormatado} ${juros}"
	}
	
}
