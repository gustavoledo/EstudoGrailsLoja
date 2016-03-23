package loja

class ControleAcessoController {
	
	def index = {
		if (session.usuario) {
			render(view: 'welcome')
		} else {
			render(view: 'login')
		}
	}

	def logon = {
		
		def errors = []
		if (!params.login || !params.senha) {
			errors += "Login e senha devem ser preenchidos."
		}
		
		if (errors.size() == 0) {
			def usuario = Usuario.findByLoginAndSenha(params.login, params.senha)
			
			if (!usuario || usuario.inativo) {
				errors += "Login inválido."
			} else {
				flash.errors = []
			
				//seta o tempo de expiracao p/ 8 horas
				session.setMaxInactiveInterval(3600*8);
			
				//verifica se esta associado a uma loja matriz
				def redeLojas = RedeLojas.findAll("from RedeLojas r where r.lojaMatriz.id = ${usuario?.loja?.id}")
			
				session.usuario = usuario
				if (redeLojas) {
					def lojasInstanceList = [redeLojas[0].lojaMatriz]
					
					redeLojas.each {
						lojasInstanceList += it.lojaFilial
					}
					
					session.usuario.setHasFilial(true)
					
					render(view: "selectLoja", model: [lojasInstanceList: lojasInstanceList])
					
					return
				} else {
					//verifica se loja filial
					def redeLoja = RedeLojas.find("from RedeLojas r where r.lojaFilial.id = ${usuario?.loja?.id}")
					if (redeLoja) {
						Loja lojaMatriz = redeLoja.lojaMatriz
						usuario.setLojaMatrizId(lojaMatriz?.id)
						Loja loja = Loja.get(usuario?.loja?.id)
						if (loja.permitirVenda) {
							session.usuario.setLojaFilialSelected(true)
						} else { //quando eh deposito
							def categorias = Categoria.findByLoja(lojaMatriz)
							def categoriasSigla = categorias.collect{it?.sigla}
							
							session.usuario.setCategorias(categoriasSigla)
						}
					} else {
						usuario.setLojaMatrizId(usuario?.loja?.id)
					}
				
					usuario.setLojaId(usuario?.loja?.id)

					if (usuario.loja) {
						Loja loja = Loja.get(usuario?.loja?.id)
						usuario.setNomeLojaSelected(loja.nome)
					}
					
					if (usuario?.loja && usuario.categorias.size() == 0) {
						def categorias = Categoria.findByLoja(usuario?.loja)
						def categoriasSigla = categorias.collect{it?.sigla}
						
						usuario.setCategorias(categoriasSigla)
					}
					
					render(view: 'welcome')
				}
				
			}
		}	
		
		if (errors.size() > 0) {
			flash.errors = errors
			render(view: "login")
		}
		
	}
	
	def selectLoja = {
		Loja loja = Loja.get(params.id)
		
		def categorias
		if (loja.matriz) {
			session.usuario.setLojaMatrizId(loja?.id)
			
			categorias = Categoria.findByLoja(loja)

		} else {
			def redeLoja = RedeLojas.find("from RedeLojas r where r.lojaFilial.id = ${params.id}")
			Loja lojaMatriz = redeLoja.lojaMatriz  
			session.usuario.setLojaMatrizId(lojaMatriz?.id)
			session.usuario.setLojaFilialSelected(true)
			
			categorias = Categoria.findByLoja(lojaMatriz)
		}
		
		session.usuario.setLojaId(loja?.id)
		session.usuario.setNomeLojaSelected(loja.nome)
		
		def categoriasSigla = categorias.collect{it?.sigla}
		session.usuario.setCategorias(categoriasSigla)
		
		render(view: 'welcome')
	}
	
	def logout = {
		session.usuario = null
		flash.errors = []
		render(view: "login")
	}
}
