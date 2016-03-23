
<%@ page import="loja.movel.Movel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Gerenciar Móvel</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="util.js" />
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Móvel</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Móvel</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">

            	<g:form action="filter">
					<g:render template="/movel/movelFilterInclude" />
				</g:form>
						 
				<g:form>
            	<fieldset>
            
	                <table>
	                    <thead>
	                        <tr>
	                        
	                        	<th>Código</th>

	                        	<th>Cod. Fornecedor</th>
	                        	
	                        	<th>Nome</th>
	                        	
	                        	<th>Fabricante</th>
	
	                        	<th>Linha</th>
	                        
	                        	<th>Tipo de Produto</th>
	                        	
	                        	<th>Descrição</th>
	                        
		                 		<th width="5%">Ver</th>
		                 		<th width="5%">Editar</th>
		                 		<th width="5%">Excluir</th>
	                        </tr>
	                        
	                    </thead>
	                    <tbody>
	                    <g:each in="${movelInstanceList}" status="i" var="movelInstance">
	                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
	                        
	                            <td>${fieldValue(bean: movelInstance, field: "codigo")}</td>
	                            
	                            <td>${fieldValue(bean: movelInstance, field: "codigoFornecedor")}</td>
	                            
	                            <td>${fieldValue(bean: movelInstance, field: "nome")}</td>
	
	                            <td>${fieldValue(bean: movelInstance, field: "fabricante")}</td>
	
	                            <td>${fieldValue(bean: movelInstance, field: "linha")}</td>
	                        
	                            <td>${fieldValue(bean: movelInstance, field: "secao")}</td>
	                            
	                            <td>${fieldValue(bean: movelInstance, field: "descricao")}</td>
	                        
								<td>
									<g:link action="show" id="${movelInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'view.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="edit" id="${movelInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="show" id="${movelInstance.id}" params="['delete': true]">
										<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
									</g:link>
								</td>															                        	
	                        
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	             </fieldset>
	             </g:form>
            </div>

			<g:if test="${movelInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${movelInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
