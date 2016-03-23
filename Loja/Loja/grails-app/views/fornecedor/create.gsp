

<%@ page import="loja.Fornecedor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'fornecedor.label', default: 'Fornecedor')}" />
        <title>
       		<g:if test="${fornecedorInstance?.id}">
       			Editar Fornecedor 
   			</g:if>
   			<g:else>
       			Incluir Fornecedor 
   			</g:else>
		</title>
		
		<script>
			 $(document).ready(function(){  
				 $(function(){
					 if ($("#telefone")) {
						 $("#telefone").mask("(99) 9999-9999");  
					 }

					 if ($("#telefoneResidencial")) {
						 $("#telefoneResidencial").mask("(99) 9999-9999");  
					 }

					 if ($("#telefoneCelular")) {
						 $("#telefoneCelular").mask("(99) 9999-9999");  
					 }

					 if ($("#telefoneComercial")) {
						 $("#telefoneComercial").mask("(99) 9999-9999");  
					 }

					 if ($("#fax")) {
						 $("#fax").mask("(99) 9999-9999");  
					 }
					 
					 if ($("#cep")) {
						 $("#cep").mask("99999-999");  
					 }

					 if ($("#cpf")) {
						 $("#cpf").mask("999.999.999-99");  
					 }

					 if ($("#cnpj")) {
						 $("#cnpj").mask("99.999.999/9999-99");  
					 }
				 });  
			}); 		
		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${fornecedorInstance?.id}">
       			Editar Fornecedor 
   			</g:if>
   			<g:else>
       			Incluir Fornecedor 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
         <g:hasErrors bean="${fornecedorInstance}">
	         <div class="errors">
	         	<g:renderErrors bean="${fornecedorInstance}" as="list" />
	         </div>
         </g:hasErrors>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${fornecedorInstance?.id}">
	               		<g:hiddenField name="id" value="${fornecedorInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${fornecedorInstance?.version}" />
	               	<g:hiddenField name="origemMovimentacao" value="${params.origemMovimentacao}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="fornecedor.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${fornecedorInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="cnpj" class="obrigatorio"> 
										<g:message code="fornecedor.cnpj.label" default="CNPJ" />	                                 
									  </label>
	                                  <g:textField name="cnpj" value="${fornecedorInstance?.cnpj}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="razaoSocial" class="obrigatorio"> 
										<g:message code="fornecedor.razaoSocial.label" default="Razão Social" />	                                 
									  </label>
	                                  <g:textField name="razaoSocial" maxlength="200" value="${fornecedorInstance?.razaoSocial}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="rua" class="obrigatorio"> 
										<g:message code="fornecedor.rua.label" default="Rua" />	                                 
									  </label>
	                                  <g:textField name="rua" value="${fornecedorInstance?.rua}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="numero" class="obrigatorio"> 
										<g:message code="fornecedor.numero.label" default="Número" />	                                 
									  </label>
	                                  <g:numberTextField name="numero" precision="0" size="10" maxlength="10" value="${fieldValue(bean: fornecedorInstance, field: 'numero')}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="complemento" class=""> 
										<g:message code="fornecedor.complemento.label" default="Complemento" />	                                 
									  </label>
	                                  <g:textField name="complemento" value="${fornecedorInstance?.complemento}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="bairro" class="obrigatorio"> 
										<g:message code="fornecedor.bairro.label" default="Bairro" />	                                 
									  </label>
	                                  <g:textField name="bairro" maxlength="80" value="${fornecedorInstance?.bairro}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="cidade" class="obrigatorio"> 
										<g:message code="fornecedor.cidade.label" default="Cidade" />	                                 
									  </label>
	                                  <g:textField name="cidade" maxlength="80" value="${fornecedorInstance?.cidade}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="cep" class="obrigatorio"> 
										<g:message code="fornecedor.cep.label" default="Cep" />	                                 
									  </label>
	                                  <g:textField name="cep" value="${fornecedorInstance?.cep}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="uf" class="obrigatorio"> 
										<g:message code="fornecedor.uf.label" default="Uf" />	                                 
									  </label>
	                                  <g:select name="uf" from="${fornecedorInstance.constraints.uf.inList}" value="${fornecedorInstance?.uf}" valueMessagePrefix="fornecedor.uf"  />
	                               </li>
	                           </ol>
	                           
			        			<ol>
			                	   <li>
	                                 <label for="telefone" class="obrigatorio"> 
										<g:message code="fornecedor.telefone.label" default="Telefone" />	                                 
									  </label>
	                                  <g:textField name="telefone" value="${fornecedorInstance?.telefone}" />
	                               </li>
	                           </ol>
	                           
			        			<ol>
			                	   <li>
	                                 <label for="fax"> 
										<g:message code="fornecedor.fax.label" default="Fax" />	                                 
									  </label>
	                                  <g:textField name="fax" value="${fornecedorInstance?.fax}" />
	                               </li>
	                           </ol>
	                           

			        			<ol>
			                	   <li>
	                                 <label for="email" > 
										<g:message code="fornecedor.email.label" default="E-mail" />	                                 
									  </label>
	                                  <g:textField name="email" value="${fornecedorInstance?.email}" />
	                               </li>
	                           </ol>
	                           
	                           
							 	<ol>
							 		<li>
		                                 <label for="observacao" > 
											<g:message code="fornecedor.observacao.label" default="Observação" />	                                 
										  </label>
		                                 <g:textArea name="observacao" value="${fornecedorInstance?.observacao}" />
							 		</li>
							 	</ol>
	                           
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${fornecedorInstance?.id}">
                    		<g:actionSubmit id="btnSalvar" action="update" value="Salvar" />
	                   </g:if>
	                   <g:else>
                    		<g:actionSubmit id="btnSalvar" action="save" value="Salvar" />
	                   </g:else>
	               </div>
           </g:form>
         </div>
    </body>
</html>
