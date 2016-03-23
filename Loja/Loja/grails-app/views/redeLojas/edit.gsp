

<%@ page import="loja.RedeLojas" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <g:set var="entityName" value="${message(code: 'redeLojas.label', default: 'RedeLojas')}" />
        <title>
       		<g:if test="${redeLojasInstance?.id}">
       			Editar Rede de Lojas 
   			</g:if>
   			<g:else>
       			Incluir Rede de Lojas 
   			</g:else>
		</title>
		
		<script>
			 $(document).ready(function(){  
				 $(function(){
					 if ($("#telefone")) {
						 $("#telefone").mask("(99) 9999-9999");  
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
       		<g:if test="${redeLojasInstance?.id}">
       			Editar Rede de Lojas 
   			</g:if>
   			<g:else>
       			Incluir Rede de Lojas 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
         <g:hasErrors bean="${redeLojasInstance}">
	         <div class="errors">
	         	<g:renderErrors bean="${redeLojasInstance}" as="list" />
	         </div>
         </g:hasErrors>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${redeLojasInstance?.id}">
	               		<g:hiddenField name="id" value="${redeLojasInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${redeLojasInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
			        			<ol>
			                	   <li>
	                                 <label for="lojaMatriz" class="obrigatorio"> 
										<g:message code="redeLojas.lojaMatriz.label" default="Loja Matriz" />	                                 
									  </label>
	                                  <g:select name="lojaMatriz.id" from="${loja.Loja.findAllByMatriz(true)}" optionKey="id" value="${redeLojasInstance?.lojaMatriz?.id}"  />
	                               </li>
	                           </ol>

			        			<ol>
			                	   <li>
	                                 <label for="lojaFilial" class="obrigatorio"> 
										<g:message code="redeLojas.lojaFilial.label" default="Loja Filial" />	                                 
									  </label>
	                                  <g:select name="lojaFilial.id" from="${loja.Loja.findAllByMatrizIsNull()}" optionKey="id" value="${redeLojasInstance?.lojaFilial?.id}"  />
	                               </li>
	                           </ol>
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${redeLojasInstance?.id}">
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
