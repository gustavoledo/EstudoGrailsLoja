package loja.vidracaria

import loja.Cor;
import loja.Loja 

class AberturaKit implements Comparable {

	static belongsTo = [abertura:Abertura, kit:Kit]

	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
}
