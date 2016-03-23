package loja

import java.util.Date;

class Cliente  {
	
	static belongsTo = [loja:Loja, vendedorComissao:Usuario]
	
	String nome
	String telefoneResidencial
	String telefoneCelular
	String telefoneComercial
	String radioNextel
	String email
	String sexo
	String rg
	String cpf
	String rua
	Integer numero
	String complemento
	String bairro
	String cidade
	String cep
	String uf
	String referencia
	String contato1
	String contato2
	
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
		telefoneResidencial(nullable:true)
		telefoneCelular(nullable:true)
		telefoneComercial(nullable:true)		
		radioNextel(nullable:true)		
		email(nullable:true, email: true)		
		sexo(inList:["M", "F"])
		rg(nullable:true)
		cpf(nullable:true)
		rua(blank:false)
		numero(nullable:false)
		complemento(nullable:true)
		bairro(blank:false, size:3..80)
		cidade(blank:false, size:3..80)
		cep(nullable:true)
		uf(blank:false, inList:["RJ", "SP", "MG", "PE", "BA"])
		referencia(blank:false)
		contato1(nullable:true)
		contato2(nullable:true)
		vendedorComissao(nullable:true)
	}
	
	@Override
	public String toString() {
		return nome
	}

}
