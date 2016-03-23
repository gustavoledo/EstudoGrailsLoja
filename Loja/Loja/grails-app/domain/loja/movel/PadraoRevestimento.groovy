package loja.movel

import loja.Loja 


class PadraoRevestimento {

	static belongsTo = [loja:Loja]
	
	String nome
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
	}
	
	@Override
	public String toString() {
		return nome
	}

}
