package loja


class FusionChartTagLib {

	def fusionChart = {attrs ->
		
		def objectFlash = 
			"<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" " +
				"codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0\" " +
				"width=\"100%\" height=\"${attrs.height}\">" +
				"<param name=\"wmode\" value=\"transparent\">" +
				"<param name=\"movie\" value=\"${resource(dir:'FusionCharts',file:attrs.flashFile)}\" />" +
				"<param name=\"FlashVars\" value=\"&dataXML=${attrs.dataXML}&chartWidth=${attrs.chartWidth}&chartHeight=${attrs.chartHeight}\">" +
				"<param name=\"quality\" value=\"high\" />" +
				"<embed wmode=\"transparent\" src=\"${resource(dir:'FusionCharts',file:attrs.flashFile)}\" flashVars=\"&dataXML=${attrs.dataXML}&chartWidth=${attrs.chartWidth}&chartHeight=${attrs.chartHeight}\"" +
				"quality=\"high\" width=\"${attrs.width}\" height=\"${attrs.height}\" name=\"ChartTBM\" type=\"application/x-shockwave-flash\"" +
				"pluginspage=\"http://www.macromedia.com/go/getflashplayer\" />" +
			"</object>"
		
		out << objectFlash
	}
	
	
}
