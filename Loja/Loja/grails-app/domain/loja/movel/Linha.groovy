package loja.movel

import loja.Fabricante;
import loja.Loja 


class Linha {

	static belongsTo = [loja:Loja, fabricante:Fabricante]
	static hasMany = [coresLinha: CorLinha]
	
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
