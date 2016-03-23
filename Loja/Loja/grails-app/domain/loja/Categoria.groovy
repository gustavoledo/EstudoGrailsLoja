package loja

class Categoria {

	static belongsTo = [loja:Loja]
	
	String sigla
	String nome
	
	static constraints = {
		id(display: false)
		sigla(blank:false, size:3..6)
		nome(blank:false, size:3..80)
	}
	
	@Override
	public String toString() {
		return nome
	}

}
