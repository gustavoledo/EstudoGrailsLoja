class ControleAcessoFilters {

    def filters = {

		all(controller:'*', action:'*') {
            before = {
				if (controllerName != 'controleAcesso') {
					if (!session.usuario) {
						redirect(controller: 'controleAcesso')
						return false
					}
				}
            }
        }
		
		
    }
	
}
