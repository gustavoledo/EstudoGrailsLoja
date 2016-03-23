package loja.vidracaria

class ItemExtra implements Comparable {

	String descricao
	Integer quantidade = 0
	Double precoUnitario = 0

	int compareTo(obj) {
		return this.id ? this.id.compareTo(obj.id) : 1
	}
}
