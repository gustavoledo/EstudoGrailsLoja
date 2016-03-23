package loja.vidracaria

import loja.Loja;

class ItemAdicionalController {

	def scaffold = true
	
	def save = {
		def itemAdicionalInstance = new ItemAdicional(params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		itemAdicionalInstance.setLoja(loja)
		
		//seta o codigo do produto
		def codigoMax = Aluminio.executeQuery("select max(i.id) from ItemAdicional i where i.loja.id = ${session.usuario.lojaId}")
		
		def codigo = codigoMax[0]
		if (!codigo) {
			codigo = 1
		}
		itemAdicionalInstance.setCodigo(codigo.toString())
		itemAdicionalInstance.setDescricao(params.nome)
		
		if (itemAdicionalInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [itemAdicionalInstance: itemAdicionalInstance, loja: loja])
		}
	}

}
