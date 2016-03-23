package loja.movimentacao

import loja.Produto 
import loja.Usuario 


class ItemProduto implements Comparable {

	static belongsTo = [produto:Produto, movimentacao:Movimentacao, usuarioOperacao: Usuario]
	
	Integer quantidade
	Double preco
	Double desconto = 0
	Date dataRecebimento
	Date dataEntrega
	
	static constraints = {
		quantidade(nullable:false)
		preco(nullable:false)
		desconto(nullable:true)
		dataRecebimento(nullable:true)
		dataEntrega(nullable:true)
		usuarioOperacao(nullable:true)
	}
	
	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
	
}
