import loja.Perfil
import loja.Usuario

class BootStrap {

    def init = { servletContext ->
		if (Usuario.count() == 0) {
			Usuario usuario = new Usuario(nome: "Usuário Master", login: "usermaster", 
				senha: "master11", perfil: Perfil.MASTER)
			usuario.save(flush: true)
			println "Usuário master criado com sucesso."
		}
    }
	
    def destroy = {
    }
}
