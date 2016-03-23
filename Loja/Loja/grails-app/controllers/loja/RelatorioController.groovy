package loja

import java.util.Calendar;
import java.util.List;

import loja.movimentacao.Compra;
import loja.movimentacao.Venda;

class RelatorioController {

	UsuarioService usuarioService
	
	def index = {
				
		String movimentacao
		if (params.opcaoMovimentacao == 'VENDA') {
			movimentacao = "Venda"
		} else {
			movimentacao = "Compra"
		}

		String query = "from ${movimentacao} c " +
			"where c.loja.id = ${session.usuario.lojaId} " +
			"and c.data between ? and ? "
		
		if (params.usuarioId) {
			query += "and c.usuario.id = ${params.usuarioId} "
		}
		
		def movimentacaoInstanceList
		
		if (!params.origemMenu) {
			if (params.opcaoMovimentacao == 'VENDA') {
				if (params.opcaoComissao) {
					query = queryComissao()
				} 
				movimentacaoInstanceList = Venda.findAll(query, [params.dataInicio, params.dataFim+1])
			} else {
				movimentacaoInstanceList = Compra.findAll(query, [params.dataInicio, params.dataFim+1])
			}
				
		} else {
			params.dataInicio = new Date() - 10
		}
		
		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		
		
		render(view: "movimentacoes", model: [movimentacaoInstanceList: movimentacaoInstanceList, usuarioInstanceList: usuarioInstanceList])
	}

	def consolidado = {
		
		String movimentacao
		if (params.opcaoMovimentacao == 'VENDA') {
			movimentacao = "Venda"
		} else {
			movimentacao = "Compra"
		}
		
		def redeLojas = RedeLojas.findAll("from RedeLojas r where r.lojaMatriz.id = ${session.usuario.lojaId}")
		def lojasInstanceList = [redeLojas[0].lojaMatriz]
		redeLojas.each {
			lojasInstanceList += it.lojaFilial
		}
		String lojaIds = lojasInstanceList.collect{it.id}.join(",")
		
		String query = "from ${movimentacao} c " +
			"where c.loja.id in (${lojaIds}) " +
			"and c.data between ? and ? "
		
		if (params.usuarioId) {
			query += "and c.usuario.id = ${params.usuarioId}"
		}

		if (params.lojaId) {
			query += "and c.loja.id = ${params.lojaId}"
		}
		
		query += "order by c.loja.id "

		def movimentacaoInstanceList
		
		if (!params.origemMenu) {
			if (params.opcaoMovimentacao == 'VENDA') {
				movimentacaoInstanceList = Venda.findAll(query, [params.dataInicio, params.dataFim+1])
			} else {
				movimentacaoInstanceList = Compra.findAll(query, [params.dataInicio, params.dataFim+1])
			}
				
		} else {
			params.dataInicio = new Date() - 10
		}
		
		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		
		render(view: "movimentacoes", model: [movimentacaoInstanceList: movimentacaoInstanceList, lojasInstanceList: lojasInstanceList, usuarioInstanceList: usuarioInstanceList])
	}

	def show = {
		def movimentacaoInstance
		Endereco enderecoInstance
		if (params.opcaoMovimentacao == 'VENDA') {
			movimentacaoInstance = Venda.get(params.id)
			
			enderecoInstance = new Endereco(rua: movimentacaoInstance.rua, numero: movimentacaoInstance.numero, complemento: movimentacaoInstance.complemento,
				bairro: movimentacaoInstance.bairro, cidade: movimentacaoInstance.cidade, 
				cep: movimentacaoInstance.cep, uf: movimentacaoInstance.uf, referencia: movimentacaoInstance.referencia)
	
		} else {
			movimentacaoInstance = Compra.get(params.id)
		}

		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaMatrizId)

		[movimentacaoInstance: movimentacaoInstance, enderecoInstance: enderecoInstance, usuarioInstanceList: usuarioInstanceList]
	}
	
	def geraRelatorio = {
		def movimentacaoInstance = Compra.get(params.id)
		
		render(view: "pedidoReport", model: [movimentacaoInstance: movimentacaoInstance])
	}
	
	def chartMovimentacoes = {
		if (params.origemMenu) {
			params.dataInicio = new Date() - 30
			params.dataFim = new Date()
		}
		
		String query = "select v.data, sum(v.valorTotal) from Venda v " +
			//"where v.loja.id = ${session.usuario.lojaId} " +
			"where v.data between ? and ? "
			//"and v.data between ? and ? "
		
		query += "group by v.data"

		if (params.usuarioId) {
			query += "and v.usuario.id = ${params.usuarioId}"
		}

		def result = Venda.executeQuery(query, [params.dataInicio, params.dataFim+1])
		
		String xml
		if (result) {
			def mapValues = [:]
			result.each {
				String data = it[0].format('MM/yyyy')
				
				def soma = mapValues.get(data)
				
				if (soma >= 0) {
					soma += it[1]
				} else {
					soma = it[1]
				}
				
				mapValues.put(data, soma)
			}
	
			def chartValues = []
			mapValues.keySet().each {
				def value = mapValues[it]
				chartValues += new ChartValue(data: it, value: value)
			}
				
			xml = getXMLChartQuantidadeVendas(chartValues)
		}
		
		[xml: xml]
	}
	
	def geraPedidoVidracaria = {
		def movimentacaoInstance = Venda.get(params.id)
		render(view: "pedidoVidracaria", model:[movimentacaoInstance: movimentacaoInstance])
	}

	def geraPedidoMoveis = {
		def movimentacaoInstance = Venda.get(params.id)
		render(view: "pedidoMoveis", model:[movimentacaoInstance: movimentacaoInstance])
	}

	private String getXMLChartQuantidadeVendas(List<ChartValue> chartValues) {
		String xml = "<chart caption='Quantidade de vendas' xAxisName='Mês' " +
			"yAxisName='Qtd' numberPrefix='R\$' showValues= '0' formatNumberScale='0' >"
			
		chartValues.each {
			xml += "<set label='${it.data}' value='${it.value}' />"
		}
			
		xml += "</chart>"
	}

	private String queryComissao() {
		String query = "from Venda v " +
			"where v.loja.id = ${session.usuario.lojaId} " +
			"and v.data between ? and ? " 
			
		if (params.usuarioId) {
			query += "and ( " + 
				"(v.usuario.id = ${params.usuarioId} " +
				"and v.cliente.vendedorComissao is null) " +
				"or " +
				"(v.cliente.vendedorComissao.id = ${params.usuarioId}) " +
				")"
		}
			
		return query
	}	

}
