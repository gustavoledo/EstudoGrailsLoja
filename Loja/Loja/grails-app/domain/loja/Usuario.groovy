package loja


class Usuario {

	static belongsTo = [loja:Loja]
	
	String nome
	String login
	String senha
	Perfil perfil
	Double descontoMaximo = 0.0
	Boolean inativo = false
	
	Long lojaId
	Long lojaMatrizId
	Boolean lojaFilialSelected
	Boolean hasFilial
	String nomeLojaSelected
	def categorias = []
	
	static transients = ['lojaId', 'lojaMatrizId', 'lojaFilialSelected', 'hasFilial', 'nomeLojaSelected', 'categorias']
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
		login(blank:false, size:3..10)
		senha(blank:false, password:true, size:5..10)
		descontoMaximo(nullable:false)
		loja(nullable:true)
	}
	
	@Override
	public String toString() {
		return nome
	}
	
	public boolean hasCategoriaMovel() {
		return categorias.any{it.indexOf("MOV") > -1}
	}
	
	public boolean hasCategoriaRoupa() {
		return categorias.any{it.indexOf("ROU") > -1}
	}

	public boolean hasCategoriaVidro() {
		return categorias.any{it.indexOf("VID") > -1}
	}

	public boolean hasCategoriaDemo() {
		return categorias.any{it.indexOf("DEM") > -1}
	}

	public String categoriaLoja() {
		String categoria = null
		if (categorias.any{it.indexOf("MOV") > -1}) {
			categoria = "Movel"
		} else {
			categoria = "Roupa"
		}
		return categoria
	}

}
