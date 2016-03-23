package loja.movel


import loja.Produto;
import loja.movel.Movel;

class MovelController {

	def scaffold = true
	
	def filter = {
		String query = "from Movel m where m.loja.id = ${session.usuario.lojaMatrizId} "
		
		if (params.codigo) {
			query += "and m.codigo = '${params.codigo}' "
		}
		
		if (params.nome) {
			query += "and (m.nome like '%${params.nome}%' or m.descricao like '%${params.nome}%' ) "
		}

		if (params.fabricanteId) {
			query += "and m.fabricante.id = ${params.fabricanteId} "
		}

		if (params.linhaId) {
			query += "and m.linha.id = ${params.linhaId} "
		}

		if (params.secaoId) {
			query += "and m.secao.id = ${params.secaoId} "
		}
		
		def moveis = Movel.findAll(query)
		
		render(view: "list", model: [movelInstanceList: moveis]) 
	}
	
	def showFoto = {
		def produto = Produto.get(params.id)
		
		response.setContentType("image/jpg")
		response.setContentLength(produto.foto.size())
		
		OutputStream out = response.getOutputStream();
		out.write(produto.foto);
		out.close();
	}

}
