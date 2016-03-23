package loja.vidracaria

import loja.Cor;
import loja.Fabricante;
import loja.Loja 
import loja.Produto;

class Vidro extends Produto {

	static belongsTo = [loja:Loja, cor: Cor, fabricante: Fabricante]
	
	Double espessura = 0.0
	
	static constraints = {
		espessura(nullable:false)
	}
	
}
