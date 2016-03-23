package loja.vidracaria

import loja.Cor;
import loja.Loja 
import loja.Produto;

class Kit extends Produto {

	static belongsTo = [loja:Loja, cor: Cor]
	
}
