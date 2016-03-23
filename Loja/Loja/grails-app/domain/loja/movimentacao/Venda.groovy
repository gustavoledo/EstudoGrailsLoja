package loja.movimentacao


import loja.Cliente 
import loja.StatusVenda 
import loja.Usuario;

class Venda extends Movimentacao {

	static belongsTo = [cliente: Cliente]
	
	String rua
	Integer numero
	String complemento
	String bairro
	String cidade
	String cep
	String uf
	String referencia
	String observacao
	StatusVenda statusVenda
	Date previsaoEntrega
	Double valorReceber = 0
	Boolean emitiuNotaFiscal

	
	static constraints = {
		rua(nullable:true)
		numero(nullable:true)
		complemento(nullable:true)
		bairro(nullable:true, size:3..80)
		cidade(nullable:true, size:3..80)
		cep(nullable:true)
		uf(nullable:true)
		referencia(nullable:true)
		valorReceber(nullable:true)
		cliente(nullable:true)
		emitiuNotaFiscal(nullable:true)
	}
	
	public boolean enderecoClienteMesmoDeEntrega() {
		boolean retorno = false
		if (cliente) {
			retorno = 
				this.rua == this.cliente.rua &&
				this.numero == this.cliente.numero &&
				this.complemento == this.cliente.complemento &&
				this.bairro == this.cliente.bairro &&
				this.cidade == this.cliente.cidade &&
				this.cep == this.cliente.cep &&
				this.uf == this.cliente.uf
		}
		
		return retorno
	} 
	
}
