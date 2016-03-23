package loja.movimentacao


import loja.Fornecedor 

class Compra extends Movimentacao {

	static belongsTo = [fornecedor: Fornecedor]
	
	static constraints = {
		fornecedor(nullable:false)
	}
	
}
