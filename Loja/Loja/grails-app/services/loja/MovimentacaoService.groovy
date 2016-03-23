package loja

import loja.movimentacao.Movimentacao;
import loja.movimentacao.MovimentacaoEstoque;

class MovimentacaoService {

	boolean save(Movimentacao movimentacaoInstance, String opcaoMovimentacao) {
		boolean result = movimentacaoInstance.save(flush:true)

		//salva as movimentacoes de estoque
		if (result) {
			movimentacaoInstance.itens.each {
				String operacao = opcaoMovimentacao == 'COMPRA' ? "+" : "-"
				MovimentacaoEstoque movimentacaoEstoque = new MovimentacaoEstoque(loja: movimentacaoInstance.loja, 
					produto: it.produto, data: new Date(), operacao: operacao, 
					quantidade: it.quantidade, movimentacao: movimentacaoInstance)
				result = movimentacaoEstoque.save(flush:true)
			}
		}
		
		return result
	}
	
	void transferir(MovimentacaoEstoque movimentacaoOrigem, MovimentacaoEstoque movimentacaoDestino, Long quantidade) {
		movimentacaoOrigem.setOperacao("-")
		movimentacaoOrigem.setQuantidade(quantidade)
		
		movimentacaoDestino.setOperacao("+")
		movimentacaoDestino.setQuantidade(quantidade)
		
		movimentacaoOrigem.save(flush:true)
		movimentacaoDestino.save(flush:true)
	}
	
	void delete(Movimentacao movimentacaoInstance) {
		//deleta as movimentacoes de estoque
		def movimentacoesEstoque = MovimentacaoEstoque.findAllByMovimentacao(movimentacaoInstance)
		movimentacoesEstoque.each {
			it.delete(flush:true)
		}
		
		//deleta a movimentacao com os itens
		movimentacaoInstance.delete(flush:true)
	}
}
