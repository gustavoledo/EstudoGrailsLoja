package loja

class Estoque {

	Loja loja
	Produto produto
	Long totalEntradas = 0
	Long totalSaidasComEntrega = 0
	Long totalSaidasSemEntrega = 0
	
	public void addEntrada(Double entrada) {
		totalEntradas += entrada
	}

	public void addSaidaComEntrega(Long saida) {
		totalSaidasComEntrega += saida
	}

	public void addSaidaSemEntrega(Long saida) {
		totalSaidasSemEntrega += saida
	}

	public Long getEstoqueFisicoEntradas() {
		return totalEntradas - totalSaidasComEntrega	
	}

	public Long getEstoqueFisicoSaidas() {
		return totalSaidasSemEntrega
	}

	public Long getSaldo() {
		return getEstoqueFisicoEntradas() - getEstoqueFisicoSaidas()
	}
	
	public boolean naoTemEstoque() {
		return totalEntradas == 0 && totalSaidasComEntrega == 0 && totalSaidasSemEntrega == 0 
	}
}
