package loja.movimentacao



import loja.Loja;

class MovimentacaoEstoqueController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def grailsApplication
	
    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)

		def movimentacaoEstoqueInstanceList
		def movimentacaoEstoqueInstanceTotal = 0
        def movimentacaoEstoqueInstance = new MovimentacaoEstoque()
		if (movimentacaoEstoqueInstance.properties.belongsTo &&
			movimentacaoEstoqueInstance.properties.belongsTo.keySet().contains('loja') &&
			session.usuario.lojaId) {

			Loja loja = Loja.get(session?.usuario?.lojaId)
			movimentacaoEstoqueInstanceList = MovimentacaoEstoque.findAllByLoja(loja, [max: params.max, offset:params.offset, sort: params.sort, order: params.order])
			
			if (movimentacaoEstoqueInstanceList) {
				def movimentacaoEstoqueInstanceListCount = MovimentacaoEstoque.executeQuery("select count(*) from MovimentacaoEstoque l where l.loja.id = ?", [session.usuario.lojaId])
				movimentacaoEstoqueInstanceTotal = movimentacaoEstoqueInstanceListCount[0]
			} 
			
		} else {
			movimentacaoEstoqueInstanceList = MovimentacaoEstoque.list(params)
			movimentacaoEstoqueInstanceTotal = MovimentacaoEstoque.count()
		}

        [movimentacaoEstoqueInstanceList: movimentacaoEstoqueInstanceList, movimentacaoEstoqueInstanceTotal: movimentacaoEstoqueInstanceTotal]
    }

    def create = {
        def movimentacaoEstoqueInstance = new MovimentacaoEstoque()
        movimentacaoEstoqueInstance.properties = params
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
		render(view: "create", model: [movimentacaoEstoqueInstance: movimentacaoEstoqueInstance, loja: loja])
    }

    def save = {
        def movimentacaoEstoqueInstance = new MovimentacaoEstoque(params)
		
		Loja loja = Loja.get(session?.usuario?.lojaId)
		movimentacaoEstoqueInstance.setLoja(loja)
		
        if (movimentacaoEstoqueInstance.save(flush: true)) {
			flash.message = "Cadastro realizado com sucesso. "
            redirect(action: "list")
        }
        else {
			render(view: "create", model: [movimentacaoEstoqueInstance: movimentacaoEstoqueInstance, loja: loja])
        }
    }

    def show = {
        def movimentacaoEstoqueInstance = MovimentacaoEstoque.get(params.id)
        if (!movimentacaoEstoqueInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque'), params.id])}"
            redirect(action: "list")
        }
        else {
            [movimentacaoEstoqueInstance: movimentacaoEstoqueInstance]
        }
    }

    def edit = {
        def movimentacaoEstoqueInstance = MovimentacaoEstoque.get(params.id)
		
		def loja = loja.Loja.get(session.usuario.lojaMatrizId)
		
        if (!movimentacaoEstoqueInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [movimentacaoEstoqueInstance: movimentacaoEstoqueInstance, loja: loja]
        }
    }

    def update = {
        def movimentacaoEstoqueInstance = MovimentacaoEstoque.get(params.id)
		
        if (movimentacaoEstoqueInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (movimentacaoEstoqueInstance.version > version) {
                    
                    movimentacaoEstoqueInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque')] as Object[], "Another user has updated this MovimentacaoEstoque while you were editing")
                    render(view: "edit", model: [movimentacaoEstoqueInstance: movimentacaoEstoqueInstance])
                    return
                }
            }
            movimentacaoEstoqueInstance.properties = params
            if (!movimentacaoEstoqueInstance.hasErrors() && movimentacaoEstoqueInstance.save(flush: true)) {
				flash.message = "Atualização realizada com sucesso. "
				redirect(action: "list")
            }
            else {
                render(view: "edit", model: [movimentacaoEstoqueInstance: movimentacaoEstoqueInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def movimentacaoEstoqueInstance = MovimentacaoEstoque.get(params.id)
        if (movimentacaoEstoqueInstance) {
            try {
                movimentacaoEstoqueInstance.delete(flush: true)
				flash.message = "Exclusão realizada com sucesso. "
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque'), params.id])}"
            redirect(action: "list")
        }
    }
}
