<%@ page import="loja.Perfil" %>
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Receber Produtos</title>
        
        <style>
        	.gedigblue fieldset {
        		margin-bottom: 20px;
        	}
        </style>
        
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Receber Produtos</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            	<form>
	            <g:each in="${compraInstanceList}" var="compraInstance">
	           		<fieldset>
	           			<legend>Compra: <a href="${createLink(controller: 'relatorio', action: 'show', id: compraInstance.id)}?opcaoMovimentacao=COMPRA">${compraInstance.id}</a> - Data: ${compraInstance.data.format('dd/MM/yyyy HH:mm')} - Func: ${compraInstance.usuario}</legend>
		                <table>
		                    <thead>
		                        <tr>
		                        	<th>Item</th>
		                        
		                        	<th>Descrição</th>
	
		                        	<th>Quant</th>
		                        
		                        	<th>Vlr. Unit.</th>
		                        	
		                        	<th>Valor Total (R$)</th>
		                        	
		                        	<th>Receber</th>
		                        	
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
		                    <g:each in="${compraInstance.itens}" status="i" var="itemInstance">
		                    	<g:if test="${!itemInstance.dataRecebimento}">
			                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
			                        
			                            <td>${itemInstance.id}</td>
			                            
			                            <td>${itemInstance.produto}</td>
			                        
			                            <td>${itemInstance.quantidade}</td>
				                        
			                            <td><g:formatNumber value="${itemInstance.preco}" /></td>
			                            
			                            <td><g:formatNumber value="${itemInstance?.preco*itemInstance?.quantidade}" /></td>
			                            
				                        <td>
				                        	<%
												def vendasItem = vendasMap[itemInstance.id]
												def itensVenda = vendasItem.collect{it.itens}.flatten()
												String itensVendaIds = itensVenda.collect{it.id}.join(",") 
											 %>
											<a style="text-decoration: none" href="${createLink(controller: 'movimentacao', action: 'receberItem')}?id=${itemInstance.id}&itensVendaIds=${itensVendaIds}">
												<input type="button" value="Receber" />
											</a>									
				                        </td>
			
			                        </tr>
			                        
		                        	<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
										<td colspan="6">
											<table>
												<thead>
													<tr>
														<th>Venda</th>
														<th>Data</th>
														<th>Cliente</th>
														<th>Qtd</th>
														<th>Valor</th>
														<th>Total</th>
													</tr>
												</thead>
												<tbody>
	                    						<g:each in="${vendasMap[itemInstance.id]}" var="vendaInstance">
		                        					<tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
														<td>${vendaInstance.id}</td>
														<td>${vendaInstance.data.format('dd/MM/yyyy HH:mm')}</td>
														<td>${vendaInstance.cliente}</td>
														<%
															def item = vendaInstance.itens.find{it.produto.id == itemInstance.produto.id}
														 %>
														<td>${item.quantidade}</td>
														<td><g:formatNumber value="${item.preco}" /></td>
														<td><g:formatNumber value="${item.quantidade*item.preco}" /></td>
													</tr>
		                    					</g:each>
												</tbody>
											</table>
										</td>		                    			
	                    			</tr>
			                        
		                    	</g:if>
		                    </g:each>
		                    </tbody>
		                </table>
					 </fieldset>
				</g:each>
				</form>	 
            </div>

        </div>
    </body>
</html>
