package loja.vidracaria

import loja.Loja;

class AluminioController {

	def scaffold = true
	
	def save = {
		def aluminioInstance = new Aluminio(params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		aluminioInstance.setLoja(loja)
		
		//seta o codigo do produto
		def codigoMax = Aluminio.executeQuery("select max(a.id) from Aluminio a where a.loja.id = ${session.usuario.lojaId}")
		
		def codigo = codigoMax[0]
		if (!codigo) {
			codigo = 1
		}
		aluminioInstance.setCodigo(codigo.toString())
		aluminioInstance.setDescricao(params.nome)
		
		if (aluminioInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [aluminioInstance: aluminioInstance, loja: loja])
		}
	}
}
