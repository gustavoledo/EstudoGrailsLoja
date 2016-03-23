<%@ page import="loja.Cliente" %>
<%@ page import="loja.Perfil" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
   		<g:javascript src="util.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cliente.label', default: 'Cliente')}" />
        <title>
       		<g:if test="${clienteInstance?.id}">
       			Editar Cliente 
   			</g:if>
   			<g:else>
       			Incluir Cliente 
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
					 
					 if ($("#cep")) {
						 $("#cep").mask("99999-999");  
					 }

					 habilitaDadosPessoa($('input[name="tipoPessoa"]:checked').val())
					 
					 $('input[name="tipoPessoa"]').click(function() {
						 habilitaDadosPessoa($(this).val())
					 });

				 });  
			});

			function habilitaDadosPessoa(tipoPessoa) {
				 if (tipoPessoa == 'F') {
					 $('input[name="cpf"]').unmask();
					 $('input[name="cpf"]').mask('999.999.999-99');
				 } else {
					 $('input[name="cpf"]').unmask();
					 $('input[name="cpf"]').mask('99.999.999/9999-99');
				 }
			} 	


		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${clienteInstance?.id}">
       			Editar Cliente 
   			</g:if>
   			<g:else>
       			Incluir Cliente 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: clienteInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${clienteInstance?.id}">
	               		<g:hiddenField name="id" value="${clienteInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${clienteInstance?.version}" />
	               	<g:hiddenField name="origemMovimentacao" value="${params.origemMovimentacao}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="cliente.nome.label" default="Nome/Razão Social" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${clienteInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="telefoneResidencial" class=""> 
										<g:message code="cliente.telefoneResidencial.label" default="Telefone Residencial" />	                                 
									  </label>
	                                  <g:textField name="telefoneResidencial" value="${clienteInstance?.telefoneResidencial}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="telefoneCelular" class=""> 
										<g:message code="cliente.telefoneCelular.label" default="Telefone Celular" />	                                 
									  </label>
	                                  <g:textField name="telefoneCelular" value="${clienteInstance?.telefoneCelular}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="telefoneComercial" class=""> 
										<g:message code="cliente.telefoneComercial.label" default="Telefone Comercial" />	                                 
									  </label>
	                                  <g:textField name="telefoneComercial" value="${clienteInstance?.telefoneComercial}" />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="radioNextel" class=""> 
										<g:message code="cliente.radioNextel.label" default="Radio Nextel" />	                                 
									  </label>
	                                  <g:textField name="radioNextel" value="${clienteInstance?.radioNextel}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="email" class=""> 
										<g:message code="cliente.email.label" default="E-mail" />	                                 
									  </label>
	                                  <g:textField name="email" value="${clienteInstance?.email}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="sexo" class="obrigatorio"> 
										<g:message code="cliente.sexo.label" default="Sexo" />	                                 
									  </label>
	                                  <g:select name="sexo" from="${clienteInstance.constraints.sexo.inList}" value="${clienteInstance?.sexo}" valueMessagePrefix="cliente.sexo"  />
	                               </li>
	                           </ol>
	                       

			        			<ol>
			                	   <li>
	                                 <label for="rg"> 
										<g:message code="cliente.rg.label" default="RG/Inscrição Estadual" />	                                 
									  </label>
	                                  <g:textField name="rg" value="${clienteInstance?.rg}" />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                  <label>Tipo</label>
									  <input type="radio" name="tipoPessoa" value="F" ${params.tipoPessoa == 'F' ? 'checked="checked"': ''} />Pessoa Física	                                 
									  <input type="radio" name="tipoPessoa" value="J" ${params.tipoPessoa == 'J' ? 'checked="checked"': ''} />Pessoa Jurídica	                                 
	                               </li>
	                           </ol>
	                               
			        			<ol>
			                	   <li>
	                                 <label for="cpf"> 
										<g:message code="cliente.cpf.label" default="CPF/CNPJ" />	                                 
									  </label>
	                                  <g:textField name="cpf" value="${clienteInstance?.cpf}" />
	                               </li>
	                           </ol>
	                       
		        				<g:if test="${session.usuario.hasCategoriaMovel() && session.usuario.perfil != Perfil.VENDEDOR}">
				        			<ol>
				                	   <li>
		                                    <label for="vendedorComissao"> 
												<g:message code="cliente.vendedorComissao.label" default="Vendedor para comissão" />	                                 
										    </label>
				                        	<g:select name="vendedorComissao.id" from="${usuarioInstanceList}"
				                             	noSelection="${['':'--Todos--']}" 
				                                optionKey="id" value="${clienteInstance?.vendedorComissao}"  
				                        	/>
		                               </li>
		                           </ol>
		        				</g:if>

								<div id="contatos">
				        			<ol>
				                	   <li>
		                                 <label for="contato1"> 
											<g:message code="cliente.contato1.label" default="Contato 1" />	                                 
										  </label>
		                                  <g:textField name="contato1" value="${clienteInstance?.contato1}" />
		                               </li>
		                           </ol>
	
				        			<ol>
				                	   <li>
		                                 <label for="contato2"> 
											<g:message code="cliente.contato2.label" default="Contato 2" />	                                 
										  </label>
		                                  <g:textField name="contato2" value="${clienteInstance?.contato2}" />
		                               </li>
		                           </ol>
								</div>
	                               
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
	                                 <label for="cep"> 
										<g:message code="cliente.cep.label" default="CEP" />	                                 
									  </label>
	                                  <g:textField name="cep" value="${clienteInstance?.cep}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="uf" class="obrigatorio"> 
										<g:message code="cliente.uf.label" default="UF" />	                                 
									  </label>
	                                  <g:select name="uf" from="${clienteInstance.constraints.uf.inList}" value="${clienteInstance?.uf}" valueMessagePrefix="cliente.uf"  />
	                               </li>
	                           </ol>
	                           
			        			<ol>
			                	   <li>
	                                 <label for="referencia" class="obrigatorio"> 
										<g:message code="referencia.cep.label" default="Referência" />	                                 
									  </label>
	                                  <g:textField name="referencia" value="${clienteInstance?.referencia}" />
	                               </li>
	                           </ol>
	                           
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${clienteInstance?.id}">
                    		<g:actionSubmit id="btnSalvar" action="update" onclick="return validateFields()" value="Salvar" />
	                   </g:if>
	                   <g:else>
                    		<g:actionSubmit id="btnSalvar" action="save" onclick="return validateFields()" value="Salvar" />
	                   </g:else>
	               </div>
           </g:form>
         </div>
    </body>
</html>
