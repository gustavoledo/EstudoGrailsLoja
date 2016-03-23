package loja

import java.text.DecimalFormat;

class SortTableTagLib {

	def sortColumn = {attrs ->
		
		String imgDesabilitado = "${resource(dir:'images',file:'navigate_down.png')}"
		String imgCima = "${resource(dir:'images',file:'navigate_open.png')}"
		String imgBaixo = "${resource(dir:'images',file:'navigate_close.png')}"
		
		String imgAtual = imgDesabilitado
		String order = 'asc' 
		if (params.sort == attrs.property) {
			if (params.order == 'asc') {
				imgAtual = imgBaixo
				order = 'desc'
			} else {
				imgAtual = imgCima
			}
		} 

		String link = "<a style=\"text-decoration: none;\" href=\"${createLink(action: 'list')}?sort=${attrs.property}&order=${order}\">${attrs.property}&nbsp;<img border=\"0\" src=\"${imgAtual}\" /></a>"
		
		out << link
	}
		
}
