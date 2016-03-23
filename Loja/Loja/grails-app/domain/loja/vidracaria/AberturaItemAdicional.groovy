package loja.vidracaria

import loja.Cor;
import loja.Loja 

class AberturaItemAdicional implements Comparable {

	static belongsTo = [abertura:Abertura, itemAdicional:ItemAdicional]

	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
}
