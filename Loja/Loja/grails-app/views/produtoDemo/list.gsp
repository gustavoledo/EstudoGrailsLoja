
<%@ page import="loja.ProdutoDemo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produtoDemo.label', default: 'ProdutoDemo')}" />
        <title>Gerenciar ProdutoDemo</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir ${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar ${entityName}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                        
                            <th><g:message code="produtoDemo.codigo.label" default="Codigo" /></th>
                        
                            <th><g:message code="produtoDemo.nome.label" default="Nome" /></th>
                        
                            <th><g:message code="produtoDemo.descricao.label" default="Descricao" /></th>
                        
                            <th><g:message code="produtoDemo.precoUnitario.label" default="Preco Unitario" /></th>
                        
                            <th><g:message code="produtoDemo.precoUnitarioCompra.label" default="Preco Unitario Compra" /></th>
                        
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${produtoDemoInstanceList}" status="i" var="produtoDemoInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: produtoDemoInstance, field: "codigo")}</td>
                        
                            <td>${fieldValue(bean: produtoDemoInstance, field: "nome")}</td>
                        
                            <td>${fieldValue(bean: produtoDemoInstance, field: "descricao")}</td>
                        
                            <td>${fieldValue(bean: produtoDemoInstance, field: "precoUnitario")}</td>
                        
                            <td>${fieldValue(bean: produtoDemoInstance, field: "precoUnitarioCompra")}</td>
                        
                        
							<td>
								<g:link action="show" id="${produtoDemoInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${produtoDemoInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${produtoDemoInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${produtoDemoInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${produtoDemoInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
