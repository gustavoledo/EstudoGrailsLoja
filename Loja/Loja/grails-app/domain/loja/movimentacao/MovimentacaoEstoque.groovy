package loja.movimentacao

import loja.Loja;
import loja.Produto;

class MovimentacaoEstoque {

	static belongsTo = [loja: Loja, produto: Produto, movimentacao: Movimentacao]
	
	Long quantidade
	Date data
	String operacao
	String observacao
	
	static constraints = {
		loja(nullable:false)
		produto(nullable:false)
		quantidade(nullable:false)
		observacao(nullable:true)
		movimentacao(nullable:true)
		data(blank:false)
		operacao(blank:false, inList:["+", "-"])
	}
}
