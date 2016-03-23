package loja.vidracaria

import loja.Loja;

class KitController {

	def scaffold = true
	
	def save = {
		def kitInstance = new Kit(params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		kitInstance.setLoja(loja)
		
		//seta o codigo do produto
		def codigoMax = Kit.executeQuery("select max(k.id) from Kit k where k.loja.id = ${session.usuario.lojaId}")
		
		def codigo = codigoMax[0]
		if (!codigo) {
			codigo = 1
		}
		kitInstance.setCodigo(codigo.toString())
		kitInstance.setDescricao(params.nome)
		
		if (kitInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [kitInstance: kitInstance, loja: loja])
		}
	}
}
