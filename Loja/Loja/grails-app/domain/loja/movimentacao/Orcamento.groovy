package loja.movimentacao


import java.util.Date;
import java.util.SortedSet;

import loja.Cliente 
import loja.Loja 
import loja.Usuario 

class Orcamento {

	static belongsTo = [loja:Loja, usuario:Usuario, cliente: Cliente]
	static hasMany = [itens:ItemOrcamento]
	
	Date data
	String formaPagamento
	SortedSet itens

	static constraints = {
		data(nullable:false)
		formaPagamento(nullable:true)
		loja(nullable:false)
		usuario(nullable:false)
		cliente(nullable:true)
	}
}
