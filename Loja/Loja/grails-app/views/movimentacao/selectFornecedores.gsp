
<%@ page import="loja.Secao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Gerenciar Movimenta��o - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
   		
		<script>
			 $(document).ready(function(){  
				 $(function(){
					 if ($("#telefone")) {
						 $("#telefone").mask("(99) 9999-9999");  
					 }
	
					 if ($("#cpf")) {
						 $("#cpf").mask("999.999.999-99");  
					 }
				 });  
			}); 		
	   		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" controller="fornecedor" action="create" params="['origemMovimentacao':'S']">Novo Fornecedor</g:link></span>
        </div>
        <div class="body">
            <h1>Selecionar Fornecedor - ${params.opcaoMovimentacao == 'VENDA' ? 'Venda' : 'Compra'}</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: movimentacaoInstance]"/>
            
            <div class="gedigblue">
            	<g:form action="filterFornecedor">
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
					 			<label>CNPJ</label>
					 			<g:textField name="cnpj" value="${params.cnpj}" />
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
		                        
		                        	<th>Nome</th>
		                        
		                        	<th>CNPJ</th>
		                        
		                        	<th>Razão Social</th>
		                        
		                        </tr>
		                        
		                    </thead>
		                    <tbody>
		                    <g:each in="${fornecedorInstanceList}" status="i" var="fornecedorInstance">
		                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
		                        
		                            <td><input type="radio" name="fornecedorId" value="${fornecedorInstance.id}"  ${params.fornecedorId && params.fornecedorId.toLong() == fornecedorInstance.id ? 'checked' : ''} /></td>
		                            <td>${fornecedorInstance.nome}</td>
		                            <td>${fornecedorInstance.cnpj}</td>
		                            <td>${fornecedorInstance.razaoSocial}</td>
		                        
		                        </tr>
		                    </g:each>
		                    </tbody>
		                </table>
					 </fieldset>
					 
		            <div class="botoes-envio">
		            	<g:if test="${fornecedorInstanceList}">
                    		<g:actionSubmit id="btnOK" action="selectFormaPagamento" value="Próximo" />
                    	</g:if>
		            </div>
			     </g:form>					 	
		               
            </div>

        </div>
    </body>
</html>
