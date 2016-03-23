package loja.vidracaria

import loja.Cor;
import loja.Loja 

class AberturaAluminio implements Comparable {

	static belongsTo = [abertura:Abertura, aluminio:Aluminio]

	Cor corAluminio
	
	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
}
