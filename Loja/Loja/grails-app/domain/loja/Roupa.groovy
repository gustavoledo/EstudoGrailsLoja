package loja

class Roupa extends Produto {

	static belongsTo = [loja: Loja]
	
	String cor
	String tamanho
	String caracteristicas
	
	static constraints = {
		cor(blank:false, inList:["Amarelo", "Vermelho", "Azul", "Branco", "Preto", "Verde"])
		tamanho(blank:false, inList:["P", "M", "G", "GG", "XG"])
		caracteristicas(size:3..400)
	}
}
