
<%@ page import="loja.Secao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'secao.label', default: 'Seção')}" />
        <title>Gerenciar Seção</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Seção</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Seção</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                        
                        	<th><g:sortColumn property="${message(code: 'secao.nome.label', default: 'Nome')}" /></th>
                        
                        	<th><g:sortColumn property="${message(code: 'secao.descricao.label', default: 'Descrição')}" /></th>
                        
	            			<g:if test="${session.usuario.hasCategoriaVidro()}">
                        		<th><g:sortColumn property="${message(code: 'secao.percentualLucro.label', default: 'Percentual de Lucro')}" /></th>
                        		<th><g:sortColumn property="${message(code: 'secao.maoObra.label', default: 'Mão de Obra')}" /></th>
                        	</g:if>
                        
                            <th><g:message code="secao.categoria.label" default="Categoria" /></th>
                        
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${secaoInstanceList}" status="i" var="secaoInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: secaoInstance, field: "nome")}</td>
                        
                            <td>${fieldValue(bean: secaoInstance, field: "descricao")}</td>
                        
	            			<g:if test="${session.usuario.hasCategoriaVidro()}">
                            	<td><g:formatNumber value="${secaoInstance.percentualLucro}" /></td>
                            	<td><g:formatNumber value="${secaoInstance.maoObra}" /></td>
                            </g:if>
                        
                            <td>${fieldValue(bean: secaoInstance, field: "categoria")}</td>
                        
							<td>
								<g:link action="show" id="${secaoInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${secaoInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${secaoInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${secaoInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${secaoInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
