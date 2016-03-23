package loja

enum Perfil {
	
	MASTER("MASTER", "Master"),
	ADMINISTRADOR("ADM", "Administrador"),
	GERENTE("GER", "Gerente"),
	VENDEDOR("VEND", "VENDEDOR")
	
	String sigla
	String name
	
	Perfil(String sigla, String name) {
		this.sigla = sigla
		this.name = name
	}	
	
}
