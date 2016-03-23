package loja

import loja.movimentacao.Venda;

class ClienteController {
	
	def scaffold = true
	
	UsuarioService usuarioService
	
	
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		
		def clienteInstanceList
		def clienteInstanceTotal = 0
		def clienteInstance = new Cliente()
		
		def lojaMatriz = Loja.get(session.usuario.lojaMatrizId)
		params.sort = "nome"
		clienteInstanceList = Cliente.findAllByLoja(lojaMatriz, [max: params.max, offset:params.offset, sort: params.sort, order: params.order])
		
		if (clienteInstanceList) {
			def clienteInstanceListCount = Cliente.executeQuery("select count(*) from Cliente c where c.loja.id = ?", [session.usuario.lojaMatrizId])
			clienteInstanceTotal = clienteInstanceListCount[0]
		}
		
		[clienteInstanceList: clienteInstanceList, clienteInstanceTotal: clienteInstanceTotal]
	}
	
	def filter = {
		String query = "from Cliente c where c.loja.id = ${session.usuario.lojaMatrizId} "
		
		if (params.nome) {
			query += "and UPPER(c.nome) like '%${params.nome.toUpperCase()}%' "
		}
		
		if (params.cpf) {
			query += "and c.cpf = '${params.cpf}' "
		}
		
		if (params.telefone) {
			query += "and (c.telefoneResidencial like '%${params.telefone}%' " +
			"or c.telefoneCelular like '%${params.telefone}%' " +
			"or c.telefoneComercial like '%${params.telefone}%' )"
		}
		
		query += " order by c.nome"
		
		def clienteInstanceList = Cliente.findAll(query)
		
		render(view: 'list', model: [clienteInstanceList: clienteInstanceList])
	}
	
	def create = {
		def clienteInstance = new Cliente()
		
		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		params.tipoPessoa = 'F'
		
		return [clienteInstance: clienteInstance, usuarioInstanceList: usuarioInstanceList]
	}

	def edit = {
		def clienteInstance = Cliente.get(params.id)
		
		def usuarioInstanceList = usuarioService.recuperaUsuariosByLoja(session.usuario.lojaId)
		params.tipoPessoa = !clienteInstance.cpf || clienteInstance.cpf.length() < 16 ? 'F' : 'J'
		 
		return [clienteInstance: clienteInstance, usuarioInstanceList: usuarioInstanceList]
	}

	def save = {
		def clienteInstance = new Cliente()
		
		bindData(clienteInstance, params)
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		clienteInstance.setLoja(loja)
		
		boolean validate = clienteInstance.validate() & validateFields() 
		
		if (validate && clienteInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
			
			if (params.origemMovimentacao) {
				response.sendRedirect("${request.contextPath}/movimentacao/filterCliente?opcaoMovimentacao=VENDA&nome=${clienteInstance.nome}&clienteId=${clienteInstance.id}")
			} else {
				redirect(action: "list")
			}
		}
		else {
			render(view: "create", model: [clienteInstance: clienteInstance, loja: loja])
		}
	}
	
	def update = {
		def clienteInstance = Cliente.get(params.id)
		if (clienteInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (clienteInstance.version > version) {
					
					clienteInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'cliente.label', default: 'Usuário')] as Object[], "Another user has updated this Cliente while you were editing")
					render(view: "edit", model: [clienteInstance: clienteInstance])
					return
				}
			}
			
			bindData(clienteInstance, params)
			
			boolean validate = clienteInstance.validate() && validateFields()
			 
			if (validate && clienteInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'cliente.label', default: 'Cliente'), clienteInstance.id])}"
				redirect(action: "list")
			}
			else {
				render(view: "edit", model: [clienteInstance: clienteInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'cliente.label', default: 'Usuário'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def pedidos = {
		def clienteInstance = Cliente.get(params.id)
		def movimentacaoInstanceList = Venda.findAll("from Venda v where v.cliente.id = ${params.id}")
		
		[clienteInstance: clienteInstance, movimentacaoInstanceList: movimentacaoInstanceList]
		
	}
	
	private boolean validateFields() {
		def errors = []
		if (params.cpf) {
			if (params.tipoPessoa == 'F') {
				if (!validateCpf(params.cpf)) {
					errors += "CPF inválido."
				}
			} else {
				if (!validateCnpj(params.cpf)) {
					errors += "CNPJ inválido."
				}
			}
			//verifica se existe cliente ja cadastrado com o cpf/cnpj
			if (errors.size() == 0) {
				String query = "from Cliente c where c.cpf = '${params.cpf}' " +
					"and c.loja.id = ${session.usuario.lojaMatrizId} "
					
				if (params.id) {
					query += "and c.id <> ${params.id}"
				}
				
				def clienteJaExiste = Cliente.find(query)
				
				if (clienteJaExiste) {
					errors += "Já existe um cliente com o CPF/CNPJ informado."
				} 
			}
			
			flash.errors = errors
		}

		return errors.size() == 0 
	}
	
	private String recuperaSoNumeros(String cpf) {
		String retorno = ""
		for (int i = 0; i < cpf.length(); i++) {
			if (Character.isDigit(cpf.charAt(i))) {
				retorno += cpf.charAt(i)
			}
		}
		return retorno
	}
	
	private boolean validateCpf(String cpf) {
		
		cpf = recuperaSoNumeros(cpf)
		
		// considera-se erro cpf's formados por uma sequencia de numeros iguais
		if (cpf.equals("00000000000") || cpf.equals("11111111111") ||
		cpf.equals("22222222222") || cpf.equals("33333333333") ||
		cpf.equals("44444444444") || cpf.equals("55555555555") ||
		cpf.equals("66666666666") || cpf.equals("77777777777") ||
		cpf.equals("88888888888") || cpf.equals("99999999999") ||
		(cpf.length() != 11))
			return(false);
		
		char dig10, dig11;
		int sm, i, r, num, peso;
		
		// "try" - protege o codigo para eventuais erros de conversao de tipo (int)
		try {
			// Calculo do 1o. Digito Verificador
			sm = 0;
			peso = 10;
			for (i=0; i<9; i++) {             
				// converte o i-esimo caractere do cpf em um numero:
				// por exemplo, transforma o caractere '0' no inteiro 0        
				// (48 eh a posicao de '0' na tabela ASCII)        
				num = (int)(cpf.charAt(i) - 48);
				sm = sm + (num * peso);
				peso = peso - 1;
			}
			
			r = 11 - (sm % 11);
			if ((r == 10) || (r == 11))
				dig10 = '0';
			else dig10 = (char)(r + 48); // converte no respectivo caractere numerico
			
			// Calculo do 2o. Digito Verificador
			sm = 0;
			peso = 11;
			for(i=0; i<10; i++) {
				num = (int)(cpf.charAt(i) - 48);
				sm = sm + (num * peso);
				peso = peso - 1;
			}
			
			r = 11 - (sm % 11);
			if ((r == 10) || (r == 11))
				dig11 = '0';
			else dig11 = (char)(r + 48);
			
			// Verifica se os digitos calculados conferem com os digitos informados.
			if ((dig10 == cpf.charAt(9)) && (dig11 == cpf.charAt(10)))
				return(true);
			else return(false);
		} catch (InputMismatchException erro) {
			return(false);
		}
	}
	
	private boolean validateCnpj(String cnpj) {
		cnpj = recuperaSoNumeros(cnpj)
		
		// considera-se erro cnpj's formados por uma sequencia de numeros iguais
		if (cnpj.equals("00000000000000") || cnpj.equals("11111111111111") ||
		cnpj.equals("22222222222222") || cnpj.equals("33333333333333") ||
		cnpj.equals("44444444444444") || cnpj.equals("55555555555555") ||
		cnpj.equals("66666666666666") || cnpj.equals("77777777777777") ||
		cnpj.equals("88888888888888") || cnpj.equals("99999999999999") ||
		(cnpj.length() != 14))
			return(false);
		
		char dig13, dig14;
		int sm, i, r, num, peso;
		
		// "try" - protege o código para eventuais erros de conversao de tipo (int)
		try {
			// Calculo do 1o. Digito Verificador
			sm = 0;
			peso = 2;
			for (i=11; i>=0; i--) {
				// converte o i-ésimo caractere do cnpj em um número:
				// por exemplo, transforma o caractere '0' no inteiro 0
				// (48 eh a posição de '0' na tabela ASCII)
				num = (int)(cnpj.charAt(i) - 48);
				sm = sm + (num * peso);
				peso = peso + 1;
				if (peso == 10)
					peso = 2;
			}
			
			r = sm % 11;
			if ((r == 0) || (r == 1))
				dig13 = '0';
			else dig13 = (char)((11-r) + 48);
			
			// Calculo do 2o. Digito Verificador
			sm = 0;
			peso = 2;
			for (i=12; i>=0; i--) {
				num = (int)(cnpj.charAt(i)- 48);
				sm = sm + (num * peso);
				peso = peso + 1;
				if (peso == 10)
					peso = 2;
			}
			
			r = sm % 11;
			if ((r == 0) || (r == 1))
				dig14 = '0';
			else dig14 = (char)((11-r) + 48);
			
			// Verifica se os dígitos calculados conferem com os dígitos informados.
			if ((dig13 == cnpj.charAt(12)) && (dig14 == cnpj.charAt(13)))
				return(true);
			else return(false);
		} catch (InputMismatchException erro) {
			return(false);
		}
	}
}
