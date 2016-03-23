package loja


class ProdutoDemo extends Produto {

	static belongsTo = [fabricante: Fabricante, loja: Loja]

}
