package loja.vidracaria

import loja.Cor;
import loja.Loja 
import loja.Produto;

class ItemAdicional extends Produto {

	static belongsTo = [loja:Loja]
	
}
