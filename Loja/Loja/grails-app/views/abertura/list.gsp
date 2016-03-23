
<%@ page import="loja.vidracaria.Abertura" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'abertura.label', default: 'Abertura')}" />
        <title>Gerenciar Produto</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Produto</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Produto</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            
				<g:form>
            	<fieldset>
            
	                <table>
	                    <thead>
	                        <tr>
	                        
	                        	<th>Código</th>
	                        
	                        	<th>Nome</th>
	                        
	                        	<th>Descrição</th>
	                        
	                        	<th>Preço Unitário</th>
	                        
	                        	<th>Preço Unitário de Compra</th>
	                        
		                 		<th width="5%">Ver</th>
		                 		<th width="5%">Editar</th>
		                 		<th width="5%">Excluir</th>
	                        </tr>
	                        
	                    </thead>
	                    <tbody>
	                    <g:each in="${aberturaInstanceList}" status="i" var="aberturaInstance">
	                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
	                        
	                            <td>${fieldValue(bean: aberturaInstance, field: "codigo")}</td>
	                        
	                            <td>${fieldValue(bean: aberturaInstance, field: "nome")}</td>
	                        
	                            <td>${fieldValue(bean: aberturaInstance, field: "descricao")}</td>
	                            
	                            <td><g:formatNumber value="${aberturaInstance.precoUnitario}" /></td>
	                        
	                            <td><g:formatNumber value="${aberturaInstance.precoUnitarioCompra}" /></td>
	                        
	                        
								<td>
									<g:link action="show" id="${aberturaInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'view.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<%
										def estoques = aberturaInstance.estoques()
										boolean naoTemEstoque = estoques.size() == 1 && estoques[0].naoTemEstoque() 
									 %>
									<g:link action="${naoTemEstoque ? 'edit' : 'editVendido'}" id="${aberturaInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="show" id="${aberturaInstance.id}" params="['delete': true]">
										<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
									</g:link>
								</td>															                        	
	                        
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	                
					<g:if test="${aberturaInstanceTotal > 2}">
			            <div class="paginateButtons">
			            	<g:paginate total="${aberturaInstanceTotal}" />
			            </div>
					</g:if>            
	                
	             </fieldset>
	             
	           </g:form>
	           
	           
            </div>

        </div>
        
    </body>
</html>
