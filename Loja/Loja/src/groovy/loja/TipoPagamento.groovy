package loja

enum TipoPagamento {
	
	DINHEIRO("DI", "Dinheiro"),
	CHEQUE("CH", "Cheque"),
	DEBITO("DE", "Débito"),
	CREDITO("CR", "Crédito"),
	BOLETO("BO", "Boleto"),
	CUSTOMIZADO("CT", "Customizado")
	
	String sigla
	String name
	
	TipoPagamento(String sigla, String name) {
		this.sigla = sigla
		this.name = name
	}	
	
}
