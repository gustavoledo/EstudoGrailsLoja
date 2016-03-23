package loja

class ProdutoDemoController {

	def scaffold = true
	
	def save = {
		def produtoDemoInstance = new ProdutoDemo(params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		produtoDemoInstance.setLoja(loja)
		
		//seta o codigo do produto
		def codigoMax = ProdutoDemo.executeQuery("select max(p.id) from ProdutoDemo p where p.loja.id = ${session.usuario.lojaId}")
		
		def codigo = codigoMax[0]
		if (!codigo) {
			codigo = 0
		}
		produtoDemoInstance.setCodigo(codigo.toString())
		
		if (produtoDemoInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			redirect(action: "list")
		}
		else {
			render(view: "create", model: [produtoDemoInstance: produtoDemoInstance, loja: loja])
		}
	}
}
