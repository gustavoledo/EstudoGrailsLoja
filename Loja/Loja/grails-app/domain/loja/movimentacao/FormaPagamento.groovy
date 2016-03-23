package loja.movimentacao


import java.util.ArrayList;
import java.util.List;
import loja.Loja 
import loja.Pagamento 
import loja.TipoPagamento 

class FormaPagamento {

	static belongsTo = [loja:Loja]
	
	String nome
	TipoPagamento tipoPagamento
	Integer qtdParcelasPermitida
	Integer qtdParcelasSemJuros
	Double valorJuros = 1
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
		tipoPagamento(nullable:false)
		qtdParcelasPermitida(nullable:false)
	}
	
	@Override
	public String toString() {
		return nome
	}
	
	public List<Pagamento> recuperaPagamentos(Double valor) {
		List<Pagamento> retorno = new ArrayList<Pagamento>()
		for (int i = 1; i <= qtdParcelasPermitida; i++) {
			Boolean juros = i > qtdParcelasSemJuros
			Double valorCalculado = juros ? (valor/i)*valorJuros : (valor/i)  
			Pagamento p = new Pagamento(qtdParcelas: i, valor: valorCalculado, juros: juros)
			p.setNome(p.toString())
			retorno.add(p)
		}
		return retorno
	} 
}
