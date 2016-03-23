
<%@ page import="loja.Estoque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Gerenciar Estoque</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Gerenciar Estoque</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: produtoInstance]"/>
            
            <div class="gedigblue">

            	<g:form action="list">
					<g:render template="/movel/produtoFilterInclude" />
				</g:form>
						 
				<g:form>
            	<fieldset>
            
	                <table>
	                    <thead>
	                        <tr>
	                        
	                        	<th>Código</th>

								<g:if test="${session.usuario.hasCategoriaMovel()}">
	                        		<th>Cod. Fornecedor</th>
	                        	</g:if>
	                        	
	                        	<th>Nome</th>
	                        	
	                        	<th>Descrição</th>

	                        	<th>Estoque</th>
	                        
	                    		<g:if test="${session.usuario.hasFilial && !session.usuario.lojaFilialSelected}">
		                 			<th width="5%">Transferir</th>
		                 		</g:if>
	                        </tr>
	                        
	                    </thead>
	                    <tbody>
	                    <g:each in="${produtoInstanceList}" status="i" var="produtoInstance">
	                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
	                        
	                            <td>${fieldValue(bean: produtoInstance, field: "codigo")}</td>
	                            
								<g:if test="${session.usuario.hasCategoriaMovel()}">
	                            	<td>${fieldValue(bean: produtoInstance, field: "codigoFornecedor")}</td>
	                            </g:if>
	                            
	                            <td>${fieldValue(bean: produtoInstance, field: "nome")}</td>
	
	                            <td>${fieldValue(bean: produtoInstance, field: "descricao")}</td>
	                        
								<td>
									<g:render template="/estoque/estoqueDisponivelInclude" model="[estoqueInstanceList: produtoInstance.estoques()]"/>
								</td>
																							                        	
	                    		<g:if test="${session.usuario.hasFilial && !session.usuario.lojaFilialSelected}">
									<td>
										<g:link action="transferirShow" id="${produtoInstance.id}">
											<img border="0" src="${resource(dir:'images',file:'document_exchange.png')}" />
										</g:link>
									</td>															                        	
								</g:if>
	                        
	                        </tr>
	                    </g:each>
	                    </tbody>
	                </table>
	             </fieldset>
			  </g:form>
            </div>

        </div>
    </body>
</html>
