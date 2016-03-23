package loja.movimentacao


import loja.Cliente 
import loja.Loja;
import loja.UsuarioService;
import loja.movimentacao.ItemOrcamento;
import loja.movimentacao.ItemProduto;
import loja.movimentacao.Orcamento;

class OrcamentoController {

	def scaffold = Orcamento
	UsuarioService usuarioService
	
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def orcamentoInstanceList
		def orcamentoInstanceTotal = 0
		def orcamentoInstance = new Orcamento()
		
		def lojaMatriz = Loja.get(session.usuario.lojaMatrizId)
		orcamentoInstanceList = Orcamento.findAllByLoja(lojaMatriz, [max: params.max, offset:params.offset, sort: params.sort, order: params.order])
		
		if (orcamentoInstanceList) {
			def orcamentoInstanceListCount = Orcamento.executeQuery("select count(*) from Orcamento o where o.loja.id = ?", [session.usuario.lojaMatrizId])
			orcamentoInstanceTotal = orcamentoInstanceListCount[0]
		}
			
		
		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		
		[orcamentoInstanceList: orcamentoInstanceList, usuarioInstanceList: usuarioInstanceList, orcamentoInstanceTotal: orcamentoInstanceTotal]
		
	}
	
	def filter = {
		String query = "from Orcamento o where o.loja.id = ${session.usuario.lojaMatrizId} "

		if (params.id) {
			query += "and o.id = ${params.id} "
		}

		if (params.nomeCliente) {
			query += "and o.cliente.nome like '%${params.nomeCliente}%' "
		}
		
		if (params.usuarioId) {
			query += "and o.usuario.id = ${params.usuarioId}"
		}

		def orcamentoInstanceList = Orcamento.findAll(query)
		def orcamentoInstanceTotal = orcamentoInstanceList.size()
		
		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		
		render(view: "list", model:[orcamentoInstanceList: orcamentoInstanceList, usuarioInstanceList: usuarioInstanceList, orcamentoInstanceTotal: orcamentoInstanceTotal])

	}

	def showByItens = {
		Orcamento orcamentoInstance = createOrcamentoByItens()

		params.save = true
		render(view: "show", model: [orcamentoInstance: orcamentoInstance])
	}	

	def save = {
		Orcamento orcamentoInstance = createOrcamentoByItens()

		if (orcamentoInstance.save(flush: true)) {
			session.mapItensProduto = [:]
			
			flash.message = "Orçamento armazenado com sucesso."
			response.sendRedirect("${request.contextPath}/orcamento/list")
			
		} else {
			def errors = []
			errors += "Erro ao salvar orçamento."
			flash.errors = errors
			render(view: "show", model: [orcamentoInstance: orcamentoInstance])
		}
		
	}
	
	def gerarVenda = {
		Orcamento orcamentoInstance = Orcamento.get(params.id)

		session.mapItensProduto = [:]
		
		orcamentoInstance.itens.each {
			ItemProduto item = new ItemProduto()
			item.setProduto(it.produto)
			item.setQuantidade(it.quantidade)
			item.setPreco(it.preco)
			
			session.mapItensProduto.put(item.produto.id, item)
		}

		Long clienteId = orcamentoInstance.cliente ? orcamentoInstance.cliente.id : 0
		response.sendRedirect("${request.contextPath}/movimentacao/index?opcaoMovimentacao=VENDA&clienteId=${clienteId}")

	}
	
	def orcamentoReport = {
		Orcamento orcamentoInstance = recuperaOrcamento()
		return [orcamentoInstance: orcamentoInstance]
	}

	def orcamentoMoveis = {
		Orcamento orcamentoInstance = recuperaOrcamento()
		return [orcamentoInstance: orcamentoInstance]
	}
	
	private Orcamento recuperaOrcamento() {
		Orcamento orcamentoInstance = Orcamento.get(params.id)
		
		if (!orcamentoInstance) {
			orcamentoInstance = createOrcamentoByItens()
			
			//salva o orcamento
			orcamentoInstance.save(flush: true)
			
			session.mapItensProduto = [:]
		}

		return orcamentoInstance
	}


	private Orcamento createOrcamentoByItens() {
		Orcamento orcamentoInstance = new Orcamento()
		orcamentoInstance.setData(new Date())
		orcamentoInstance.setLoja(session?.usuario?.loja)
		orcamentoInstance.setUsuario(session?.usuario)
		
		if (params.clienteId) {
			Cliente clienteInstance = Cliente.get(params.clienteId)
			orcamentoInstance.setCliente(clienteInstance)
		}
		
		if (params.formaPagamento) {
			orcamentoInstance.setFormaPagamento(params.formaPagamento)
		}
		
		session.mapItensProduto.values().each {
			ItemOrcamento item = new ItemOrcamento()
			item.setProduto(it.produto)
			item.setQuantidade(it.quantidade)
			item.setPreco(it.preco)
			
			item.setOrcamento(orcamentoInstance)
			orcamentoInstance.addToItens(item)
		}

		return orcamentoInstance
	}
}
