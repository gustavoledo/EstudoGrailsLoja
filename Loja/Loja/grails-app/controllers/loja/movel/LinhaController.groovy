package loja.movel



import grails.converters.JSON;
import loja.Cor;
import loja.Fabricante;
import loja.Loja;

class LinhaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	static validateExcludes = ['Movel']

	def grailsApplication
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

		def linhaInstanceList
		def linhaInstanceTotal = 0
        def linhaInstance = new Linha()
		
		boolean temAtributoLoja = linhaInstance.properties.belongsTo &&
			linhaInstance.properties.belongsTo.keySet().contains('loja') &&
			session.usuario.lojaId

		if (temAtributoLoja) {

			def lojaMatriz = Loja.get(session.usuario.lojaMatrizId)
			linhaInstanceList = Linha.findAllByLoja(lojaMatriz, [max: params.max, offset:params.offset, sort: params.sort, order: params.order])
			
			if (linhaInstanceList) {
				def linhaInstanceListCount = Linha.executeQuery("select count(*) from Linha l where l.loja.id = ?", [session.usuario.lojaMatrizId])
				linhaInstanceTotal = linhaInstanceListCount[0]
			} 
			
		} else {
			linhaInstanceList = Linha.list(params)
			linhaInstanceTotal = Linha.count()
		}

        [linhaInstanceList: linhaInstanceList, linhaInstanceTotal: linhaInstanceTotal]
    }

    def create = {
        def linhaInstance = new Linha()
        linhaInstance.properties = params
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
		render(view: "create", model: [linhaInstance: linhaInstance, loja: loja])
    }

    def save = {
        def linhaInstance = new Linha(params)
		
		def cores = request.getParameterValues("coresLinhaIds")
		if (cores) {
			cores.each {
				Cor cor = Cor.get(it)
				CorLinha corLinha = new CorLinha(cor: cor, linha: linhaInstance)
				linhaInstance.addToCoresLinha(corLinha)
			}
		}
		
		def loja = Loja.get(session.usuario.lojaMatrizId)
		linhaInstance.setLoja(loja)
		
        if (validateFields(true, null, params.nome, session.usuario.lojaMatrizId, flash) && linhaInstance.save(flush: true)) {
			flash.message = "Cadastro de ${params.nome} realizado com sucesso. "
            redirect(action: "list")
        }
        else {
			render(view: "create", model: [linhaInstance: linhaInstance, loja: loja])
        }
    }

    def show = {
        def linhaInstance = Linha.get(params.id)
        if (!linhaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linha.label', default: 'Linha'), params.id])}"
            redirect(action: "list")
        }
        else {
            [linhaInstance: linhaInstance]
        }
    }

    def edit = {
        def linhaInstance = Linha.get(params.id)
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
        if (!linhaInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linha.label', default: 'Linha'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [linhaInstance: linhaInstance, loja: loja]
        }
    }

    def update = {
        def linhaInstance = Linha.get(params.id)
		
        if (linhaInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (linhaInstance.version > version) {
                    
                    linhaInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'linha.label', default: 'Linha')] as Object[], "Another user has updated this Linha while you were editing")
                    render(view: "edit", model: [linhaInstance: linhaInstance])
                    return
                }
            }
            linhaInstance.properties = params
			
			//atualiza as cores
			def coresLinhaAssociadas = []
			coresLinhaAssociadas += linhaInstance.coresLinha
			coresLinhaAssociadas.each {
				linhaInstance.removeFromCoresLinha(it)
				it.delete(flush:true)
			}
			
			def cores = request.getParameterValues("coresLinhaIds")
			if (cores) {
				cores.each {
					Cor cor = Cor.get(it)
					CorLinha corLinha = new CorLinha(cor: cor, linha: linhaInstance)
					linhaInstance.addToCoresLinha(corLinha)
				}
			}
	
			boolean temAtributoLoja = linhaInstance.properties.belongsTo &&
				linhaInstance.properties.belongsTo.keySet().contains('loja') &&
				session.usuario.lojaId

            if (!linhaInstance.hasErrors() && validateFields(temAtributoLoja, params.id.toLong(), params.nome, session.usuario.lojaMatrizId, flash) 
				&& linhaInstance.save(flush: true)) {
				flash.message = "Atualização de ${params.nome} realizada com sucesso. "
				redirect(action: "list")
            }
            else {
				def loja = loja.Loja.get(session.usuario.lojaMatrizId)
				
				println 'loja: ' + loja
                render(view: "edit", model: [linhaInstance: linhaInstance, loja: loja])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linha.label', default: 'Linha'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def linhaInstance = Linha.get(params.id)
        if (linhaInstance) {
            try {
                linhaInstance.delete(flush: true)
				flash.message = "Exclusão ${linhaInstance.nome} de realizada com sucesso. "
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'linha.label', default: 'Linha'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'linha.label', default: 'Linha'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def ajaxCoresByLinha = {
		def coresLinha = CorLinha.findAll("from CorLinha c where c.linha.id = ${params.id}")
		
		def cores = coresLinha.collect{it.cor}
		render cores as JSON
	}

	def ajaxLinhasByFabricante = {
		def linhas = Linha.findAll("from Linha l where l.fabricante.id = ${params.id}")
		
		render linhas as JSON
	}

	private boolean validateFields(boolean temAtributoLoja, Long id, String nome, Long lojaId, Map flash) {
		if (!temAtributoLoja || validateExcludes.contains("Linha")) {
			return true	
		}
		
		def query = "from Linha c where UPPER(c.nome) = ? and c.loja.id = ?"
		
		if (id) {
			query += " and c.id <> " + id
		}	
		
		def retorno = Linha.find(query, [nome.toUpperCase(), lojaId])
		
		def errors = []
		if (retorno) {
			errors += "Já existe um registro com o nome informado."
		}
		
		flash.errors = errors
		
		return errors.size() == 0
	}
}
