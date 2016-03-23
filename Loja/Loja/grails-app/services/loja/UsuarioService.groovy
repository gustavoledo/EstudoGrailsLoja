package loja

class UsuarioService {

	List<Usuario> recuperaUsuariosByLoja(Long lojaId) {
		def redeLojas = RedeLojas.findAll("from RedeLojas r where r.lojaMatriz.id = ${lojaId}")
		
		def usuarioInstanceList
		if (redeLojas) {
			def lojasInstanceList = [redeLojas[0].lojaMatriz]
			redeLojas.each {
				lojasInstanceList += it.lojaFilial
			}
			
			String lojaIds = lojasInstanceList.collect{it.id}.join(",")
			usuarioInstanceList = Usuario.findAll("from Usuario u where u.loja.id in (${lojaIds})")
			
		} else {
			usuarioInstanceList = Usuario.findAll("from Usuario u where u.loja.id = ${lojaId}")
		}

		return usuarioInstanceList
	}
	
	List<Loja> recuperaLojas(Long lojaId) {
		def redeLojas = RedeLojas.findAll("from RedeLojas r where r.lojaMatriz.id = ${lojaId}")

		def lojasInstanceList = [redeLojas[0].lojaMatriz]
		redeLojas.each {
			lojasInstanceList += it.lojaFilial
		}

		return lojasInstanceList
	}
}
