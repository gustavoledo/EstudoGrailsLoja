package loja

class FornecedorController {

	def scaffold = true

    def save = {
        def fornecedorInstance = new Fornecedor(params)
		
		Loja loja = Loja.get(session.usuario.lojaMatrizId)
		fornecedorInstance.setLoja(loja)
		
        if (fornecedorInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			
			if (params.origemMovimentacao) {
				response.sendRedirect("${request.contextPath}/movimentacao/filterFornecedor?opcaoMovimentacao=COMPRA&cnpj=${fornecedorInstance.cnpj}&fornecedorId=${fornecedorInstance.id}")
			} else {
				redirect(action: "list")
			}

        }
        else {
			render(view: "create", model: [fornecedorInstance: fornecedorInstance, loja: loja])
        }
    }

}
