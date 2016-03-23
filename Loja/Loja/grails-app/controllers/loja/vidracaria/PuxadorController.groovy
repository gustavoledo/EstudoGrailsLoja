package loja.vidracaria

import loja.Loja;

class PuxadorController {

	def scaffold = true
	
	def save = {
		def puxadorInstance = new Puxador(params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		puxadorInstance.setLoja(loja)
		
		//seta o codigo do produto
		def codigoMax = Puxador.executeQuery("select max(p.id) from Puxador p where p.loja.id = ${session.usuario.lojaId}")
		
		def codigo = codigoMax[0]
		if (!codigo) {
			codigo = 1
		}
		puxadorInstance.setCodigo(codigo.toString())
		puxadorInstance.setDescricao(params.nome)
		
		if (puxadorInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [puxadorInstance: puxadorInstance, loja: loja])
		}
	}

}
