package loja.vidracaria

import grails.converters.JSON;
import loja.Cor;
import loja.Fabricante;
import loja.Loja;
import loja.Secao;
import loja.movimentacao.ItemProduto;

class AberturaController {

	def scaffold = true
	
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

		def aberturaInstanceTotal = 0
        def aberturaInstance = new Abertura()
		
		def lojaMatriz = Loja.get(session.usuario.lojaMatrizId)
		def aberturaInstanceList = Abertura.findAllByLoja(lojaMatriz, [max: params.max, offset:params.offset, sort: params.sort, order: params.order])
		
		if (aberturaInstanceList) {
			def aberturaInstanceListCount = Abertura.executeQuery("select count(*) from Abertura l where l.loja.id = ?", [session.usuario.lojaMatrizId])
			aberturaInstanceTotal = aberturaInstanceListCount[0]
		} 
		
        [aberturaInstanceList: aberturaInstanceList, aberturaInstanceTotal: aberturaInstanceTotal]
    }
	
	def deleteFoto = {
		def aberturaInstance = Abertura.get(params.id)
		aberturaInstance.setFoto(null)
		
		redirect(action: "edit", id: params.id)
	}

	
	def filter = {
		String query = "from Abertura m where m.loja.id = ${session.usuario.lojaMatrizId} "
		
		if (params.codigo) {
			query += "and m.codigo = '${params.codigo}' "
		}
		
		if (params.nome) {
			query += "and (m.nome like '%${params.nome}%' or m.descricao like '%${params.nome}%' ) "
		}

		if (params.secaoId) {
			query += "and m.secao.id = ${params.secaoId} "
		}
		
		def aberturaInstanceList = Abertura.findAll(query)
		
		render(view: "list", model: [aberturaInstanceList: aberturaInstanceList]) 
	}
	
	def create = {
		def aberturaInstance = new Abertura(modelo: 'Correr')
		aberturaInstance.properties = params
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)

		def secoes = Secao.findAllByLoja(loja)
		def fabricantes = Fabricante.findAllByLoja(loja)
		def vidros = Vidro.findAllByLoja(loja)
		def kits = Kit.findAllByLoja(loja)
		def puxadores = Puxador.findAllByLoja(loja)
		def aluminios = Aluminio.findAllByLoja(loja)
		def itensAdicionais = ItemAdicional.findAllByLoja(loja)
		
		//recupera o preco minimo do vidro de 300mm
		def retorno = Vidro.executeQuery("select v.precoUnitarioCompra from Vidro v where v.espessura = 300")
		def precoVidroMinimo = retorno[0]

		render(view: "edit", model: [aberturaInstance: aberturaInstance, loja: loja, 
			secoes: secoes, vidros: vidros, fabricantes: fabricantes, kits: kits, 
			puxadores: puxadores, aluminios: aluminios, itensAdicionais: itensAdicionais, 
			precoVidroMinimo: precoVidroMinimo])

	}
	
	def save = {
		def aberturaInstance = new Abertura(params)
		
		//seta o codigo do produto
		def codigoMax = Abertura.executeQuery("select max(a.id) from Abertura a")
		
		def codigoAbertura = codigoMax[0]
		if (!codigoAbertura) {
			codigoAbertura = 0
		}

		aberturaInstance.setCodigo(String.valueOf(codigoAbertura + 1))

		if (params.totalAbertura) {
			def totalAbertura = params.totalAbertura.toDouble()
			aberturaInstance.setPrecoUnitario(totalAbertura)
			aberturaInstance.setPrecoUnitarioCompra(totalAbertura)
		}		

		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		aberturaInstance.setLoja(loja)
		
		//preenche os vidros
		def aberturaVidrosIds = params.aberturaVidroId
		def aberturaLargurasVidro = params.aberturaLarguraVidro
		def aberturaAlturasVidro = params.aberturaAlturaVidro
		def aberturaQtdTranspasesVidro = params.aberturaQtdTranspaseVidro
		def aberturaPrecosVidro = params.aberturaPrecoVidro
		
		if (aberturaVidrosIds) {
			if (!aberturaVidrosIds.class.isArray()) {
				def aberturaVidrosIdsArray = new String[1]
				def aberturaLargurasVidroArray = new String[1]
				def aberturaAlturasVidroArray = new String[1]
				def aberturaQtdTranspasesVidroArray = new String[1]
				def aberturaPrecosVidroArray = new String[1]
				
				aberturaVidrosIdsArray[0] = aberturaVidrosIds
				aberturaLargurasVidroArray[0] = aberturaLargurasVidro
				aberturaAlturasVidroArray[0] = aberturaAlturasVidro
				aberturaQtdTranspasesVidroArray[0] = aberturaQtdTranspasesVidro
				aberturaPrecosVidroArray[0] = aberturaPrecosVidro
				
				aberturaVidrosIds = aberturaVidrosIdsArray
				aberturaLargurasVidro = aberturaLargurasVidroArray
				aberturaAlturasVidro = aberturaAlturasVidroArray
				aberturaQtdTranspasesVidro = aberturaQtdTranspasesVidroArray
				aberturaPrecosVidro = aberturaPrecosVidroArray
			}
			
			aberturaVidrosIds.eachWithIndex {val, i ->
				Vidro vidro = Vidro.get(val.toLong())
				
				Double largura = aberturaLargurasVidro[i].toDouble()
				Double altura = aberturaAlturasVidro[i].toDouble()
				Integer qtdTranspase = aberturaQtdTranspasesVidro[i].toInteger()
				Double precoVidro = aberturaPrecosVidro[i].toDouble()
				
				AberturaVidro item = new AberturaVidro(abertura: aberturaInstance, vidro: vidro, 
					largura: largura, altura: altura, qtdTranspase: qtdTranspase, precoVidro: precoVidro)
				aberturaInstance.addToVidros(item)
			}
		}
		
		//preenche os kits
		def aberturaKitsIds = params.aberturaKitId
		
		if (aberturaKitsIds) {
			if (!aberturaKitsIds.class.isArray()) {
				def aberturaKitsIdsArray = new String[1]
				aberturaKitsIdsArray[0] = aberturaKitsIds
				aberturaKitsIds = aberturaKitsIdsArray
			}
			
			aberturaKitsIds.each {
				Kit kit = Kit.get(it.toLong())
				AberturaKit item = new AberturaKit(abertura: aberturaInstance, kit: kit)
				aberturaInstance.addToKits(item)
			}
		}

		//preenche os puxadores
		def aberturaPuxadoresIds = params.aberturaPuxadorId
		
		if (aberturaPuxadoresIds) {
			if (!aberturaPuxadoresIds.class.isArray()) {
				def aberturaPuxadoresIdsArray = new String[1]
				aberturaPuxadoresIdsArray[0] = aberturaPuxadoresIds
				aberturaPuxadoresIds = aberturaPuxadoresIdsArray
			}
			
			aberturaPuxadoresIds.each {
				Puxador puxador = Puxador.get(it.toLong())
				AberturaPuxador item = new AberturaPuxador(abertura: aberturaInstance, puxador: puxador)
				aberturaInstance.addToPuxadores(item)
			}
		}

		//preenche os aluminios
		def aberturaAluminiosIds = params.aberturaAluminioId
		def aberturaCoresAluminioId = params.aberturaCorAluminioId
		
		if (aberturaAluminiosIds) {
			if (!aberturaAluminiosIds.class.isArray()) {
				def aberturaAluminiosIdsArray = new String[1]
				def aberturaCoresAluminioIdArray = new String[1]
				
				aberturaAluminiosIdsArray[0] = aberturaAluminiosIds
				aberturaCoresAluminioIdArray[0] = aberturaCoresAluminioId
				
				aberturaAluminiosIds = aberturaAluminiosIdsArray
				aberturaCoresAluminioId = aberturaCoresAluminioIdArray
			}
			
			aberturaAluminiosIds.eachWithIndex {val, i ->
				Aluminio aluminio = Aluminio.get(val.toLong())
				Cor corAluminio = Cor.get(aberturaCoresAluminioId[i])
				AberturaAluminio item = new AberturaAluminio(abertura: aberturaInstance, aluminio: aluminio, corAluminio: corAluminio)
				aberturaInstance.addToAluminios(item)
			}
		}

		//preenche os itens
		def itensIds = params.itemAdicionalId
		
		if(itensIds){
			if (!itensIds.class.isArray()) {
				def itensIdsArray = new String[1]
				itensIdsArray[0] = itensIds
				itensIds = itensIdsArray
			}
			
			itensIds.each {
				ItemAdicional itemAdicional = ItemAdicional.get(it.toLong())
				AberturaItemAdicional item = new AberturaItemAdicional(abertura: aberturaInstance, itemAdicional: itemAdicional)
				aberturaInstance.addToItensAdicionais(item)
			}
		}
		
		//preenche os itens extras
		def descricaoItem = params.descricaoItem
		
		if(descricaoItem){
			def qtdItem = params.qtdItem
			def precoItem = params.precoItem
			
			if (!descricaoItem.class.isArray()) {
				def descricaoItemArray = new String[1]
				def qtdItemArray = new String[1]
				def precoItemArray = new String[1]
				
				descricaoItemArray[0] = descricaoItem
				descricaoItem = descricaoItemArray
				
				qtdItemArray[0] = qtdItem
				qtdItem = qtdItemArray

				precoItemArray[0] = precoItem
				precoItem = precoItemArray
			}
			
			descricaoItem.eachWithIndex {val, i ->
				String descricao = descricaoItem[i]
				Integer quantidade = qtdItem[i].toInteger()
				Double precoUnitario = precoItem[i].toDouble()
				
				ItemExtra itemExtra = new ItemExtra(descricao: descricao, quantidade: quantidade, precoUnitario: precoUnitario)
				aberturaInstance.addToItensExtras(itemExtra)
			}
		}

		if (aberturaInstance.save(flush: true)) {
			flash.message = "Abertura criada com sucesso."
			
			if (params.participaOrcamento || params.opcaoVender == 'S') {
				if (!session.mapItensProduto) {
					session.mapItensProduto = [:]
				}
				
				ItemProduto item = new ItemProduto()
				item.setProduto(aberturaInstance)
				item.setQuantidade(1)
				item.setPreco(aberturaInstance.precoUnitario)
				
				session.mapItensProduto.put(item.produto.id, item)
			}

			//vai para a tela de venda e seta o item na sessao			
			if (params.opcaoVender == 'S') {
				response.sendRedirect("${request.contextPath}/movimentacao/index?opcaoMovimentacao=VENDA&origemProduto=S")
			} else {
				redirect(action: "list")
			}
		}
		else {
			def secoes = Secao.findAllByLoja(loja)
			def fabricantes = Fabricante.findAllByLoja(loja)
			def vidros = Vidro.findAllByLoja(loja)
			def kits = Kit.findAllByLoja(loja)
			def puxadores = Puxador.findAllByLoja(loja)
			def aluminios = Aluminio.findAllByLoja(loja)
			def itensAdicionais = ItemAdicional.findAllByLoja(loja)
			
			//recupera o preco minimo do vidro de 300mm
			def retorno = Vidro.executeQuery("select v.precoUnitario from Vidro v where v.espessura = 300")
			def precoVidroMinimo = retorno[0]
	
			render(view: "edit", model: [aberturaInstance: aberturaInstance, loja: loja, 
				secoes: secoes, vidros: vidros, fabricantes: fabricantes, kits: kits, 
				puxadores: puxadores, aluminios: aluminios, itensAdicionais: itensAdicionais,
				precoVidroMinimo: precoVidroMinimo])
		}

	}
	
	def edit = {
		def aberturaInstance = Abertura.get(params.id)
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)

		def secoes = Secao.findAllByLoja(loja)
		def fabricantes = Fabricante.findAllByLoja(loja)
		def vidros = Vidro.findAllByLoja(loja)
		def kits = Kit.findAllByLoja(loja)
		def puxadores = Puxador.findAllByLoja(loja)
		def aluminios = Aluminio.findAllByLoja(loja)
		def itensAdicionais = ItemAdicional.findAllByLoja(loja)
		
		//recupera o preco minimo do vidro de 300mm
		def retorno = Vidro.executeQuery("select v.precoUnitario from Vidro v where v.espessura = 300")
		def precoVidroMinimo = retorno[0]
		
		render(view: "edit", model: [aberturaInstance: aberturaInstance, loja: loja,
			secoes: secoes, fabricantes: fabricantes, vidros: vidros, kits: kits, 
			puxadores: puxadores, aluminios: aluminios, itensAdicionais: itensAdicionais,
			precoVidroMinimo: precoVidroMinimo])

	}
	
	def update = {
		def aberturaInstance = Abertura.get(params.id)
		if (aberturaInstance) {
			aberturaInstance.properties = params
			
			def totalAbertura = params.totalAbertura.toDouble()
			aberturaInstance.setPrecoUnitario(totalAbertura)
			aberturaInstance.setPrecoUnitarioCompra(totalAbertura)
			
			atualizaItens(aberturaInstance)
			atualizaItensExtras(aberturaInstance)
			atualizaVidros(aberturaInstance)
			atualizaKits(aberturaInstance)
			atualizaPuxadores(aberturaInstance)
			atualizaAluminios(aberturaInstance)
			
			if (!aberturaInstance.hasErrors() && aberturaInstance.save(flush: true)) {
				flash.message = "Abertura atualiza com sucesso."
				
				//vai para a tela de venda e seta o item na sessao			
				if (params.opcaoVender == 'S') {
					session.mapItensProduto = [:]
					
					ItemProduto item = new ItemProduto()
					item.setProduto(aberturaInstance)
					item.setQuantidade(1)
					item.setPreco(aberturaInstance.precoUnitario)
					
					session.mapItensProduto.put(item.produto.id, item)
					
					response.sendRedirect("${request.contextPath}/movimentacao/index?opcaoMovimentacao=VENDA&origemProduto=S")
					
				} else {
					redirect(action: "list")
				}
			}
			else {
				def loja = loja.Loja.get(session.usuario.lojaMatrizId)
				
				def secoes = Secao.findAllByLoja(loja)
				def fabricantes = Fabricante.findAllByLoja(loja)
				def vidros = Vidro.findAllByLoja(loja)
				def kits = Kit.findAllByLoja(loja)
				def puxadores = Puxador.findAllByLoja(loja)
				def aluminios = Aluminio.findAllByLoja(loja)
				def itensAdicionais = ItemAdicional.findAllByLoja(loja)
				
				//recupera o preco minimo do vidro de 300mm
				def retorno = Vidro.executeQuery("select v.precoUnitario from Vidro v where v.espessura = 300")
				def precoVidroMinimo = retorno[0]
	
				render(view: "edit", model: [aberturaInstance: aberturaInstance, loja: loja, 
					secoes: secoes, fabricantes: fabricantes, vidros: vidros, kits: kits, 
					puxadores: puxadores, aluminios: aluminios, itensAdicionais: itensAdicionais,
					precoVidroMinimo: precoVidroMinimo])
			}
		}
		else {
			flash.message = "Não existe a abertura informada."
			redirect(action: "list")
		}
	}
	
	def editVendido = {
		def aberturaInstance = Abertura.get(params.id)
		[aberturaInstance: aberturaInstance]
	}
	
	def updateVendido = {
		def aberturaInstance = Abertura.get(params.id)
		aberturaInstance.properties = params
	
		if (!aberturaInstance.hasErrors() && aberturaInstance.save(flush: true)) {
			flash.message = "Abertura atualiza com sucesso."
			
			//vai para a tela de venda e seta o item na sessao
			if (params.opcaoVender == 'S') {
				session.mapItensProduto = [:]
				
				ItemProduto item = new ItemProduto()
				item.setProduto(aberturaInstance)
				item.setQuantidade(1)
				item.setPreco(aberturaInstance.precoUnitario)
				
				session.mapItensProduto.put(item.produto.id, item)
				
				response.sendRedirect("${request.contextPath}/movimentacao/index?opcaoMovimentacao=VENDA&origemProduto=S")
				
			} else {
				redirect(action: "list")
			}
		}
		else {
			render(view: "editVendido", model: [aberturaInstance: aberturaInstance])
		}

	}
	
	def ajaxVidrosByFabricante = {
		def vidros = Vidro.findAll("from Vidro v where v.fabricante.id = ${params.id}")
		
		render vidros as JSON

	}
	
	private void atualizaVidros(Abertura aberturaInstance) {
		def aberturaVidrosIds = params.aberturaVidroId
		def aberturaLargurasVidro = params.aberturaLarguraVidro
		def aberturaAlturasVidro = params.aberturaAlturaVidro
		def aberturaQtdTranspasesVidro = params.aberturaQtdTranspaseVidro
		def aberturaPrecosVidro = params.aberturaPrecoVidro
		
		if (aberturaVidrosIds) {
			
			if (!aberturaVidrosIds.class.isArray()) {
				def aberturaVidrosIdsArray = new String[1]
				def aberturaLargurasVidroArray = new String[1]
				def aberturaAlturasVidroArray = new String[1]
				def aberturaQtdTranspasesVidroArray = new String[1]
				def aberturaPrecosVidroArray = new String[1]
				
				aberturaVidrosIdsArray[0] = aberturaVidrosIds
				aberturaLargurasVidroArray[0] = aberturaLargurasVidro
				aberturaAlturasVidroArray[0] = aberturaAlturasVidro
				aberturaQtdTranspasesVidroArray[0] = aberturaQtdTranspasesVidro
				aberturaPrecosVidroArray[0] = aberturaPrecosVidro
				
				aberturaVidrosIds = aberturaVidrosIdsArray
				aberturaLargurasVidro = aberturaLargurasVidroArray
				aberturaAlturasVidro = aberturaAlturasVidroArray
				aberturaQtdTranspasesVidro = aberturaQtdTranspasesVidroArray
				aberturaPrecosVidro = aberturaPrecosVidroArray
			}
			
			def l = []
			l += aberturaInstance.vidros
			def mapItens = [:]
			 
			def aberturaVidrosIdsList = aberturaVidrosIds.toList()
			l.each {
				if (!aberturaVidrosIdsList.contains(it.vidro.id)) {
					aberturaInstance.removeFromVidros(it)
					it.delete()
				}
				mapItens.put(it.vidro.id, it)
			}
			
			aberturaVidrosIds.eachWithIndex {val, i ->
				if (!mapItens.containsKey(val)) {
					Vidro vidro = Vidro.get(val.toLong())
					
					Double largura = aberturaLargurasVidro[i].toDouble()
					Double altura = aberturaAlturasVidro[i].toDouble()
					Integer qtdTranspase = aberturaQtdTranspasesVidro[i].toInteger()
					Double precoVidro = aberturaPrecosVidro[i].toDouble()
					
					AberturaVidro item = new AberturaVidro(abertura: aberturaInstance, vidro: vidro, 
						largura: largura, altura: altura, qtdTranspase: qtdTranspase, precoVidro: precoVidro)
					aberturaInstance.addToVidros(item)
				}
			}
		}

	}

	private void atualizaKits(Abertura aberturaInstance) {
		if (params.aberturaKitId) {
			def aberturaKitsIds = params.aberturaKitId
			
			if (!aberturaKitsIds.class.isArray()) {
				def aberturaKitsIdsArray = new String[1]
				aberturaKitsIdsArray[0] = aberturaKitsIds
				aberturaKitsIds = aberturaKitsIdsArray
			}
			
			def l = []
			l += aberturaInstance.kits
			def mapItens = [:]
			 
			def aberturaKitsIdsList = aberturaKitsIds.toList()
			l.each {
				if (!aberturaKitsIdsList.contains(it.kit.id)) {
					aberturaInstance.removeFromKits(it)
					it.delete()
				}
				mapItens.put(it.kit.id, it)
			}
			
			aberturaKitsIds.each {
				if (!mapItens.containsKey(it)) {
					Kit kit = Kit.get(it.toLong())
					AberturaKit item = new AberturaKit(abertura: aberturaInstance, kit: kit)
					aberturaInstance.addToKits(item)
				}
			}
		}

	}

	void atualizaPuxadores(Abertura aberturaInstance) {
		if (params.aberturaPuxadorId) {
			def aberturaPuxadoresIds = params.aberturaPuxadorId
			
			if (!aberturaPuxadoresIds.class.isArray()) {
				def aberturaPuxadoresIdsArray = new String[1]
				aberturaPuxadoresIdsArray[0] = aberturaPuxadoresIds
				aberturaPuxadoresIds = aberturaPuxadoresIdsArray
			}
			
			def l = []
			l += aberturaInstance.puxadores
			def mapItens = [:]
			 
			def aberturaPuxadoresIdsList = aberturaPuxadoresIds.toList()
			l.each {
				if (!aberturaPuxadoresIdsList.contains(it.puxador.id)) {
					aberturaInstance.removeFromPuxadores(it)
					it.delete()
				}
				mapItens.put(it.puxador.id, it)
			}
			
			aberturaPuxadoresIds.each {
				if (!mapItens.containsKey(it)) {
					Puxador puxador = Puxador.get(it.toLong())
					AberturaPuxador item = new AberturaPuxador(abertura: aberturaInstance, puxador: puxador)
					aberturaInstance.addToPuxadores(item)
				}
			}
		}

	}


	private void atualizaAluminios(Abertura aberturaInstance) {
		if (params.aberturaAluminioId) {
			def aberturaAluminiosIds = params.aberturaAluminioId
			def aberturaCoresAluminioId = params.aberturaCorAluminioId
			
			if (!aberturaAluminiosIds.class.isArray()) {
				def aberturaAluminiosIdsArray = new String[1]
				def aberturaCoresAluminioIdArray = new String[1]
				
				aberturaAluminiosIdsArray[0] = aberturaAluminiosIds
				aberturaCoresAluminioIdArray[0] = aberturaCoresAluminioId
				
				aberturaAluminiosIds = aberturaAluminiosIdsArray
				aberturaCoresAluminioId = aberturaCoresAluminioIdArray
			}
			
			def l = []
			l += aberturaInstance.aluminios
			def mapItens = [:]
			 
			def aberturaAluminiosIdsList = aberturaAluminiosIds.toList()
			l.each {
				if (!aberturaAluminiosIdsList.contains(it.aluminio.id)) {
					aberturaInstance.removeFromAluminios(it)
					it.delete()
				}
				mapItens.put(it.aluminio.id, it)
			}
			
			aberturaAluminiosIds.eachWithIndex {val, i ->
				if (!mapItens.containsKey(val)) {
					Aluminio aluminio = Aluminio.get(val.toLong())
					Cor corAluminio = Cor.get(aberturaCoresAluminioId[i])
					AberturaAluminio item = new AberturaAluminio(abertura: aberturaInstance, aluminio: aluminio, corAluminio: corAluminio)
					aberturaInstance.addToAluminios(item)
				}
			}
		}

	}

	private void atualizaItens(Abertura aberturaInstance) {
		if (params.itemAdicionalId) {
			def itensIds = params.itemAdicionalId
			
			if (!itensIds.class.isArray()) {
				def itensIdsArray = new String[1]
				itensIdsArray[0] = itensIds
				itensIds = itensIdsArray
			}
			
			def l = []
			l += aberturaInstance.itensAdicionais
			def mapItens = [:]
			 
			def itensIdsList = itensIds.toList()
			l.each {
				if (!itensIdsList.contains(it.itemAdicional.id)) {
					aberturaInstance.removeFromItensAdicionais(it)
					it.delete()
				}
				mapItens.put(it.itemAdicional.id, it)
			}
			
			itensIds.each {
				if (!mapItens.containsKey(it)) {
					ItemAdicional itemAdicional = ItemAdicional.get(it.toLong())
					AberturaItemAdicional item = new AberturaItemAdicional(abertura: aberturaInstance, itemAdicional: itemAdicional)
					aberturaInstance.addToItensAdicionais(item)
				}
			}
		}

	}
	
	private void atualizaItensExtras(Abertura aberturaInstance) {
		if (params.descricaoItem) {
			def descricaoItem = params.descricaoItem
			
			if (!descricaoItem.class.isArray()) {
				def descricaoItemArray = new String[1]
				descricaoItemArray[0] = descricaoItem
				descricaoItem = descricaoItemArray
			}
			
			def l = []
			l += aberturaInstance.itensExtras
			def mapItensExtras = [:]
			 
			def descricaoItemList = descricaoItem.toList()
			l.each {
				if (!descricaoItemList.contains(it.descricao)) {
					aberturaInstance.removeFromItensExtras(it)
					it.delete()
				}
				mapItensExtras.put(it.descricao, it)
			}
			
			descricaoItem.eachWithIndex {val, i ->
				if (!mapItensExtras.containsKey(val)) {
					String descricao = descricaoItem[i]
					Integer quantidade = params.qtdItem[i].toInteger()
					Double precoUnitario = params.precoItem[i].toDouble()
					ItemExtra itemExtra = new ItemExtra(descricao: descricao, quantidade: quantidade, precoUnitario: precoUnitario)
					aberturaInstance.addToItensExtras(itemExtra)
				}
			}
		}

	}

}
