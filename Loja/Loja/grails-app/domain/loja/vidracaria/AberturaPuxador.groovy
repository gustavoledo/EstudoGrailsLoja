package loja.vidracaria

import loja.Cor;
import loja.Loja 

class AberturaPuxador implements Comparable {

	static belongsTo = [abertura:Abertura, puxador:Puxador]
	
	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
}
