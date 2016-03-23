
<%@ page import="loja.Fornecedor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}" />
        <title>Gerenciar Fornecedor</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Fornecedor</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Fornecedor</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                        
                        	<th>Nome</th>
                        
                        	<th>CNPJ</th>
                        
                        	<th>Razão Social</th>
                        
                        	<th>Rua</th>
                        
                        	<th>Número</th>
                        
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${fornecedorInstanceList}" status="i" var="fornecedorInstance">
                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
                        
                            <td>${fieldValue(bean: fornecedorInstance, field: "nome")}</td>
                        
                            <td>${fieldValue(bean: fornecedorInstance, field: "cnpj")}</td>
                        
                            <td>${fieldValue(bean: fornecedorInstance, field: "razaoSocial")}</td>
                        
                            <td>${fieldValue(bean: fornecedorInstance, field: "rua")}</td>
                        
                            <td>${fieldValue(bean: fornecedorInstance, field: "numero")}</td>
                        
                        
							<td>
								<g:link action="show" id="${fornecedorInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'view.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="edit" id="${fornecedorInstance.id}">
									<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
								</g:link>
							</td>															                        	
							<td>
								<g:link action="show" id="${fornecedorInstance.id}" params="['delete': true]">
									<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
								</g:link>
							</td>															                        	
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${fornecedorInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${fornecedorInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
