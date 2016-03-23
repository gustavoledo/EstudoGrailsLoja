package loja

import loja.movel.Movel;

class Test {

	static main(args) {
	
		def secao = new Secao()
		def loja = new Loja()
		def movel = new Movel()
		
		println loja.properties.belongsTo && loja.properties.belongsTo.keySet().contains('loja')
		println secao.properties.belongsTo.keySet().contains('loja')
		println movel.properties.belongsTo.keySet().contains('loja')
		
	}

}
