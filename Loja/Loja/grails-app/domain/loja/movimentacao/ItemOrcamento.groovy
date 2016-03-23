package loja.movimentacao

import loja.Produto 


class ItemOrcamento implements Comparable {

	static belongsTo = [produto:Produto, orcamento:Orcamento]
	
	Integer quantidade
	Double preco
	
	static constraints = {
		quantidade(nullable:false)
		preco(nullable:false)
	}
	
	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
}
