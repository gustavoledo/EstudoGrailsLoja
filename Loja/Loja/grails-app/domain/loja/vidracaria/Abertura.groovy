package loja.vidracaria

import loja.Cor;
import loja.Loja;
import loja.Produto;

class Abertura extends Produto {

	static belongsTo = [loja:Loja]
	
	static hasMany = [itensAdicionais:AberturaItemAdicional, itensExtras: ItemExtra, 
		vidros: AberturaVidro, kits: AberturaKit, puxadores: AberturaPuxador, 
		aluminios: AberturaAluminio]
	
	SortedSet itensAdicionais
	SortedSet itensExtras
	SortedSet vidros
	SortedSet kits
	SortedSet puxadores
	SortedSet aluminios
	
	static constraints = {
		id(display: false)
		nome(blank:false, size:3..80)
	}
	
	Double totalItens() {
		Double total = itensAdicionais ? itensAdicionais.collect{it.itemAdicional.precoUnitarioCompra}.sum() : 0
		return total
	}

	Double totalItensExtras() {
		Double total = itensExtras ? itensExtras.collect{it.precoUnitario*it.quantidade}.sum() : 0
		return total
	}

	Double totalVidros() {
		Double total = vidros ? vidros.collect{it.precoVidro}.sum() : 0
		return total
	}

	Double totalKits() {
		Double total = kits ? kits.collect{it.kit.precoUnitarioCompra}.sum() : 0
		return total
	}

	Double totalPuxadores() {
		Double total = puxadores ? puxadores.collect{it.puxador.precoUnitarioCompra}.sum() : 0
		return total
	}

	Double totalAluminios() {
		Double total = aluminios ? aluminios.collect{it.aluminio.precoUnitarioCompra}.sum() : 0
		return total
	}

	Double totalAbertura() {
		Double total = totalVidros() + totalKits() + totalPuxadores() + totalAluminios()
		return total
	}

	Double totalFinal() {
		Double total = totalAbertura() + totalItens() + totalItensExtras()
		double maoObra = secao.maoObra ? secao.maoObra : 0
		double taxas = secao.percentualLucro 
		total = (total + maoObra)*(1+taxas/100) 
		
		/*
		println 'totalAbertura: ' + totalAbertura()
		println 'totalItens: ' + totalItens()
		println 'totalItensExtras: ' + totalItensExtras()
		println 'percentualLucro: ' + secao.percentualLucro
		println 'maoObra: ' + secao.maoObra
		println 'total: ' + total
		*/ 

		return total
	}
	

}
