
<%@ page import="loja.vidracaria.Kit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'kit.label', default: 'Kit')}" />
        <title>Gerenciar Kit</title>
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
                        
                            <th><g:message code="kit.codigo.label" default="Código" /></th>
                        
                            <th><g:message code="kit.nome.label" default="Nome" /></th>
                        
                            <th><g:message code="kit.precoUnitario.label" default="Preço Unitário" /></th>
                        
                            <th><g:message code="kit.precoUnitarioCompra.label" default="Preço Unitário de Compra" /></th>
                        
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${kitInstanceList}" status="i" var="kitInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: kitInstance, field: "codigo")}</td>
                        
                            <td>${fieldValue(bean: kitInstance, field: "nome")}</td>
                        
                            <td><g:formatNumber value="${kitInstance?.precoUnitario}" /></td>
                        
                            <td><g:formatNumber value="${kitInstance?.precoUnitarioCompra}" /></td>
                        
							<td>
								<g:link action="show" id="${kitInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${kitInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${kitInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="paginateButtons">
            	<g:paginate total="${kitInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
