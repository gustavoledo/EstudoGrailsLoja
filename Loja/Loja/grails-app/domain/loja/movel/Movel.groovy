package loja.movel

import loja.Cor 
import loja.Fabricante;
import loja.Loja 
import loja.Produto 


class Movel extends Produto {

	static belongsTo = [fabricante: Fabricante, linha: Linha, 
		cor: Cor, padraoRevestimento: PadraoRevestimento, loja: Loja]
	
	String codigoFornecedor
	
	Double profundidade = 0.0
	Double largura = 0.0
	Double altura = 0.0

	String especificacoesTecnicas
	
	static constraints = {
		codigoFornecedor(nullable:true, size:1..20)
		profundidade(nullable:false)
		largura(nullable:false)
		altura(nullable:false)
		cor(nullable:true)
		especificacoesTecnicas(nullable:true, size:3..400)
	}
	
}
