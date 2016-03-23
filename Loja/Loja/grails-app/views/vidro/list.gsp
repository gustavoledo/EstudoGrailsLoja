
<%@ page import="loja.vidracaria.Vidro" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vidro.label', default: 'Vidro')}" />
        <title>Gerenciar Vidro/Alum.</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir ${entityName}</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Vidro/Alum.</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                        
                            <th><g:message code="vidro.codigo.label" default="Código" /></th>
                        
                            <th><g:message code="vidro.fabricante.label" default="Fabricante" /></th>
                            
                            <th><g:message code="vidro.nome.label" default="Nome" /></th>
                        
                            <th><g:message code="vidro.espessura.label" default="Espessura" /></th>
                        
                            <th><g:message code="vidro.cor.label" default="Cor" /></th>
                            
                            <th><g:message code="vidro.precoUnitario.label" default="Preco Unitário" /></th>
                        
                            <th><g:message code="vidro.precoUnitarioCompra.label" default="Preco Unitário de Compra" /></th>
                        
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${vidroInstanceList}" status="i" var="vidroInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: vidroInstance, field: "codigo")}</td>
                        
                            <td>${fieldValue(bean: vidroInstance, field: "fabricante")}</td>
                            
                            <td>${fieldValue(bean: vidroInstance, field: "nome")}</td>
                        
                            <td><g:formatNumber value="${vidroInstance?.espessura}" /></td>
                        
                            <td>${fieldValue(bean: vidroInstance, field: "cor")}</td>
                            
                            <td><g:formatNumber value="${vidroInstance?.precoUnitario}" /></td>
                        
                            <td><g:formatNumber value="${vidroInstance?.precoUnitarioCompra}" /></td>
                        
							<td>
								<g:link action="show" id="${vidroInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${vidroInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${vidroInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="paginateButtons">
            	<g:paginate total="${vidroInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
