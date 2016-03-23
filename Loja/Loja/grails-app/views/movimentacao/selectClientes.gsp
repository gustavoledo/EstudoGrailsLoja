
<%@ page import="loja.Secao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Gerenciar Movimentação - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</title>
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


			function geraOrcamento() {
				var form = document.form
				form.action = "${createLink(controller: 'orcamento', action: 'showByItens') }"
				form.submit() 
			}
				
	   	</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" controller="cliente" action="create" params="['origemMovimentacao':'S']">Novo Cliente</g:link></span>
        </div>
        <div class="body">
            <h1>Selecionar Cliente - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: movimentacaoInstance]"/>
            
            <div class="gedigblue">
            	<g:form name="form" action="filterCliente">
            		<g:hiddenField name="opcaoMovimentacao" value="${params.opcaoMovimentacao}" />
            		
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

		                        	<th></th>
		                        
		                        	<th>Nome/Razão Social</th>
		                        
		                        	<th>RG/Inscrição Estadual</th>

		                        	<th>CPF/CNPJ</th>
		                        
		                        	<th>Telefone Residencial</th>
		                        	
		                        	<th>Telefone Celular</th>
		                        	
		                        	<th>Telefone Comercial</th>
		                        
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
		                    <g:each in="${clienteInstanceList}" status="i" var="clienteInstance">
		                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
		                        
		                            <td><input type="radio" name="clienteId" value="${clienteInstance.id}"  ${params.clienteId && params.clienteId.toLong() == clienteInstance.id ? 'checked' : ''} /></td>
		                            <td>${clienteInstance.nome}</td>
		                            <td>${clienteInstance.rg}</td>
		                            <td>${clienteInstance.cpf}</td>
		                            <td>${clienteInstance.telefoneResidencial}</td>
		                            <td>${clienteInstance.telefoneCelular}</td>
		                            <td>${clienteInstance.telefoneComercial}</td>
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
					 </fieldset>
					 
		            <div class="botoes-envio">
                    	<g:actionSubmit id="btnOK" action="selectEnderecoEntrega" value="Próximo" />
	                    <input type="button" value="Orçamento" onclick="geraOrcamento()" />
		            </div>
			     </g:form>					 	
		               
            </div>

        </div>
    </body>
</html>
