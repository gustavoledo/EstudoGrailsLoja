
<%@ page import="loja.RedeLojas" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'redeLojas.label', default: 'RedeLojas')}" />
        <title>Gerenciar RedeLojas</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Rede de Lojas</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Rede de Lojas</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                            <th><g:message code="redeLojas.lojaMatriz.label" default="Loja Matriz" /></th>
                            <th><g:message code="redeLojas.lojaFilial.label" default="Loja Filial" /></th>
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${redeLojasInstanceList}" status="i" var="redeLojasInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: redeLojasInstance, field: "lojaMatriz")}</td>
                        
                            <td>${fieldValue(bean: redeLojasInstance, field: "lojaFilial")}</td>
                        
							<td>
								<g:link action="show" id="${redeLojasInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${redeLojasInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${redeLojasInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${redeLojasInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
