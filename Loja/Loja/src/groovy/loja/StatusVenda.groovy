package loja

enum StatusVenda {

	AGUARDANDO_ENTREGA_FORNECEDOR("Aguardando Entrega do Fornecedor"),
	AGUARDANDO_ENTREGA_AO_CLIENTE("Aguardando Entrega ao Cliente"),
	FINALIZADO("Finalizado");
	
	String name;
	
	StatusVenda(String name) {
		this.name = name;
	}
}
