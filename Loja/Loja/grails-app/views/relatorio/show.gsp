<%@ page import="loja.Perfil" %>

<%@ page import="loja.Usuario" %>
<%@ page import="loja.StatusVenda" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Detalhe da ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="util.js" />
   		
   		<script>
   			function atualizaEmissaoNota() {
				var url = '${createLink(controller:'movimentacao', action:'ajaxUpdateEmissaoNota')}'
				url += '?id=${movimentacaoInstance.id}'				  
				url += '&emitiuNotaFiscal=' + $('#emitiuNotaFiscal').is(':checked')
				
				$.ajax({  
					url: url,  
					dataType: 'html',  
					async: true,  
					success: function(html){
						if (html == "OK") {
							alert("Campo Emitiu nota fiscal atualizado com sucesso.")
						} 
					},  
					error: function(e){
						alert("Erro ao atualizar campo Emitiu nota fiscal.")
					}  
				});

   	   		}
   		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Detalhe da ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</h1>

            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>

			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: movimentacaoInstance]"/>
            
            <div class="gedigblue">
            	<g:form controller="relatorio">
            		<g:hiddenField name="id" value="${movimentacaoInstance.id}" />
            		<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
            		
            		<fieldset>
						<legend>Dados ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</legend>
					 
					 	<ol>
					 		<li>
					 			<label>Data</label>
					 			${movimentacaoInstance.data.format('dd/MM/yyyy') }
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>Funcionário</label>
					 			${movimentacaoInstance.usuario}
					 		</li>
					 	</ol>

					</fieldset>
					
	                <g:if test="${params.opcaoMovimentacao == 'VENDA'}">
	                	<g:if test="${movimentacaoInstance.cliente}">
							<g:render template="/movimentacao/dadosClienteInclude" model="[clienteInstance: movimentacaoInstance.cliente, , enderecoInstance: enderecoInstance]"/>
	                	</g:if>
					</g:if>
					<g:else>
						<g:render template="/movimentacao/dadosFornecedorInclude" model="[fornecedorInstance: movimentacaoInstance.fornecedor]"/>
					</g:else>

					<fieldset>
						<legend>Dados do Pagamento</legend>
					 	<ol>
					 		<li>
					 			<label>Tipo de Pagamento</label>
					 			${movimentacaoInstance?.tipoPagamento.name}
					 		</li>
					 	</ol>

						<g:if test="${movimentacaoInstance?.formaPagamento}">
						 	<ol>
						 		<li>
						 			<label>Forma de Pagamento</label>
						 			${movimentacaoInstance?.formaPagamento} (${movimentacaoInstance?.pagamento()})
						 		</li>
						 	</ol>
						</g:if>

						<g:if test="${movimentacaoInstance?.tipoPagamento.sigla == 'CT'}">
						 	<ol>
						 		<li>
						 			<label>Quantidade de Parcelas</label>
						 			${movimentacaoInstance?.quantidadeParcelas}
						 		</li>
						 	</ol>
						</g:if>

	                	<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
						 	<ol>
						 		<li>
						 			<label>Observação</label>
						 			${movimentacaoInstance?.observacao}
						 		</li>
						 	</ol>
						 	<ol>
						 		<li>
						 			<label>Previsão de entrega</label>
						 			${movimentacaoInstance?.previsaoEntrega.format('dd/MM/yyyy')} (<b>Faltam ${movimentacaoInstance.previsaoEntrega - new Date()} dias</b>)
						 		</li>
						 	</ol>
						 	<ol>
						 		<li>
						 			<label>Emitiu nota fiscal?</label>
						 			<g:checkBox name="emitiuNotaFiscal" checked="${movimentacaoInstance?.emitiuNotaFiscal == true}" value="S" onclick="atualizaEmissaoNota()" />
						 		</li>
						 	</ol>
	                	</g:if>

						</fieldset>

            		<fieldset>
						<legend>Lista de Itens</legend>
						<g:render template="/relatorio/itensProdutoRelatorioInclude" model="[itensProdutoList: movimentacaoInstance.itens]"/>
					 </fieldset>
					 
					 <fieldset>
					 		<legend>Resumo</legend>
					 	
						 	<ol>
						 		<li>
						 			<label>Total da ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</label>
					 				<div style="display:inline;">
	                                	<label style="width: 20px" id="total">R$&nbsp;<g:formatNumber value="${movimentacaoInstance.totalItens()}" /></label>
	                                </div>
						 		</li>
						 	</ol>
					 	
	                		<g:if test="${params.opcaoMovimentacao == 'VENDA' && movimentacaoInstance.desconto && movimentacaoInstance.desconto > 0}">
							 	<ol>
							 		<li>
							 			<label>Desconto</label>
		                                <label style="width: 300px; text-align: left" id="descontoResumo">R$&nbsp;<g:formatNumber value="${movimentacaoInstance.desconto}" /> (${movimentacaoInstance.descontoPercentual()}% - ${movimentacaoInstance.usuarioDesconto})</label>
							 		</li>
							 	</ol>
		
							 	<ol>
							 		<li>
							 			<label>Total com desconto</label>
		                                <label style="width: 20px" id="totalPagar"><b>R$&nbsp;<g:formatNumber value="${movimentacaoInstance.total()}" /></b></label>
							 		</li>
							 	</ol>
							 	
							 </g:if>
							 
							 <g:if test="${params.opcaoMovimentacao == 'VENDA' && movimentacaoInstance.valorReceber}">
							 	<ol>
							 		<li>
							 			<label>Valor a receber</label>
		                                <label style="width: 20px"><b>R$&nbsp;<g:formatNumber value="${movimentacaoInstance.valorReceber}" /></b></label>
							 		</li>
							 	</ol>
							 </g:if>
							 
					 	
					 </fieldset>
					 

		            <div class="botoes-envio">
		            
                		<g:if test="${(session.usuario.perfil == Perfil.MASTER || session.usuario.perfil == Perfil.ADMINISTRADOR) && params.opcaoMovimentacao == 'VENDA'}">
		                	<a style="text-decoration: none;" onclick="return confirm('Tem certeza que deseja excluir a venda?')" href="${createLink(controller: 'movimentacao', action: 'delete', id: movimentacaoInstance.id)}"><input type="button" value="Excluir"></input></a>
                		</g:if>
		            
	                	<g:if test="${session.usuario.hasCategoriaVidro()}">
	                		<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
                    			<g:actionSubmit id="btnGeraRelatorioPedido" action="geraPedidoVidracaria" value="Gerar Pedido para Impressão" />
	                		</g:if>
                    	</g:if>
	                	<g:if test="${session.usuario.hasCategoriaMovel()}">
	                		<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
                    			<g:actionSubmit id="btnGeraRelatorioPedidoMoveis" action="geraPedidoMoveis" value="Gerar Pedido para Impressão" />
	                		</g:if>
                    	</g:if>

	                	<g:if test="${params.opcaoMovimentacao == 'COMPRA'}">
                    		<g:actionSubmit id="btnGeraRelatorio" action="geraRelatorio" value="Gerar Relatório" />
                    	</g:if>

		                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                    	
		            </div>
					 
	             </g:form>
            </div>

        </div>
    </body>
</html>
