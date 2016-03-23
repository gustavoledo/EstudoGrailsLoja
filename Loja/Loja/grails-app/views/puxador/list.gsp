
<%@ page import="loja.vidracaria.Puxador" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'puxador.label', default: 'Puxador')}" />
        <title>Gerenciar Puxador</title>
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
                        
                            <th><g:message code="puxador.codigo.label" default="Código" /></th>
                        
                            <th><g:message code="puxador.nome.label" default="Nome" /></th>
                        
                            <th><g:message code="puxador.tamanho.label" default="Tamanho" /></th>

                            <th><g:message code="puxador.cor.label" default="Cor" /></th>
                        
                            <th><g:message code="puxador.precoUnitario.label" default="Preço Unitário" /></th>
                        
                            <th><g:message code="puxador.precoUnitarioCompra.label" default="Preço Unitário de Compra" /></th>
                        
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${puxadorInstanceList}" status="i" var="puxadorInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: puxadorInstance, field: "codigo")}</td>
                        
                            <td>${fieldValue(bean: puxadorInstance, field: "nome")}</td>
                        
                            <td><g:formatNumber value="${puxadorInstance?.tamanho}" /></td>

                            <td>${fieldValue(bean: puxadorInstance, field: "cor")}</td>
                        
                            <td><g:formatNumber value="${puxadorInstance?.precoUnitario}" /></td>
                            
                            <td><g:formatNumber value="${puxadorInstance?.precoUnitarioCompra}" /></td>
                        
							<td>
								<g:link action="show" id="${puxadorInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${puxadorInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${puxadorInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${puxadorInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${puxadorInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
