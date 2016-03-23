		                <table id="tableItensProduto">
		                    <thead>
		                        <tr>
		                        
		                        	<th width="5%">Item</th>
		                        
		                        	<th width="20%">Descrição do Item</th>
		                        
		                        	<th width="10%">Família</th>
		                        	
		                        	<th width="10%">Quant</th>

		                        	<th width="15%">Vlr. Unit.</th>
		                        	
		                        	<th width="10%">Valor Total</th>

									<th width="10%">Desconto</th>			                        

		                        	<th width="10%">Vlr. Liq.</th>
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
			                    <g:each in="${itensProdutoList}" status="i" var="itemInstance">
			                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
			                        
			                            <td>${fieldValue(bean: itemInstance, field: "produto.codigo")}</td>

			                            <td>${fieldValue(bean: itemInstance, field: "produto.descricao")}</td>
			                            
			                            <td>INDEFINIDA</td>

			                            <td>${itemInstance?.quantidade}</td>
			                        
			                            <td><g:formatNumber value="${itemInstance?.preco}" /></td>
			                            
			                            <td><g:formatNumber value="${itemInstance?.preco*itemInstance?.quantidade}" /></td>
			                            
		                            	<td><g:formatNumber value="${itemInstance?.desconto}" /></td>
			                        
		                            	<td><g:formatNumber value="${itemInstance?.preco*itemInstance?.quantidade - itemInstance?.desconto}" /></td>
		                            	
			                        </tr>
			                    </g:each>
		                    </tbody>
		                    <tfoot>
		                    	<tr>
		                    		<td></td>
		                    		<td>Tipo Frete: CIF</td>
		                    		<td>Previsão Frete: 0,00</td>
		                    		<td>Peso Bruto: 0,00</td>
		                    		<td>Peso Líquido: 0,00</td>
		                    		<%
										Integer qtdItens = itensProdutoList.collect{it.quantidade}.sum()
										Double totalBruto = itensProdutoList.collect{it.preco*it.quantidade}.sum()
										Double totalDesconto = itensProdutoList.collect{it.preco*it.quantidade - it.desconto}.sum()
										Double total = itensProdutoList.collect{it.preco*it.quantidade - it.desconto}.sum()
									 %>
		                    		<td>Qtde Itens: ${qtdItens}</td>
		                    		<td align="right">Total Bruto:</td>
		                    		<td><g:formatNumber value="${totalBruto}" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td colspan="5"></td>
		                    		<td align="right" colspan="2">Total de descontos:</td>
		                    		<td><g:formatNumber value="${totalDesconto}" /></td>
		                    	</tr>
		                    	<tr>
		                    		<td colspan="6"></td>
		                    		<td align="right">Total Líquido: </td>
		                    		<td><g:formatNumber value="${total}" /></td>
		                    	</tr>
		                    </tfoot>
		                </table>
		                
