
<%@ page import="loja.Cliente" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
        <title>Gerenciar Cliente</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        
        <script>
			 $(document).ready(function(){  
				 $(function(){
					 if ($("#telefone")) {
						 $("#telefone").mask("(99) 9999-9999");  
					 }
				 });  
			}); 		
        </script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Cliente</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Cliente</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            	<g:form name="form" action="filter">
            
            		<fieldset>
						<legend>Filtro</legend>
					 
					 	<ol>
					 		<li>
					 			<label>Nome</label>
					 			<g:textField name="nome" value="${params.nome}" />
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>CPF/CNPJ</label>
					 			<g:textField name="cpf" value="${params.cpf}" />
					 		</li>
					 	</ol>

					 	<ol>
					 		<li>
					 			<label>Telefone</label>
					 			<g:textField name="telefone" value="${params.telefone}" />
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
	                        
	                        	<th>Nome</th>
	                        
	                        	<th>Telefone Residencial</th>
	                        
	                        	<th>Telefone Celular</th>
	                        
	                        	<th>Telefone Comercial</th>
	                        
	                        	<th>E-mail</th>
	                        
		                 		<th width="5%">Ver Pedidos</th>
		                 		<th width="5%">Ver</th>
		                 		<th width="5%">Editar</th>
		                 		<th width="5%">Excluir</th>
	                        </tr>
	                        
	                    </thead>
	                    <tbody>
	                    <g:each in="${clienteInstanceList}" status="i" var="clienteInstance">
	                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
	                        
	                            <td>${fieldValue(bean: clienteInstance, field: "nome")}</td>
	                        
	                            <td>${fieldValue(bean: clienteInstance, field: "telefoneResidencial")}</td>
	                        
	                            <td>${fieldValue(bean: clienteInstance, field: "telefoneCelular")}</td>
	                        
	                            <td>${fieldValue(bean: clienteInstance, field: "telefoneComercial")}</td>
	                        
	                            <td>${fieldValue(bean: clienteInstance, field: "email")}</td>
	                        
	                        
								<td>
									<g:link action="pedidos" id="${clienteInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'document_view.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="show" id="${clienteInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'view.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="edit" id="${clienteInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
									</g:link>
								</td>															                        	
								<td>
									<g:link action="show" id="${clienteInstance.id}" params="['delete': true]">
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

			<g:if test="${clienteInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${clienteInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
