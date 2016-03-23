
<%@ page import="loja.movimentacao.Orcamento" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orcamento.label', default: 'Or�amento')}" />
        <title>Gerenciar Orçamento</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Gerenciar Orçamento</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            	<g:form name="form" action="filter">
            
            		<fieldset>
						<legend>Filtro</legend>

					 	<ol>
					 		<li>
					 			<label>Número</label>
					 			<g:textField name="id" value="${params.id}" />
					 		</li>
					 	</ol>
					 
					 	<ol>
					 		<li>
					 			<label>Cliente</label>
					 			<g:textField name="nomeCliente" value="${params.nome}" />
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>Funcionário</label>
	                        	<g:select name="usuarioId" from="${usuarioInstanceList}"
	                             	noSelection="${['':'--Todos--']}" 
	                                optionKey="id" value="${params.usuarioId}"  
		                        />
					 		</li>
					 	</ol>

					 </fieldset>

		            <div class="botoes-envio">
                    	<g:submitButton name="btnOK" value="OK" />
		            </div>					 	
            
				<fieldset>            
	                <table>
	                    <thead>
	                        <tr>
	                        
	                        	<th width="7%">Número</th>
	                        	
	                        	<th>Data</th>
	                        
	                        	<th>Cliente</th>
	                        	
	                            <th>Funcionário</th>
	                        
		                 		<th width="5%">Ver</th>
		                 		<th width="5%">Excluir</th>
	                        </tr>
	                        
	                    </thead>
	                    <tbody>
	                    <g:each in="${orcamentoInstanceList}" status="i" var="orcamentoInstance">
	                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
	               
	               	            <td>${fieldValue(bean: orcamentoInstance, field: "id")}</td>
	               	             
	                            <td><g:formatDate date="${orcamentoInstance.data}" /></td>
	                        
	                            <td>${fieldValue(bean: orcamentoInstance, field: "cliente")}</td>
	                        
	                            <td>${fieldValue(bean: orcamentoInstance, field: "usuario")}</td>
	                        
								<td>
									<g:link action="show" id="${orcamentoInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'view.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="show" id="${orcamentoInstance.id}" params="['delete': true]">
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

			<g:if test="${orcamentoInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${orcamentoInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
