
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Selecionar Endereço de Entrega</title>
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
   		
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
        <div class="body">
            <h1>Selecionar Endereço de Entrega</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: movimentacaoInstance]"/>
            
            <div class="gedigblue">
            	<g:form>
            		<g:hiddenField name="opcaoMovimentacao" value="VENDA" />
            		<g:hiddenField name="clienteId" value="${params.clienteId}" />

            		<fieldset>
						<legend>Dados do Cliente</legend>

		       			<ol>
		               	   <li>
		               	   		<label>Nome/Razão Social</label>
		               	   		${clienteInstance.nome}
		                    </li>
		                 </ol>

		       			<ol>
		               	   <li>
		               	   		<label>RG/Inscrição Estadual</label>
		               	   		${clienteInstance.rg}
		                    </li>
		                 </ol>

		       			<ol>
		               	   <li>
		               	   		<label>CPF/CNPJ</label>
		               	   		${clienteInstance.cpf}
		                    </li>
		                 </ol>

						
					</fieldset>
            		
            		<fieldset>
						<legend>Dados do Endereço</legend>
					 
	        			<ol>
	                	   <li>
                                <label for="rua" class="obrigatorio"> 
								<g:message code="cliente.rua.label" default="Rua" />	                                 
							  </label>
                                 <g:textField name="rua" value="${clienteInstance?.rua}" />
                              </li>
                        </ol>
                      
                              
	        			<ol>
	                	   <li>
                                <label for="numero" class="obrigatorio"> 
								<g:message code="cliente.numero.label" default="Número" />	                                 
							  </label>
                                 <g:numberTextField name="numero" precision="0" size="10" maxlength="10" value="${fieldValue(bean: clienteInstance, field: 'numero')}" />
                              </li>
                       </ol>
                      
                              
	        			<ol>
	                	   <li>
                                <label for="complemento" class=""> 
								<g:message code="cliente.complemento.label" default="Complemento" />	                                 
							  </label>
                                 <g:textField name="complemento" value="${clienteInstance?.complemento}" />
                              </li>
                        </ol>
                      
                              
	        			<ol>
	                	   <li>
                                <label for="bairro" class="obrigatorio"> 
								<g:message code="cliente.bairro.label" default="Bairro" />	                                 
							  </label>
                                 <g:textField name="bairro" maxlength="80" value="${clienteInstance?.bairro}" />
                              </li>
                        </ol>
                      
                              
	        			<ol>
	                	   <li>
                                <label for="cidade" class="obrigatorio"> 
								<g:message code="cliente.cidade.label" default="Cidade" />	                                 
							  </label>
                                 <g:textField name="cidade" maxlength="80" value="${clienteInstance?.cidade}" />
                              </li>
                        </ol>
                      
                              
	        			<ol>
	                	   <li>
                                <label for="cep" class="obrigatorio"> 
								<g:message code="cliente.cep.label" default="Cep" />	                                 
							  </label>
                                 <g:textField name="cep" value="${clienteInstance?.cep}" />
                              </li>
                        </ol>
                      
                              
	        			<ol>
	                	   <li>
                                <label for="uf" class="obrigatorio"> 
								<g:message code="cliente.uf.label" default="Uf" />	                                 
							  </label>
                                 <g:select name="uf" from="${clienteInstance.constraints.uf.inList}" value="${clienteInstance?.uf}" valueMessagePrefix="cliente.uf"  />
                              </li>
                        </ol>

	        			<ol>
	                	   <li>
                                <label for="referencia" class="obrigatorio"> 
								<g:message code="cliente.referencia.label" default="Ponto de Referência" />	                                 
							  </label>
                                 <g:textArea name="referencia" value="${clienteInstance?.referencia}" />
                              </li>
                        </ol>
	                           
					 </fieldset>
					 
		            <div class="botoes-envio">
                    	<g:actionSubmit id="btnOK" action="selectFormaPagamento" value="Próximo" />
		            </div>
			     </g:form>					 	
		               
            </div>

        </div>
    </body>
</html>
