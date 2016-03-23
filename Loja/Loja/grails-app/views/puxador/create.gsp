

<%@ page import="loja.vidracaria.Puxador" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'puxador.label', default: 'Puxador')}" />
        <title>
       		<g:if test="${puxadorInstance?.id}">
       			Editar ${entityName} 
   			</g:if>
   			<g:else>
       			Incluir ${entityName} 
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

					 if ($("#cpf")) {
						 $("#cpf").mask("999.999.999-99");  
					 }

					 if ($("#cnpj")) {
						 $("#cnpj").mask("99.999.999/9999-99");  
					 }
				 });  
			}); 		

			function calculaPrecoUnitario() {

				 var secaoId = document.getElementById('secao.id').value
				 var percentualLucro = $('input[name="percentualLucro' + secaoId + '"]').val().replace(',', '.')
				 var precoUnitarioCompra = $('#precoUnitarioCompra').val().replace(',', '.')
				 
				 if (precoUnitario) {
					 var preco = precoUnitarioCompra*(1+percentualLucro/100)
					 preco = parseFloat(preco).toFixed(2)
					 $('#precoUnitario').val(preco.replace('.', ','))
				 }

			} 	
				
		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${puxadorInstance?.id}">
       			Editar ${entityName} 
   			</g:if>
   			<g:else>
       			Incluir ${entityName} 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: puxadorInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post"  enctype="multipart/form-data">
	       			<g:if test="${puxadorInstance?.id}">
	               		<g:hiddenField name="id" value="${puxadorInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${puxadorInstance?.version}" />
			        <g:each in="${loja.Secao.findAllByLoja(loja)}" var="secao">
	               		<g:hiddenField name="percentualLucro${secao.id}" value="${secao.percentualLucro}" />
			        </g:each>
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
			        			<ol>
			                	   <li>
	                                 <label for="secao" class="obrigatorio"> 
										<g:message code="puxador.secao.label" default="Seção" />	                                 
									  </label>
	                                  <g:select name="secao.id" from="${loja.Secao.findAllByLoja(loja)}" optionKey="id" value="${puxadorInstance?.secao?.id}"  />
	                               </li>
	                           </ol>
	                	
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="puxador.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${puxadorInstance?.nome}" />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="tamanho" class="obrigatorio"> 
										<g:message code="puxador.tamanho.label" default="Tamanho" />	                                 
									  </label>
	                                  <g:numberTextField name="tamanho" precision="2" size="10" maxlength="10" value="${fieldValue(bean: puxadorInstance, field: 'tamanho')}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="cor" class="obrigatorio"> 
										<g:message code="puxador.cor.label" default="Cor" />	                                 
									  </label>
	                                  <g:select name="cor.id" from="${loja.Cor.findAllByLoja(loja)}" optionKey="id" value="${puxadorInstance?.cor?.id}"  />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="precoUnitarioCompra" class="obrigatorio"> 
										<g:message code="puxador.precoUnitarioCompra.label" default="Preço Unitário de Compra" />	                                 
									  </label>
	                                  <g:numberTextField name="precoUnitarioCompra" onblur="calculaPrecoUnitario()" precision="2" size="10" maxlength="10" value="${fieldValue(bean: puxadorInstance, field: 'precoUnitarioCompra')}" />
	                               </li>
	                           </ol>
	                       
			        			<ol>
			                	   <li>
	                                 <label for="precoUnitario" class="obrigatorio"> 
										<g:message code="puxador.precoUnitario.label" default="Preço Unitário" />	                                 
									  </label>
	                                  <g:numberTextField name="precoUnitario" precision="2" size="10" maxlength="10" value="${fieldValue(bean: puxadorInstance, field: 'precoUnitario')}" />
	                               </li>
	                           </ol>
	                       
	                               
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${puxadorInstance?.id}">
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
