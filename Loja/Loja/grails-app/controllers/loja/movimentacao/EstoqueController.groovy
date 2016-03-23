package loja.movimentacao

import loja.Estoque;
import loja.Loja;
import loja.MovimentacaoService;
import loja.Produto;
import loja.UsuarioService;

class EstoqueController {

	UsuarioService usuarioService
	MovimentacaoService movimentacaoService
	
	def list = {

		def produtoInstanceList
		if (params.codigo || params.nome || params.secaoId) {
			String query = "from Produto p where p.loja.id = ${session.usuario.loja.id} "
			if (params.codigo) {
				query += "and p.codigo = '${params.codigo}' "
			}
	
			if (params.nome) {
				query += "(and UPPER(p.nome) like '%${params.nome.toUpperCase()}%' " +
					" or UPPER(p.descricao) like '%${params.nome.toUpperCase()}%') "
			}
			
			if (params.secaoId) {
				query += "and p.secao.id = ${params.secaoId} "
			}
			
			produtoInstanceList = Produto.findAll(query)
		} else {
			if (!params.origemMenu) {
				def errors = ["Informe algum filtro para realizar a consulta."]
				flash.errors = errors
			}
		}		
		
		
		[produtoInstanceList: produtoInstanceList]
	}
	
	def transferirShow = {
		def lojas = usuarioService.recuperaLojas(session.usuario.lojaId)
		
		render(view: 'transferir', model:[lojas: lojas])
	}
	
	def save = {
		if (params.lojaOrigemId == params.lojaDestinoId) {
			def errors = ["Lojas origem e destino devem ser diferentes."]
			flash.errors = errors

			def lojas = usuarioService.recuperaLojas(session.usuario.lojaId)
			render(view: 'transferir', model:[lojas: lojas])
			return
		}
		
		Produto produto = Produto.get(params.id)
		
		Loja lojaOrigem = Loja.get(params.lojaOrigemId)
		Loja lojaDestino = Loja.get(params.lojaDestinoId)
		
		def estoques = produto.estoques()
		
		Estoque estoqueLojaOrigem = estoques.find{it.loja.nomeAbreviado == lojaOrigem.nomeAbreviado}
		
		if (estoqueLojaOrigem.saldo < params.quantidade.toLong()) {
			def errors = ["Quantidade indisponível na loja origem."]
			flash.errors = errors
			
			def lojas = usuarioService.recuperaLojas(session.usuario.lojaId)
			render(view: 'transferir', model:[lojas: lojas])
		} else {
			MovimentacaoEstoque movimentacaoOrigem = new MovimentacaoEstoque(loja: lojaOrigem, produto: produto, data: new Date())
			MovimentacaoEstoque movimentacaoDestino = new MovimentacaoEstoque(loja: lojaDestino, produto: produto, data: new Date())
			movimentacaoService.transferir(movimentacaoOrigem, movimentacaoDestino, params.quantidade.toLong())
			
			redirect(action: "list", params: ['codigo': produto.codigo])
		}
		
	}
	
}
