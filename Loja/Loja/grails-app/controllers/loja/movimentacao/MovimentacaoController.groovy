package loja.movimentacao


import loja.Cliente 
import loja.Endereco 
import loja.Fornecedor 
import loja.Loja 
import loja.MovimentacaoService;
import loja.Perfil 
import loja.Produto 
import loja.StatusVenda 
import loja.TipoPagamento 
import loja.Usuario 
import loja.movel.Movel;
import loja.movimentacao.Compra;
import loja.movimentacao.FormaPagamento;
import loja.movimentacao.ItemProduto;
import loja.movimentacao.Movimentacao;
import loja.movimentacao.Venda;
import grails.converters.JSON;

class MovimentacaoController {

	MovimentacaoService movimentacaoService
	
	def index = {
		
		String query = ""
		if (session.usuario.hasCategoriaMovel()) {
			query = queryMovel()
		} else {
			query = queryGenerica()
		}
		
		flash.errors = []
		def produtos
		if (query.indexOf("and") == -1) {
			if (!params.origemMenu && !params.origemProduto && !params.clienteId) {
				def errors = ["Informe algum filtro para realizar a consulta."]
				flash.errors = errors
			}
		} else {
			produtos = Produto.executeQuery(query)
		}
		
		//if (params.origemMenu || !session.mapItensProduto) {
		if (!session.mapItensProduto) {
			session.mapItensProduto = [:]
		}

		render(view: "selectProdutos", model: [produtoInstanceList: produtos])
	}
	
	def novoOrcamento = {
		session.mapItensProduto = [:]
		params.opcao = "VENDA"
		render(view: "selectProdutos", model: [produtoInstanceList: []])
	}
	
	def comprasPedido = {
		
		String query = ""
		if (session.usuario.hasCategoriaMovel()) {
			query = queryMovel()
		} else {
			query = queryGenerica()
		}
		
		def produtosAll = Produto.executeQuery(query)
		
		def produtos = []
		produtosAll.each {
			it.estoques()
			if (it.qtdDisponivel < 0) {
				produtos += it	
			}
		}
		
		if (!produtos || produtos.size() == 0) {
			def errors = ["Não existem produtos com necessidade de compra."]
			flash.errors = errors
		}
		
		if (params.origemMenu || !session.mapItensProduto) {
			session.mapItensProduto = [:]
		}
		
		render(view: "selectProdutos", model: [produtoInstanceList: produtos, isCompraPedidos: true])
	}
		
	def receberProdutos = {
		String query = 
			"select distinct c from Compra c " +
			"inner join fetch c.itens i " +
			"where c.loja.id = ${session.usuario.lojaId} " + 
			"and i.dataRecebimento is null"
			
		def compraInstanceList = Compra.executeQuery(query)
		
		//recupera as vendas associadas para cada item de compra
		def itens = compraInstanceList.collect{it.itens}.flatten()
		
		String itensIds = itens.collect{it.id}.join(",")
		
		String queryVendas = 
			"select distinct v from Venda v " +
			"inner join fetch v.itens i " +
			"where v.loja.id = ${session.usuario.lojaId} " //+ 
			"and i.dataRecebimento is null " +
			"and i.id in (${itensIds}) " +
			"order by v.data "
			
		def vendas = Venda.executeQuery(queryVendas)
		
		//monta um map com o item e a lista de vendas
		def vendasMap = [:]
		itens.each {
			Long idItem = it.id
			Long idProduto = it.produto.id
			Long qtdProduto = it.quantidade 
			def vendasItem = vendas.findAll{it.itens.find{it.produto.id == idProduto} != null}
			
			//recupera apenas as vendas com somatorio menor q a quantidade de itens
			def vendasAssociadas = []
			int soma = 0
			vendasItem.each {
				def item = it.itens.find{it.produto.id == idProduto}
				int qtdItem = it.itens.find{it.produto.id == idProduto}.quantidade
				soma += qtdItem
				
				if (soma < qtdProduto) {
					vendasAssociadas += it
				}
				
			}
			vendasMap.put(idItem, vendasAssociadas)
		} 
		
		render(view: "receberProdutos", model: [compraInstanceList: compraInstanceList, vendasMap: vendasMap]) 
	}
	
	def receberItem = {
		ItemProduto itemProdutoInstance = ItemProduto.get(params.id) 
		itemProdutoInstance.setDataRecebimento(new Date())
		itemProdutoInstance.setUsuarioOperacao(session.usuario)
		
		//seta o recebimento nos itens de venda associados
		if (params.itensVendaIds) {
			def itensVendaIdsList = []
			if (params.itensVendaIds.indexOf(",") > -1) {
				itensVendaIdsList = params.itensVendaIds.split(",")
			} else {
				itensVendaIdsList = [params.itensVendaIds]
			}
			
			itensVendaIdsList.each {
				ItemProduto itemVenda = ItemProduto.get(it)
				itemVenda.setDataRecebimento(new Date())
			}
		}
		
		redirect(action: "receberProdutos")
	}
	
	def entregarProdutos = {
		String query =
			"select distinct v from Venda v " +
			"inner join fetch v.itens i " +
			"where v.loja.id = ${session.usuario.lojaId} " +
			"and i.dataRecebimento is not null " +
			"and i.dataEntrega is null "
		
		def vendaInstanceList = Venda.executeQuery(query)
			
		render(view:"entregarProdutos", model: [vendaInstanceList: vendaInstanceList])	
	}
	
	def entregarItem = {
		ItemProduto itemProdutoInstance = ItemProduto.get(params.id)
		itemProdutoInstance.setDataEntrega(new Date())
		itemProdutoInstance.setUsuarioOperacao(session.usuario)
		
		redirect(action: "entregarProdutos")
	}

	
	def filterCliente = {
		def clienteInstanceList 
		if (validateClientes()) {
			clienteInstanceList = recuperaClientesByFilter()
		} 
		render(view: "selectClientes", model: [clienteInstanceList: clienteInstanceList])
	}

	def filterFornecedor = {
		def fornecedorInstanceList
		if (validateFornecedores()) {
			fornecedorInstanceList = recuperaFornecedoresByFilter() 
		}
		render(view: "selectFornecedores", model: [fornecedorInstanceList: fornecedorInstanceList])
	}

	def selectClientes = {
		render(view: "selectClientes")
	}

	def selectFornecedores = {
		render(view: "selectFornecedores")
	}
	
	def selectEnderecoEntrega = {
		if (!params.clienteId || params.clienteId == '0') {
			def errors = ["Selecione um cliente."]
			flash.errors = errors

			def clienteInstanceList
			if (validateClientes()) {
				clienteInstanceList = recuperaClientesByFilter()
			}
			render(view: "selectClientes", model: [clienteInstanceList: clienteInstanceList])
		} else {
			flash.errors = []
			Cliente clienteInstance = Cliente.get(params.clienteId)
			render(view: "selectEndereco", model: [clienteInstance: clienteInstance])
		}
			
	}

	def selectFormaPagamento = {
		def errors = []
		if (params.opcaoMovimentacao == 'VENDA') {
			Cliente clienteInstance = Cliente.get(params.clienteId)
			if (validateEndereco()) {
				
				Endereco enderecoInstance = new Endereco(rua: params.rua, numero: params.int('numero'), complemento: params.complemento, 
						bairro: params.bairro, cidade: params.cidade, cep: params.cep, uf: params.uf, referencia: params.referencia)
				
				params.tipoPagamentoEntrada = "SEM_ENTRADA"
				params.tipoPagamento = TipoPagamento.DINHEIRO
				
				if (session.usuario.hasCategoriaMovel()) {
					params.previsaoEntrega = new Date() + 30
				} else {
					params.previsaoEntrega = new Date() + 20
				}
				
				render(view: "selectFormaPagamento", model: [clienteInstance: clienteInstance, enderecoInstance: enderecoInstance])
			} else {
				render(view: "selectEndereco", model: [clienteInstance: clienteInstance])
			}
		} else {
			if (params.fornecedorId) {
				Fornecedor fornecedorInstance = Fornecedor.get(params.fornecedorId)
				
				params.tipoPagamentoEntrada = "SEM_ENTRADA"
				params.tipoPagamento = TipoPagamento.DINHEIRO
				
				render(view: "selectFormaPagamento", model: [fornecedorInstance: fornecedorInstance])
			} else {
				errors += "Selecione um fornecedor."
				def fornecedorInstanceList = recuperaFornecedoresByFilter()
				render(view: "selectFornecedores", model: [fornecedorInstanceList: fornecedorInstanceList])
			}
		}
		flash.errors = errors
	}
	
	def finaliza = {
		flash.errors = []
		
		Movimentacao movimentacaoInstance

		Cliente clienteInstance = Cliente.get(params.clienteId)
		Fornecedor fornecedorInstance = Fornecedor.get(params.fornecedorId)
		Endereco enderecoInstance = new Endereco(rua: params.rua, numero: params.int('numero'), complemento: params.complemento,
			bairro: params.bairro, cidade: params.cidade, cep: params.cep, uf: params.uf, referencia: params.referencia)

		String mensagem
		if (params.opcaoMovimentacao == 'VENDA') {
			movimentacaoInstance = new Venda(rua: params.rua, numero: params.numero, complemento: params.complemento, 
											 bairro: params.bairro, cidade: params.cidade, cep: params.cep, 
											 uf: params.uf, referencia: params.referencia)
			
			movimentacaoInstance.setCliente(clienteInstance)
			
			if (params.observacao) {
				movimentacaoInstance.setObservacao(params.observacao)
			} else {
				movimentacaoInstance.setObservacao(" ")
			}
			
			if (params.valorReceber) {
				movimentacaoInstance.setValorReceber(params.valorReceber.replace(',', '.').toDouble()) 
			}
			
			Double desconto = 0.0
			Double descontoGerente = params.descontoGerenteFinal ? params.descontoGerenteFinal.replace(',', '.').toDouble() : 0.0 
			Double descontoVendedor = params.descontoVendedorFinal ? params.descontoVendedorFinal.replace(',', '.').toDouble(): 0.0
			Usuario usuarioDesconto
			if (descontoGerente > 0) {
				desconto = descontoGerente
				usuarioDesconto = Usuario.get(params.usuarioDescontoId)
			} else if (descontoVendedor > 0) {
				desconto = descontoVendedor
				usuarioDesconto = session.usuario
			}
			movimentacaoInstance.setDesconto(desconto)
			
			if (usuarioDesconto) {
				movimentacaoInstance.setUsuarioDesconto(usuarioDesconto)
			}
			
			movimentacaoInstance.setPrevisaoEntrega(params.previsaoEntrega)
			movimentacaoInstance.setStatusVenda(StatusVenda.AGUARDANDO_ENTREGA_FORNECEDOR)
			
			mensagem = "Venda realizada com sucesso."
		} else {
			movimentacaoInstance = new Compra()
		
			movimentacaoInstance.setFornecedor(fornecedorInstance)
			
			mensagem = "Compra realizada com sucesso."
		}
		
		Loja loja = Loja.get(session?.usuario?.lojaId)
		movimentacaoInstance.setLoja(loja)
		movimentacaoInstance.setData(new Date())
		
		if (params.tipoPagamento) {
			TipoPagamento tipo = TipoPagamento.valueOf(params.tipoPagamento)
			movimentacaoInstance.setTipoPagamento(tipo)
		}
		
		Double total = session.mapItensProduto.values().collect{it.preco*it.quantidade}.sum()
		movimentacaoInstance.setValorTotal(total)
		
		
		movimentacaoInstance.setUsuario(session.usuario)
		
		/*
		if (params.tipoPagamentoEntrada != 'SEM_ENTRADA') {
			movimentacaoInstance.setEntrada(params.entrada.replace(',', '.').toDouble())	
		}
		*/
		
		if (params.cartaoId) {
			FormaPagamento formaPagamento = FormaPagamento.get(params.cartaoId.toLong())
			movimentacaoInstance.setFormaPagamento(formaPagamento)
		}
		
		if (params.pagamentoId) {
			movimentacaoInstance.setQuantidadeParcelas(params.pagamentoId.toInteger())
		}
		
		if (params.quantidadeParcelas) {
			movimentacaoInstance.setQuantidadeParcelas(params.quantidadeParcelas.toInteger())
		}
		
		//add itens
		boolean temProdutoSemEstoque = false
		session.mapItensProduto.values().each {
			it.setMovimentacao(movimentacaoInstance)
			movimentacaoInstance.addToItens(it)

			if (!temProdutoSemEstoque) {
				Produto produto = Produto.get(it.produto.id)
				produto.estoques()
				if (produto.qtdDisponivel == 0) {
					temProdutoSemEstoque = true
				}
			}
			
		}
		
		if (validateFields() && movimentacaoInstance.validate()) {
			boolean result
			if (params.opcaoMovimentacao == 'VENDA') {
				if (temProdutoSemEstoque) {
					movimentacaoInstance.setStatusVenda(StatusVenda.AGUARDANDO_ENTREGA_FORNECEDOR)
				} else {
					movimentacaoInstance.setStatusVenda(StatusVenda.AGUARDANDO_ENTREGA_AO_CLIENTE)
				}
				result = movimentacaoService.save(movimentacaoInstance, params.opcaoMovimentacao)
				
			} else {
				result = movimentacaoService.save(movimentacaoInstance, params.opcaoMovimentacao)
			}
				
			if (result) {
				flash.message = mensagem
				session.mapItensProduto = [:]
				response.sendRedirect("${request.contextPath}/relatorio/show/${movimentacaoInstance.id}?opcaoMovimentacao=${params.opcaoMovimentacao}")
			} else {
				def cartoes
				def pagamentos
				if (params.tipoPagamento == 'CREDITO' || params.tipoPagamento == 'DEBITO') {
					cartoes = FormaPagamento.findAll("from FormaPagamento f where f.loja.id = ${session.usuario.lojaId} and f.tipoPagamento = '${params.tipoPagamento}' ")
					
					if (params.cartaoId) {
						FormaPagamento formaPagamento = FormaPagamento.get(params.cartaoId)
						Double valorTotal = session.mapItensProduto.values().collect{it.preco*it.quantidade}.sum()
						pagamentos = formaPagamento.recuperaPagamentos(valorTotal)
					}
						
				}
			
				render(view: "selectFormaPagamento", model: [movimentacaoInstance: movimentacaoInstance, cartoes: cartoes, pagamentos: pagamentos, clienteInstance: clienteInstance, fornecedorInstance: fornecedorInstance, enderecoInstance: enderecoInstance])

			}
		} else {
			
			def cartoes
			def pagamentos
			if (params.tipoPagamento == 'CREDITO' || params.tipoPagamento == 'DEBITO') {
				cartoes = FormaPagamento.findAll("from FormaPagamento f where f.loja.id = ${session.usuario.lojaId} and f.tipoPagamento = '${params.tipoPagamento}' ")
				
				if (params.cartaoId) {
					FormaPagamento formaPagamento = FormaPagamento.get(params.cartaoId)
					Double valorTotal = session.mapItensProduto.values().collect{it.preco*it.quantidade}.sum()
					pagamentos = formaPagamento.recuperaPagamentos(valorTotal)
				}
					
			}
		
			render(view: "selectFormaPagamento", model: [movimentacaoInstance: movimentacaoInstance, cartoes: cartoes, pagamentos: pagamentos, clienteInstance: clienteInstance, fornecedorInstance: fornecedorInstance, enderecoInstance: enderecoInstance])
		}

		
	}
	
	def ajaxUpdateTotalItens = {
		session.mapItensProduto.values().each {
			def qtd = params["qtd${it.produto.id}"]
			def preco = params["preco${it.produto.id}"]
			def desconto = params["desconto${it.produto.id}"]
			
			it.setQuantidade(qtd.toInteger())
			
			if (preco) {
				it.setPreco(preco.replace(',', '.').toDouble())
			}
			
			if (desconto) {
				it.setDesconto(desconto.replace(',', '.').toDouble())
			}
		}

		render(template: "itensProdutoInclude", model: [itensProdutoList: session.mapItensProduto.values(), isMovimentacao: true])
		
	}
	
	def delete = {
		Movimentacao movimentacaoInstance = Movimentacao.get(params.id) 
		
		movimentacaoService.delete(movimentacaoInstance)

		response.sendRedirect("${request.contextPath}/relatorio/index?origemMenu=S&opcaoMovimentacao=VENDA")
	}
	
	def ajaxAddProduto = {
		
		Produto produto = Produto.get(params.id) 
		
		ItemProduto item = new ItemProduto()
		item.setProduto(produto)
		item.setQuantidade(1)
		
		if (params.opcaoMovimentacao == 'VENDA') {
			item.setPreco(produto.getPrecoUnitario())
		} else {
			item.setPreco(produto.getPrecoUnitarioCompra())
		}
			

		if (!session.mapItensProduto.get(produto.id)) {
			session.mapItensProduto.put(produto.id, item)
		}
		
		render(template: "itensProdutoInclude", model: [itensProdutoList: session.mapItensProduto.values(), isMovimentacao: true])		
	}
	
	def ajaxRemoveProduto = {
		session.mapItensProduto.remove(params.id.toLong())
		
		render(template: "itensProdutoInclude", model: [itensProdutoList: session.mapItensProduto.values(), isMovimentacao: true])
	}
	
	def ajaxCartoes = {
		def cartoes = FormaPagamento.findAll("from FormaPagamento f where f.loja.id = ${session.usuario.lojaMatrizId} and f.tipoPagamento = '${params.tipoPagamento}' ")
		
		render cartoes as JSON
	}
	
	def ajaxPagamentos = {
		FormaPagamento formaPagamento = FormaPagamento.get(params.id)
		
		Double total = session.mapItensProduto.values().collect{it.preco*it.quantidade}.sum()

		def pagamentos = formaPagamento.recuperaPagamentos(total)
		
		render pagamentos as JSON
	}
	
	def ajaxUpdateItens = {
		//Double entrada = params.entrada.replace(',', '.').toDouble()
		Double entrada = 0
		
		Double total = session.mapItensProduto.values().collect{it.preco*it.quantidade}.sum()
		
		FormaPagamento formaPagamento = FormaPagamento.get(params.id.toLong())
		def pagamentos = formaPagamento.recuperaPagamentos(total - entrada)
		
		render pagamentos as JSON
	}
	
	def ajaxAutorizacaoGerente = {
		String query = "from Usuario u where u.login = ? " +
			"and u.senha = ? " +
			"and u.loja.id = ? " +
			"and u.perfil = ? "
			
		def gerente = Usuario.find(query, [params.login, params.senha, session.usuario.lojaId, Perfil.GERENTE])
		
		if (gerente) {
			render gerente as JSON
		} else {
			render new Usuario() as JSON
		}
	}
	
	def ajaxUpdateEmissaoNota = {
		Movimentacao movimentacaoInstance = Movimentacao.get(params.id)
		
		Boolean emitiuNotaFiscal = new Boolean(params.emitiuNotaFiscal)
		movimentacaoInstance.setEmitiuNotaFiscal(emitiuNotaFiscal.booleanValue())
		
		render "OK"
	}
	
	private boolean validateClientes() {
		boolean retorno = false
		if (params.nome || params.cpf || params.telefone) {
			retorno = true
		} else {
			def errors = ["Informe ao menos um filtro para consulta."]
			flash.errors = errors
		}
		
		return retorno
	}

	private boolean validateFornecedores() {
		boolean retorno = false
		if (params.nome || params.cnpj) {
			retorno = true
		} else {
			def errors = ["Informe ao menos um filtro para consulta."]
			flash.errors = errors
		}
		
		return retorno
	}

	private List recuperaClientesByFilter() {
		String query = "from Cliente c where c.loja.id = ${session.usuario.lojaMatrizId} "
		
		if (params.nome) {
			query += "and UPPER(c.nome) like '%${params.nome.toUpperCase()}%' "
		}
		
		if (params.cpf) {
			query += "and c.cpf = '${params.cpf}' "
		}

		if (params.telefone) {
			query += "and (c.telefoneResidencial like '%${params.telefone}%' " +
				"or c.telefoneCelular like '%${params.telefone}%' " +
				"or c.telefoneComercial like '%${params.telefone}%' )"
		}
		
		query += " order by c.nome"
		
		def clienteInstanceList = Cliente.findAll(query)

		return clienteInstanceList
	}

	private String queryMovel() {
	    String query = "from Movel p where p.loja.id = ${session.usuario.lojaMatrizId} "

	    if (params.codigo) {
			query += "and p.codigo = '${params.codigo}' "
		}

		if (params.nome) {
			query += "and (UPPER(p.nome) like '%${params.nome.toUpperCase()}%' " +
				" or UPPER(p.descricao) like '%${params.nome.toUpperCase()}%') "
		}
		
		if (params.secaoId) {
			query += "and p.secao.id = ${params.secaoId} "
		}

		if (params.fabricanteId) {
			query += "and p.fabricante.id = ${params.fabricanteId} "
		}

		if (params.linhaId) {
			query += "and p.linha.id = ${params.linhaId} "
		}

		return query
	}

	private String queryGenerica() {
		
		String query = "from Produto p where p.loja.id = ${session.usuario.lojaMatrizId} "

		if (params.codigo) {
			query += "and p.codigo = '${params.codigo}' "
		}

		if (params.nome) {
			query += "and (UPPER(p.nome) like '%${params.nome.toUpperCase()}%' " +
				" or UPPER(p.descricao) like '%${params.nome.toUpperCase()}%') "
		}
		
		if (params.secaoId) {
			query += "and p.secao.id = ${params.secaoId} "
		}

		return query
	}

	private List recuperaFornecedoresByFilter() {
		String query = "from Fornecedor f where f.loja.id = ${session.usuario.lojaMatrizId} "
		
		if (params.nome) {
			query += "and (UPPER(f.nome) like '%${params.nome.toUpperCase()}%' " +
				"or UPPER(f.razaoSocial) like '%${params.nome.toUpperCase()}%' ) "
		}
		
		if (params.cnpj) {
			query += "and f.cnpj = '${params.cnpj}' "
		}

		def fornecedorInstanceList = Fornecedor.findAll(query)

		return fornecedorInstanceList
	}
	
	private boolean validateEndereco() {
		def errors = []
		
		if (!params.rua) {
			errors += "O campo Rua deve ser preenchido."
		}

		if (!params.numero) {
			errors += "O campo Número deve ser preenchido."
		}
		
		if (!params.bairro) {
			errors += "O campo Bairro deve ser preenchido."
		}
		
		if (!params.cidade) {
			errors += "O campo Cidade deve ser preenchido."
		}

		/*
		if (!params.cep) {
			errors += "O campo CEP deve ser preenchido."
		}
		*/

		if (!params.uf) {
			errors += "O campo UF deve ser preenchido."
		}

		if (!params.referencia) {
			errors += "O campo Ponto de Referência deve ser preenchido."
		}

		flash.errors = errors
		
		return errors.size() == 0

	}
	
	private boolean validateFields() {
		def errors = []
		
		if (params.tipoPagamento == 'CREDITO' || params.tipoPagamento == 'DEBITO') {

			if (!params.cartaoId) {
				errors += "O campo Cartão deve ser preenchido."
			} else {
				if (!params.pagamentoId) {
					errors += "O campo Pagamento deve ser preenchido."
				}
			}
		} 
		
		flash.errors = errors
		
		return errors.size() == 0
			
	}
	
}
