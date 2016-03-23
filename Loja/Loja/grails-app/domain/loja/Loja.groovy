package loja

class Loja  {

	String nome
	String nomeAbreviado
	String telefone
	String cnpj
	String razaoSocial
	String rua
	Integer numero
	String complemento
	String bairro
	String cidade
	String cep
	String uf
	Boolean matriz = true
	Boolean permitirVenda = true
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
		nomeAbreviado(blank:false, size:3..10)
		telefone(nullable:true)
		cnpj(nullable:true)
		razaoSocial(nullable:true, size:5..200)
		rua(nullable:true)
		numero(nullable:true)
		complemento(nullable:true)
		bairro(nullable:true, size:3..80)
		cidade(nullable:true, size:3..80)
		cep(nullable:true)
		uf(nullable:true, inList:["RJ", "SP", "MG", "PE", "BA"])
	}

	@Override
	public String toString() {
		return nome
	}

}
