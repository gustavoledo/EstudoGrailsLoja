package loja.vidracaria

import loja.Cor;
import loja.Loja 
import loja.Produto;

class Aluminio extends Produto {

	static belongsTo = [loja:Loja, cor: Cor]
	
	Double tamanho = 0.0
	
	static constraints = {
		tamanho(nullable:false)
	}
	
}
