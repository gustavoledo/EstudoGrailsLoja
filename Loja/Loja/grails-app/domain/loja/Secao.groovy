package loja

class Secao {

	static belongsTo = [categoria:Categoria, loja: Loja]
	
	String nome
	String descricao
	Double percentualLucro
	Double maoObra
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
		descricao(size:3..100)
		percentualLucro(nullable:true)
		maoObra(nullable:true)
	}
	
	@Override
	public String toString() {
		return nome
	}

}
