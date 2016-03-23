package loja.vidracaria

import loja.Loja;

class VidroController {

	def scaffold = true
	
	def save = {
		def vidroInstance = new Vidro(params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		vidroInstance.setLoja(loja)
		
		//seta o codigo do produto
		def codigoMax = Vidro.executeQuery("select max(v.id) from Vidro v where v.loja.id = ${session.usuario.lojaId}")
		
		def codigo = codigoMax[0]
		if (!codigo) {
			codigo = 1
		}
		vidroInstance.setCodigo(codigo.toString())
		vidroInstance.setDescricao(params.nome)
		
		if (vidroInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [vidroInstance: vidroInstance, loja: loja])
		}
	}
}
