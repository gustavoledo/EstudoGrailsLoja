
<%@ page import="loja.Secao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Gerenciar Movimentação - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
   		<g:javascript src="util.js" />
   		
        <script>
	    	function updateItens() {
				//monta os parametros
				var params = '?opcaoMovimentacao=${params.opcaoMovimentacao}'
				$('#tableItensProduto tbody tr').each(function(i) {
					
					$(this).find("td input").each(function(i) {
						var name = $(this).attr('name')
						var value = $(this).attr('value')
						params += '&' + name + '=' + value 
					});
					
				});
	
	  	        var url = '${createLink(controller: 'movimentacao', action: 'ajaxUpdateTotalItens')}' + params
	  	        
	    		$.ajax({  
	    			url: url,  
	    			dataType: 'html',  
	    			async: true,  
	    			success: function(html){
	    				updateListaItens(html)
	    			},
	    			error: function() {
	    				alert('Erro ao adicionar item')
	    			}  
	    		});
	
			}
        
            function adicionaItem(produtoId) {
    	        var url = '${createLink(controller: 'movimentacao', action: 'ajaxAddProduto')}?id=' + produtoId + '&opcaoMovimentacao=${params.opcaoMovimentacao}'
    	        
 	    		$.ajax({  
 	    			url: url,  
 	    			dataType: 'html',  
 	    			async: true,  
 	    			success: function(html){
 	    				updateListaItens(html)
 	    			},
 	    			error: function() {
 	    				alert('Erro ao adicionar item')
 	    			}  
 	    		});
            }

        	function removeItem(produtoId) {
 	    	    var url = '${createLink(controller: 'movimentacao', action: 'ajaxRemoveProduto')}?id=' + produtoId
 	    	        
 	 	    	$.ajax({  
 	 	    		url: url,  
 	 	    		dataType: 'html',  
 	 	    		async: true,  
 	 	    		success: function(html){
 	 	    			updateListaItens(html)
 	 	    		},
 	 	    		error: function() {
 	 	    			alert('Erro ao adicionar item')
 	 	    		}  
 	 	    	});
    	            						

            }
        	
            function updateListaItens(html) {
            	document.getElementById("divItensProduto").innerHTML = html
            	habilitaBotaoProximo()
            }

            function habilitaBotaoProximo() {
				if ($('#tableItensProduto tbody tr').size() > 0) {
					$('#divProximo').show()
				} else {
					$('#divProximo').hide()
				}
            }
        	
        </script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Gerenciar Movimentação - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: movimentacaoInstance]"/>
            
            <div class="gedigblue">
            	<g:form action="index">
            		<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
            		<g:hiddenField name="clienteId" value="${params.clienteId}" />

            		<g:if test="${!isCompraPedidos}">
	            		<g:if test="${session.usuario.hasCategoriaMovel()}">
							<g:render template="/movel/movelFilterInclude" />
	            		</g:if>
	            		<g:else>
							<g:render template="/movel/produtoFilterInclude" />
	            		</g:else>
            		</g:if>
            		
            		<fieldset>
		                <table>
		                    <thead>
		                        <tr>
		                        
		                        	<th>Código</th>
		                        
	            					<g:if test="${session.usuario.hasCategoriaMovel()}">
			                        	<th>Código Fornecedor</th>
			                        </g:if>
		                        	
		                        	<th>Nome</th>
		                        
		                        	<th>Descrição</th>
		                        
		                        	<th>Preço Unitário (R$)</th>
		                        	
		                        	<th>Estoque</th>

			                 		<th width="5%">Adicionar</th>
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
		                    <g:each in="${produtoInstanceList}" status="i" var="produtoInstance">
		                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
		                        
		                            <td>${fieldValue(bean: produtoInstance, field: "codigo")}</td>
		                        
	            					<g:if test="${session.usuario.hasCategoriaMovel()}">
			                            <td>${fieldValue(bean: produtoInstance, field: "codigoFornecedor")}</td>
			                        </g:if>
		                            
		                            <td>${fieldValue(bean: produtoInstance, field: "nome")}</td>
		                        
		                            <td>${fieldValue(bean: produtoInstance, field: "descricao")}</td>
		                        
		                            <td><g:formatNumber value="${produtoInstance?.precoUnitario}" /></td>
		
									<td>
										<g:render template="/estoque/estoqueDisponivelInclude" model="[estoqueInstanceList: produtoInstance.estoques()]"/>
									</td>

									<td>
										<img border="0" src="${resource(dir:'images',file:'add.png')}" onclick="adicionaItem(${produtoInstance.id})" />
									</td>			
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
					 </fieldset>
	             	</g:form>
					 
					 <g:form action="updateItens">
            			<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
	            		<fieldset>
							<legend>Lista de Itens Selecionados</legend>
							
							<div id="divItensProduto">
								<g:if test="${session.mapItensProduto.size() > 0}">
									<g:render template="/movimentacao/itensProdutoInclude" model="[itensProdutoList: session.mapItensProduto.values(), isMovimentacao: true]"/>
								</g:if>
							</div>
						 
						 </fieldset>
					</g:form>

            		<g:form action="index">
            			<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
			            <div id="divProximo" class="botoes-envio">
			            	<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
			            		<g:if test="${params.clienteId && params.clienteId != '0'}">
            						<g:hiddenField name="clienteId" value="${params.clienteId}" />
                    				<g:actionSubmit id="btnOK" action="selectEnderecoEntrega" value="Próximo" />
			            		</g:if>
			            		<g:else>
	                    			<g:actionSubmit id="btnOK" action="selectClientes" value="Próximo" />
			            		</g:else>
			            	</g:if>
			            	<g:else>
	                    		<g:actionSubmit id="btnOK" action="selectFornecedores" value="Próximo" />
			            	</g:else>
			            </div>
			        </g:form>
		               
            </div>

        </div>
        <script>
        	habilitaBotaoProximo()        
        </script>
    </body>
</html>
