package loja

import loja.movimentacao.MovimentacaoEstoque;
import loja.movimentacao.Venda;

class Produto {

	static belongsTo = [secao:Secao, loja:Loja]
	
	String codigo
	String nome
	String descricao
	
	Double precoUnitario = 0
	Double precoUnitarioCompra = 0
	
	byte[] foto
	
	Long qtdDisponivel
	static transients = ['qtdDisponivel']
	
	static constraints = {
		id(display: false)
		codigo(blank:false, size:1..20)
		nome(blank:false, size:3..80)
		descricao(nullable:true, size:3..400)
		precoUnitario(nullable:false)
		precoUnitarioCompra(nullable:false)
		foto(nullable:true, maxSize: 512000) // 500Kb
	}
	
	static mapping = {
		tablePerHierarchy false
	    foto column: "foto", sqlType: "longblob"
	}
			
	@Override
	public String toString() {
		return nome
	}
	
	public void addEstoque(Estoque e) {
		estoques += e
	}
	
	public List estoques() {
		String query = "from MovimentacaoEstoque m " +
			"where m.produto.id = ${this.id} " + 
			"order by m.loja.nomeAbreviado "
			
		def movimentacoes = MovimentacaoEstoque.findAll(query)
		
		def estoqueList = []
		Estoque estoque
		
		int qtdEntradas = 0
		int qtdSaidasComEntrega = 0
		int qtdSaidasSemEntrega = 0
		if (movimentacoes) {
			String nomeAbreviadoAnterior = ""
			movimentacoes.each {
				String nomeAbreviado = it.loja.nomeAbreviado
				String operacao = it.operacao
				Integer qtd = it.quantidade
				
				if (nomeAbreviado != nomeAbreviadoAnterior) {
					estoque = new Estoque(produto: this, loja: new Loja(nomeAbreviado: nomeAbreviado))
					estoqueList += estoque
				}
				
				if (operacao == "+") {
					estoque.addEntrada(qtd) 
				} else {
					if (it.movimentacao && it.movimentacao instanceof Venda) {
						if (it.movimentacao.statusVenda == StatusVenda.FINALIZADO) {
							estoque.addSaidaComEntrega(qtd)
						} else {
							estoque.addSaidaSemEntrega(qtd)
						}	
					} else {
						estoque.addSaidaComEntrega(qtd)
					}
					
				}
				
				nomeAbreviadoAnterior = nomeAbreviado
			}
			
		} else {
			estoque = new Estoque(produto: this, loja: new Loja(nomeAbreviado: getLoja().getNomeAbreviado()))
			estoqueList += estoque
		}
		
		//seta a quantidade disponivel em todos os estoques
		Double saldoTotal = estoqueList.collect{it.saldo}.sum()
		this.qtdDisponivel = saldoTotal 
		
		return estoqueList
			
	}

}
