package loja

class UsuarioController {

	def scaffold = true
	
	UsuarioService usuarioService
	
	def list = {
		
		def usuarioInstanceList
		if (session.usuario.perfil == Perfil.MASTER) {
			usuarioInstanceList = Usuario.list()
		} else {
			usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		}
		
		[usuarioInstanceList: usuarioInstanceList]
		
	}
	
	def create = {
		def usuarioInstance = new Usuario()
		usuarioInstance.properties = params
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
		def lojas
		if (session.usuario.perfil == Perfil.MASTER) {
			lojas = Loja.list()
		} else {
			if (session.usuario.hasFilial) {
				lojas = usuarioService.recuperaLojas(session.usuario.lojaId)
			}
		}
		
		render(view: "create", model: [usuarioInstance: usuarioInstance, loja: loja, lojas: lojas])
	}
	
	def edit = {
		def usuarioInstance = Usuario.get(params.id)
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
		def lojas
		if (session.usuario.perfil == Perfil.MASTER) {
			lojas = Loja.list()
		} else {
			if (session.usuario.hasFilial) {
				lojas = usuarioService.recuperaLojas(session.usuario.lojaId)
			}
		}
		
		render(view: "edit", model: [usuarioInstance: usuarioInstance, loja: loja, lojas: lojas])
	}

	
	def alterarSenha = {
		def usuarioInstance = session.usuario
		
		render(view: "editSenha", model: [usuarioInstance: usuarioInstance])
	}
	
	def save = {
		def usuarioInstance = new Usuario(params)
		
		if (validateFields() && usuarioInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			
			if (params.origemMovimentacao) {
				response.sendRedirect("${request.contextPath}/movimentacao/filterCliente?opcaoMovimentacao=VENDA&cpf=${usuarioInstance.cpf}&clienteId=${usuarioInstance.id}")
			} else {
				redirect(action: "list")
			}
		}
		else {
			render(view: "create", model: [usuarioInstance: usuarioInstance])
		}
	}
	
	def update = {
		def usuarioInstance = Usuario.get(params.id)
		if (usuarioInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (usuarioInstance.version > version) {
					
					usuarioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'usuario.label', default: 'Usuário')] as Object[], "Another user has updated this Usuario while you were editing")
					render(view: "edit", model: [usuarioInstance: usuarioInstance])
					return
				}
			}
			usuarioInstance.properties = params
			if (validateFields() && !usuarioInstance.hasErrors() && usuarioInstance.save(flush: true)) {
				if (params.origemSenha) {
					flash.message = "Senha alterada com sucesso."
					render(view: "editSenha", model: [usuarioInstance: usuarioInstance])
				} else {
					flash.message = "${message(code: 'default.updated.message', args: [message(code: 'usuario.label', default: 'Usuário'), usuarioInstance.id])}"
					redirect(action: "list")
				}
			}
			else {
				render(view: "edit", model: [usuarioInstance: usuarioInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuário'), params.id])}"
			redirect(action: "list")
		}
	}

	
	private boolean validateFields() {
		def query = "from Usuario u where UPPER(u.login) = ? and u.loja.id = ? "
		
		if (params.id) {
			query += " and u.id <> " + params.id
		}
		
		def user = Usuario.find(query, [params.login.toUpperCase(), params['loja.id'].toLong()])
		
		def errors = []
		if (user) {
			errors += "Já existe um usuário com a chave informada."
		}
		
		flash.errors = errors
		
		return errors.size() == 0
	}

	
}
