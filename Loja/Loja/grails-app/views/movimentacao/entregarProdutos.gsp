<%@ page import="loja.Perfil" %>
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Entregar Produtos</title>
        
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
            <h1>Entregar Produtos</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            	<form>
	            <g:each in="${vendaInstanceList}" var="vendaInstance">
	           		<fieldset>
	           			<legend>Venda: <a href="${createLink(controller: 'relatorio', action: 'show', id: vendaInstance.id)}?opcaoMovimentacao=VENDA">${vendaInstance.id}</a> - Data: ${vendaInstance.data.format('dd/MM/yyyy HH:mm')} - Cliente: ${vendaInstance.cliente}</legend>
		                <table>
		                    <thead>
		                        <tr>
		                        	<th>Item</th>
		                        
		                        	<th>Descrição</th>
	
		                        	<th>Quant</th>
		                        
		                        	<th>Vlr. Unit.</th>
		                        	
		                        	<th>Valor Total (R$)</th>
		                        	
		                        	<th>Entregar</th>
		                        	
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
		                    <g:each in="${vendaInstance.itens}" status="i" var="itemInstance">
			                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
			                        
			                            <td>${itemInstance.id}</td>
			                            
			                            <td>${itemInstance.produto}</td>
			                        
			                            <td>${itemInstance.quantidade}</td>
				                        
			                            <td><g:formatNumber value="${itemInstance.preco}" /></td>
			                            
			                            <td><g:formatNumber value="${itemInstance?.preco*itemInstance?.quantidade}" /></td>
			                            
			                            <g:if test="${!itemInstance.dataRecebimento}">
			                            	<td>Aguardando produto</td>
			                            </g:if>
			                            <g:else>
				                            <g:if test="${itemInstance.dataEntrega}">
				                            	<td>
				                            		Entregue ao cliente
				                            	</td>
				                            </g:if>
											<g:else>				                            
						                        <td>
													<a style="text-decoration: none" href="${createLink(controller: 'movimentacao', action: 'entregarItem', id: itemInstance.id)}">
														<input type="button" value="Entregar" />
													</a>									
						                        </td>
				                            </g:else>
										</g:else>			                            
			
			                        </tr>
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
