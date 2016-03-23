

<%@ page import="loja.Secao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'secao.label', default: 'Secao')}" />
        <title>
       		<g:if test="${secaoInstance?.id}">
       			Editar Seção 
   			</g:if>
   			<g:else>
       			Incluir Seção 
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
		</script>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${secaoInstance?.id}">
       			Editar Seção
   			</g:if>
   			<g:else>
       			Incluir Seção 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: secaoInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${secaoInstance?.id}">
	               		<g:hiddenField name="id" value="${secaoInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${secaoInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="secao.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${secaoInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="descricao" class="obrigatorio"> 
										<g:message code="secao.descricao.label" default="Descrição" />	                                 
									  </label>
	                                  <g:textField name="descricao" maxlength="100" value="${secaoInstance?.descricao}" />
	                               </li>
	                           </ol>
	                       
	                               
	            				<g:if test="${session.usuario.hasCategoriaVidro()}">
				        			<ol>
				                	   <li>
		                                 <label for="percentualLucro" class=""> 
											<g:message code="secao.percentualLucro.label" default="Percentual de Lucro" />	                                 
										  </label>
		                                  <g:numberTextField name="percentualLucro" precision="2" size="10" maxlength="10" value="${secaoInstance.percentualLucro ? secaoInstance.percentualLucro : new Double(0.0)}" />
		                               </li>
		                           </ol>
		                           
				        			<ol>
				                	   <li>
		                                 <label for="maoObra" class=""> 
											<g:message code="secao.maoObra.label" default="Mão de Obra" />	                                 
										  </label>
		                                  <g:numberTextField name="maoObra" precision="2" size="10" maxlength="10" value="${secaoInstance.maoObra ? secaoInstance.maoObra : new Double(0.0)}" />
		                               </li>
		                           </ol>
		                       </g:if>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="categoria" class="obrigatorio"> 
										<g:message code="secao.categoria.label" default="Categoria" />	                                 
									  </label>
	                                  <g:select name="categoria.id" from="${loja.Categoria.findAllByLoja(loja)}" optionKey="id" value="${secaoInstance?.categoria?.id}"  />
	                               </li>
	                           </ol>
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${secaoInstance?.id}">
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
