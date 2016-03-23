<%=packageName ? "package ${packageName}\n\n" : ''%>

import loja.Loja;

class ${className}Controller {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	static validateExcludes = ['Movel']

	def grailsApplication
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

		def ${propertyName}List
		def ${propertyName}Total = 0
        def ${propertyName} = new ${className}()
		
		boolean temAtributoLoja = ${propertyName}.metaClass.properties.find { it.name =="loja" } &&
			session.usuario.lojaId

		if (temAtributoLoja) {

			def lojaMatriz = Loja.get(session.usuario.lojaMatrizId)
			${propertyName}List = ${className}.findAllByLoja(lojaMatriz, [max: params.max, offset:params.offset, sort: params.sort, order: params.order])
			
			if (${propertyName}List) {
				def ${propertyName}ListCount = ${className}.executeQuery("select count(*) from ${className} l where l.loja.id = ?", [session.usuario.lojaMatrizId])
				${propertyName}Total = ${propertyName}ListCount[0]
			} 
			
		} else {
			${propertyName}List = ${className}.list(params)
			${propertyName}Total = ${className}.count()
		}

        [${propertyName}List: ${propertyName}List, ${propertyName}Total: ${propertyName}Total]
    }

    def create = {
        def ${propertyName} = new ${className}()
        ${propertyName}.properties = params
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
		render(view: "create", model: [${propertyName}: ${propertyName}, loja: loja])
    }

    def save = {
        def ${propertyName} = new ${className}(params)
		
		def loja
		
		boolean temAtributoLoja = ${propertyName}.metaClass.properties.find { it.name =="loja" } &&
			session.usuario.lojaId

		if (temAtributoLoja) {
			loja = Loja.get(session.usuario.lojaMatrizId)
			${propertyName}.setLoja(loja)
		}
		
        if (validateFields(temAtributoLoja, null, params.nome, session.usuario.lojaMatrizId, flash) && ${propertyName}.save(flush: true)) {
			flash.message = "\${params.nome} cadastrado(a) com sucesso"
            redirect(action: "list")
        }
        else {
			render(view: "create", model: [${propertyName}: ${propertyName}, loja: loja])
        }
    }

    def show = {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
        else {
            [${propertyName}: ${propertyName}]
        }
    }

    def edit = {
        def ${propertyName} = ${className}.get(params.id)
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
        if (!${propertyName}) {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [${propertyName}: ${propertyName}, loja: loja]
        }
    }

    def update = {
        def ${propertyName} = ${className}.get(params.id)
		
        if (${propertyName}) {
            if (params.version) {
                def version = params.version.toLong()
                if (${propertyName}.version > version) {
                    <% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
                    ${propertyName}.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: '${domainClass.propertyName}.label', default: '${className}')] as Object[], "Another user has updated this ${className} while you were editing")
                    render(view: "edit", model: [${propertyName}: ${propertyName}])
                    return
                }
            }
            ${propertyName}.properties = params
			
			boolean temAtributoLoja = ${propertyName}.metaClass.properties.find { it.name =="loja" } &&
				session.usuario.lojaId

            if (!${propertyName}.hasErrors() && validateFields(temAtributoLoja, params.id.toLong(), params.nome, session.usuario.lojaMatrizId, flash) 
				&& ${propertyName}.save(flush: true)) {
				flash.message = "\${params.nome} atualizado(a) com sucesso"
				redirect(action: "list")
            }
            else {
                render(view: "edit", model: [${propertyName}: ${propertyName}])
            }
        }
        else {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def ${propertyName} = ${className}.get(params.id)
        if (${propertyName}) {
            try {
                ${propertyName}.delete(flush: true)
				flash.message = "\${${propertyName}.nome} removido(a) com sucesso"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "\${message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "\${message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])}"
            redirect(action: "list")
        }
    }
	
	private boolean validateFields(boolean temAtributoLoja, Long id, String nome, Long lojaId, Map flash) {
		if (!temAtributoLoja || validateExcludes.contains("${className}")) {
			return true	
		}
		
		def query = "from ${className} c where UPPER(c.nome) = ? and c.loja.id = ?"
		
		if (id) {
			query += " and c.id <> " + id
		}	
		
		def retorno = ${className}.find(query, [nome.toUpperCase(), lojaId])
		
		def errors = []
		if (retorno) {
			errors += "Já existe um registro com o nome informado."
		}
		
		flash.errors = errors
		
		return errors.size() == 0
	}
}
