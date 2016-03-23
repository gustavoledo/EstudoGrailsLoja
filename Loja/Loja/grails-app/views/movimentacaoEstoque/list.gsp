
<%@ page import="loja.movimentacao.MovimentacaoEstoque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque')}" />
        <title>Gerenciar Movimentação de estoque</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Movimentação de estoque</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Movimentação de estoque</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                        
                            <th><g:message code="movimentacaoEstoque.produto.label" default="Produto" /></th>
                        
                        	<th>Quantidade</th>
                        
                        	<th>Data</th>
                        
                        	<th>Operação</th>
                        
                        	<th>Observação</th>
                        	
	                 		<th width="10%">Compra/Venda</th>
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${movimentacaoEstoqueInstanceList}" status="i" var="movimentacaoEstoqueInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: movimentacaoEstoqueInstance, field: "produto")}</td>
                        
                            <td>${fieldValue(bean: movimentacaoEstoqueInstance, field: "quantidade")}</td>
                        
                            <td><g:formatDate date="${movimentacaoEstoqueInstance.data}" /></td>
                        
                            <td>${fieldValue(bean: movimentacaoEstoqueInstance, field: "operacao")}</td>
                        
                            <td>${fieldValue(bean: movimentacaoEstoqueInstance, field: "observacao")}</td>
                            
                            <td>
                            	<g:if test="${movimentacaoEstoqueInstance.movimentacao}">
									<g:link controller="relatorio" action="show" id="${movimentacaoEstoqueInstance.movimentacao.id}" params="['opcaoMovimentacao':movimentacaoEstoqueInstance.operacao == '+' ? 'COMPRA' : 'VENDA']">
										${movimentacaoEstoqueInstance.movimentacao.id}
									</g:link>
                            	</g:if>
                            </td>
                        
							<td>
								<g:link action="show" id="${movimentacaoEstoqueInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${movimentacaoEstoqueInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${movimentacaoEstoqueInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${movimentacaoEstoqueInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${movimentacaoEstoqueInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
