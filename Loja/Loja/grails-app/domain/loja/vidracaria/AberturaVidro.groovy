package loja.vidracaria

import loja.Cor;
import loja.Loja 

class AberturaVidro implements Comparable {

	static belongsTo = [abertura:Abertura, vidro:Vidro]
	
	Double largura = 0.0
	Double altura = 0.0
	Integer qtdTranspase = 0
	Double precoVidro
	
	static constraints = {
		largura(nullable:false)
		altura(nullable:false)
		qtdTranspase(nullable:false)
		precoVidro(nullable:false)
	}
	
	Double totalVidro() {
		largura = arredondaDimensao(largura)
		altura = arredondaDimensao(altura)

		Double total = (((largura + qtdTranspase*50) * altura) * precoVidro)/1000000
		return total
	}

	Double arredondaDimensao(Double valor) {
		Double resto = valor % 50
		if (resto == 0) {
			return valor
		} else {
			return (valor + 50 - resto)
		}
	}

	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}

}
