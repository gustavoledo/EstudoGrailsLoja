package loja.movimentacao


import java.text.NumberFormat 

import loja.Loja;
import loja.TipoPagamento;
import loja.Usuario;
import loja.Util;

class Movimentacao {

	static belongsTo = [loja:Loja, usuario:Usuario, usuarioDesconto:Usuario, formaPagamento:FormaPagamento]
	static hasMany = [itens:ItemProduto]
	
	Date data
	TipoPagamento tipoPagamento
	Integer quantidadeParcelas = 1
	TipoPagamento tipoPagamentoEntrada
	Double entrada = 0
	Double valorTotal
	Double desconto = 0
	SortedSet itens
	
	static constraints = {
		tipoPagamento(nullable:false)
		tipoPagamentoEntrada(nullable:true)
		data(nullable:false)
		loja(nullable:false)
		usuario(nullable:false)
		formaPagamento(nullable:true)
		usuarioDesconto(nullable:true)
	}
	
	public String pagamento() {
		double total = entrada ? (valorTotal - entrada) : valorTotal 
		total = total / quantidadeParcelas
		
		NumberFormat nf = Util.getNumberFormat()
		String valorFormatado = nf.format(total)

		return "${quantidadeParcelas}x ${valorFormatado}"
	}
	
	Double totalItens() {
		Double total = itens.collect{it.preco*it.quantidade - it.desconto}.sum()
		return total
	}
	
	Double total() {
		Double total = totalItens()
		return total - desconto
	}
	
	Integer descontoPercentual() {
		Double total = totalItens()
		Integer descontoPercentual = desconto*100/total 
		return descontoPercentual
	}

}
