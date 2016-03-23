
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="util.js" />
        <title>
	        Orçamento
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
               	   				<td class="borda-left-top">ORÇAMENTO: <span>${orcamentoInstance.id}</span></td>
               	   			</tr>
               	   			<tr>
               	   				<td class="borda-left-top">DATA: <span>${orcamentoInstance.data.format('dd/MM/yyyy')}</span></td>
               	   			</tr>
               	   		</table>
             		</fieldset>

		             <fieldset>
		             	<table>
		             		<tbody>
			             		<tr>
			             			<td class="borda" colspan="4">NOME/RAZÃO SOCIAL: <span>${orcamentoInstance?.cliente?.nome}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">ENDEREÇO: <span>${orcamentoInstance?.cliente?.rua}</span></td>
			             			<td class="borda" >Nº: <span>${orcamentoInstance?.cliente?.numero}</span></td>
			             			<td class="borda" >REF: <span>${orcamentoInstance?.cliente?.referencia}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda-left">BAIRRO: <span>${orcamentoInstance?.cliente?.bairro}</span></td>
			             			<td class="borda-left">MUNICÍPIO: <span>${orcamentoInstance?.cliente?.cidade}</span></td>
			             			<td></td>
			             			<td class="borda-left">UF: <span>${orcamentoInstance?.cliente?.uf}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">INSC.EST./RG: <span>${orcamentoInstance?.cliente?.rg}</span></td>
			             			<td class="borda" colspan="2">CNPJ/CPF: <span>${orcamentoInstance?.cliente?.cpf}</span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">COND.PAGTO: <span>${orcamentoInstance.formaPagamento}</span></td>
			             			<td class="borda" colspan="2">TELEFONE: <span>${orcamentoInstance?.cliente?.telefoneResidencial} / ${orcamentoInstance?.cliente?.telefoneComercial} / ${orcamentoInstance?.cliente?.telefoneCelular} / ${orcamentoInstance?.cliente?.radioNextel}</span></td>
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
								<g:each in="${orcamentoInstance.itens}" status="i" var="itemInstance">
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
										def total = orcamentoInstance.itens.collect{it.preco*it.quantidade}.sum()
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
			             			<td class="borda">SINAL VALOR PAGO: <span></span></td>
			             			<td class="borda">A PAGAR/RESTO: <span></span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda" colspan="2">OBSERVAÇÃO: <span></span></td>
			             		</tr>
			             		<tr>
			             			<td class="borda">CLIENTE: <span>${orcamentoInstance.cliente}</span></td>
			             			<td class="borda">VENDEDOR: <span>${orcamentoInstance.usuario}</span></td>
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
