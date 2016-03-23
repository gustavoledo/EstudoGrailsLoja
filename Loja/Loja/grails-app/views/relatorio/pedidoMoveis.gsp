
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: 'pedido.label', default: 'Pedido')}" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="util.js" />
        <title>
	        Pedido
        </title>
        <script>
        	$(function(){
            })
            
	    	function printPage() {
	    		$('.nav').hide()				
	    		$(":button").hide()
	    		$(":submit").hide()
	    		$("#grailsLogo").hide()
	    		
	    		window.print()
	
	    		setTimeout(showComponents, 3000); //3 segundos
	        }
        
        </script>
        <style>
        	table {
    			width: 100%;
				border-spacing: 0px;
				border-collapse:collapse; 
        	}
        	
			th, table {
    			border: 2px solid #ccc;
				font-weight: bold;
			}
			
			td {
				border: none;
				font-weight: bold;
			}

			td span {
				font-weight: normal;
			}

			td.borda-left-top {
    			border-left: 2px solid #ccc;
    			vertical-align: top;
			}

			td.borda {
    			border: 2px solid #ccc;
			}

			td.borda-center {
    			border: 2px solid #ccc;
    			text-align: center;
			}

			td.borda-center-bold {
    			border: 2px solid #ccc;
    			text-align: center;
				font-weight: bold;
			}

			td.borda-right-bold {
    			border: 2px solid #ccc;
    			text-align: right;
				font-weight: bold;
			}

			td.borda-left {
    			border-left: 2px solid #ccc;
			}

			td.borda-width {
    			border: 2px solid #ccc;
    			width: 25%;
			}

			fieldset {
    			border: 0px solid #ccc;
    			padding-bottom: 50px;
			}
			
			.botoes-envio {
				float: right;
				padding-right: 20px;
			}
        </style>
    </head>
    <body class="tundra">
   
           <g:form>
             		<fieldset>
               	   		<table>
               	   			<tr>
               	   				<td rowspan="2">
               	   					<img src="${resource(dir:'images',file:'logo-moveis.png')}" />
               	   				</td>
               	   				<td class="borda-left-top">PEDIDO: <span>${movimentacaoInstance.id}</span></td>
               	   			</tr>
               	   			<tr>
               	   				<td class="borda-left-top">DATA: <span>${movimentacaoInstance.data.format('dd/MM/yyyy')}</span></td>
               	   			</tr>
               	   		</table>
             		</fieldset>

		             <fieldset>
		             	<table>
		             		<tbody>
			             		<tr>
			             			<td class="borda" colspan="4">NOME/RAZÃO SOCIAL: <span>${movimentacaoInstance.cliente.nome}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">ENDEREÇO: <span>${movimentacaoInstance.cliente.rua}</span></td>
			             			<td class="borda" >Nº: <span>${movimentacaoInstance.cliente.numero}</span></td>
			             			<td class="borda" >REF: <span>${movimentacaoInstance.cliente.referencia}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda-left">BAIRRO: <span>${movimentacaoInstance.cliente.bairro}</span></td>
			             			<td class="borda-left">MUNICÍPIO: <span>${movimentacaoInstance.cliente.cidade}</span></td>
			             			<td></td>
			             			<td class="borda-left">UF: <span>${movimentacaoInstance.cliente.uf}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">INSC.EST./RG: <span>${movimentacaoInstance.cliente.rg}</span></td>
			             			<td class="borda" colspan="2">CNPJ/CPF: <span>${movimentacaoInstance.cliente.cpf}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">COND.PAGTO: <span>${movimentacaoInstance.tipoPagamento}</span></td>
			             			<td class="borda" colspan="2">TELEFONE: <span>${movimentacaoInstance.cliente.telefoneResidencial} / ${movimentacaoInstance.cliente.telefoneComercial} / ${movimentacaoInstance.cliente.telefoneCelular} / ${movimentacaoInstance.cliente.radioNextel}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="4">LOCAL DE ENTREGA: 
			             				<span>
				             				<g:if test="${!movimentacaoInstance.enderecoClienteMesmoDeEntrega()}">
												Rua ${movimentacaoInstance.rua}, ${movimentacaoInstance.numero} ${movimentacaoInstance.complemento} - ${movimentacaoInstance.bairro} ${movimentacaoInstance.cidade}/${movimentacaoInstance.uf} CEP: ${movimentacaoInstance.cep} REF: ${movimentacaoInstance.referencia}				             				
				             				</g:if>
			             				</span>
			             			</td>
			             		</tr>
		             		</tbody>
		             	</table>
		             	
		             </fieldset>
		             
		            
	                <fieldset>
	                	<table>
	                		<thead>
		                		<tr>
		                			<th width="10%">QTD</th>
		                			<th width="10%">COD</th>
		                			<th width="60%">ESPECIFICAÇÃO</th>
		                			<th width="10%">UNIT</th>
		                			<th width="10%">TOTAL</th>
		                		</tr>
		                	</thead>
		                	<tbody>
								<g:each in="${movimentacaoInstance.itens}" status="i" var="itemInstance">
									<tr>
										<td class="borda-center"><span>${itemInstance.quantidade}</span></td>
										<td class="borda-center"><span>${itemInstance.id}</span></td>
										<td class="borda-center"><span>${itemInstance.produto}</span></td>
										<td class="borda-center"><span><g:formatNumber value="${itemInstance.preco}" /></span></td>
										<td class="borda-center"><span><g:formatNumber value="${itemInstance.preco*itemInstance.quantidade}" /></span></td>
									</tr>								
								</g:each>
							</tbody>
							<tfoot>
								<tr>
									<td class="borda-center-bold" colspan="3"></td>
									<td class="borda-right-bold">TOTAL GERAL</td>
									<%
										def totalGeral = movimentacaoInstance.itens.collect{it.preco*it.quantidade}.sum()
									 %>
									<td class="borda-center-bold"><g:formatNumber value="${totalGeral}" /></td>
								</tr>
								<tr>
									<td class="borda-center-bold" colspan="3"></td>
									<td class="borda-right-bold">DESCONTO</td>
									<td class="borda-center-bold"><g:formatNumber value="${movimentacaoInstance.desconto}" /></td>
								</tr>
								<tr>
									<td class="borda-center-bold" colspan="3"></td>
									<td class="borda-right-bold">TOTAL</td>
									<%
										Double total = totalGeral - movimentacaoInstance.desconto
									 %>
									<td class="borda-center-bold"><g:formatNumber value="${total}" /></td>
								</tr>
							</tfoot>	                		
	                	</table>
					</fieldset>

		             <fieldset>
		             	<table>
		             		<tbody>
			             		<tr>
			             			<td class="borda">SINAL VALOR PAGO: <span><g:formatNumber value="${movimentacaoInstance.valorReceber ? total - movimentacaoInstance.valorReceber : total}" /></span></td>
			             			<td class="borda">A PAGAR/RESTO: <span><g:formatNumber value="${movimentacaoInstance.valorReceber ? movimentacaoInstance.valorReceber : new Double(0.0)}" /></span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">OBSERVAÇÃO: <span>${movimentacaoInstance.observacao}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda">CLIENTE: <span>${movimentacaoInstance.cliente}</span></td>
			             			<td class="borda">VENDEDOR: <span>${movimentacaoInstance.usuario}</span></td>
			             		</tr>
		             		</tbody>
		             	</table>
		            </fieldset>

		            <div class="botoes-envio">
		                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
		                <span class="button"><input type="button" value="Imprimir" onclick="javascript: printPage()" ></input>  </span>
		            </div>

          </g:form>

    </body>
</html>
