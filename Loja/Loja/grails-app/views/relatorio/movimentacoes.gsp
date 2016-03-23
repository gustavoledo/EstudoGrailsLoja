<%@ page import="loja.Perfil" %>
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Relatório de ${params.opcaoMovimentacao == 'VENDA' ? 'Vendas' : 'Compras'}</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Relatório de ${params.opcaoMovimentacao == 'VENDA' ? 'Vendas' : 'Compras'}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            	<g:form action="${lojasInstanceList ? 'consolidado': 'index'}">
            		<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
            		<g:hiddenField name="opcaoComissao" value="${params.opcaoComissao}" />
            		<fieldset>
						<legend>Filtro</legend>

						<g:if test="${lojasInstanceList}">
						 	<ol>
						 		<li>
						 			<label>Loja</label>
		                        	<g:select name="lojaId" from="${lojasInstanceList}"
		                             	noSelection="${['':'--Todos--']}" 
		                                optionKey="id" value="${params.lojaId}"  
		                        	/>
						 		</li>
						 	</ol>
						</g:if>
					 
					 	<ol>
					 		<li>
					 			<label>Usuário</label>
        						<g:if test="${session.usuario.perfil == Perfil.VENDEDOR}">
									<g:hiddenField name="usuarioId" value="${session.usuario.id}" />
									${session.usuario}
					 			</g:if>
								<g:else>
		                        	<g:select name="usuarioId" from="${usuarioInstanceList}"
		                             	noSelection="${['':'--Todos--']}" 
		                                optionKey="id" value="${params.usuarioId}"  
		                        	/>
								</g:else>
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>Período</label>
					 			<div style="display:inline;">
						 			<g:datePicker name="dataInicio" precision="day" value="${params.dataInicio}" />&nbsp;&nbsp;a&nbsp;&nbsp;  
						 			<g:datePicker name="dataFim" precision="day" value="${params.dataFim}" />
					 			</div>
					 		</li>
					 	</ol>

					 </fieldset>

		            <div class="botoes-envio">
                    	<g:submitButton name="btnOK" value="OK" />
		            </div>					 	
					 
            		<fieldset>
		                <table>
		                    <thead>
		                        <tr>

									<g:if test="${lojasInstanceList}">
		                        		<th>Loja</th>
									</g:if>
									
		                        	<th>Data</th>
		                        
		                        	<th>Funcionário</th>

									<g:if test="${params.opcaoComissao}">
		                        		<th>Vendedor p/ comissão</th>
									</g:if>		                        
		                        	
		                        	<th>Cliente</th>
		                        
		                        	<th>Tipo de Pagamento</th>
		                        
		                        	<th>Valor Total (R$)</th>
		                        	
		                        	<th>Ver</th>
		                        	
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
		                    <g:each in="${movimentacaoInstanceList}" status="i" var="movimentacaoInstance">
		                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
		                        
									<g:if test="${lojasInstanceList}">
		                        		<td>${movimentacaoInstance.loja}</td>
									</g:if>
									
		                            <td>${movimentacaoInstance.data.format('dd/MM/yyyy')}</td>
		                            
		                            <td>${fieldValue(bean: movimentacaoInstance, field: "usuario")}</td>
		                            
									<g:if test="${params.opcaoComissao}">
		                            	<td>${movimentacaoInstance?.cliente?.vendedorComissao}</td>
									</g:if>
		                        
		                        	<g:if test="${params.opcaoMovimentacao == 'VENDA'}">
		                            	<td>${fieldValue(bean: movimentacaoInstance, field: "cliente")}</td>
		                        	</g:if>
		                        	<g:else>
		                            	<td>${fieldValue(bean: movimentacaoInstance, field: "fornecedor")}</td>
		                        	</g:else>
		                        
		                            <td>${fieldValue(bean: movimentacaoInstance, field: "tipoPagamento.name")}</td>
		                        
			                        <td><g:formatNumber value="${movimentacaoInstance?.valorTotal}" /></td>
			                        
			                        <td>
										<a href="${createLink(controller: 'relatorio', action: 'show', id: movimentacaoInstance.id)}?opcaoMovimentacao=${params.opcaoMovimentacao}">
											<img border="0" src="${resource(dir:'images',file:'view.png')}" />
										</a>									
			                        </td>
		
		                        </tr>
		                    </g:each>
		                    </tbody>
		                    <tfoot>
		                    	<tr>
		                    		<td ${params.opcaoComissao ? 'colspan="4"' : 'colspan="3"'} ></td>
		                    		<td>Total</td>
		                    		<td>
		                    			<%
											def total = movimentacaoInstanceList.collect{it.valorTotal}.sum()
										 %>
										 <g:formatNumber value="${total}" />
		                    		</td>
		                    		<td></td>
		                    	</tr>
		                    </tfoot>
		                </table>
					 </fieldset>
					 
	             </g:form>
            </div>

        </div>
    </body>
</html>
