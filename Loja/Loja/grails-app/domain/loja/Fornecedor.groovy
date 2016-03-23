package loja

class Fornecedor  {

	static belongsTo = [loja:Loja]
	
	String nome
	String cnpj
	String razaoSocial
	String rua
	Integer numero
	String complemento
	String bairro
	String cidade
	String cep
	String uf
	String telefone
	String fax
	String email
	String observacao
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
		cnpj(blank:false)
		razaoSocial(blank:false, size:5..200)
		rua(blank:false)
		numero(nullable:false)
		complemento(nullable:true)
		bairro(blank:false, size:3..80)
		cidade(blank:false, size:3..80)
		cep(blank:false)
		uf(blank:false, inList:["RJ", "SP", "MG", "PE", "BA"])
		telefone(blank:false)
		fax(nullable:true)
		email(nullable:true, email: true)
		observacao(nullable:true)
	}
	
	@Override
	public String toString() {
		return nome
	}
	
}
