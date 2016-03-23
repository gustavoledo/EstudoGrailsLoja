<%@ page import="loja.movel.Movel" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
   		<g:javascript src="util.js" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>
       		<g:if test="${movelInstance?.id}">
       			Editar Movel 
   			</g:if>
   			<g:else>
       			Cadastrar Movel 
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
       		<g:if test="${movelInstance?.id}">
       			Editar Movel 
   			</g:if>
   			<g:else>
       			Cadastrar Movel 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
         <g:hasErrors bean="${movelInstance}">
	         <div class="errors">
	         	<g:renderErrors bean="${movelInstance}" as="list" />
	         </div>
         </g:hasErrors>
         
         <div class="gedigblue">
	            
	           <g:form method="post"  enctype="multipart/form-data">
	       			<g:if test="${movelInstance?.id}">
	               		<g:hiddenField name="id" value="${movelInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${movelInstance?.version}" />
	               	
					<g:render template="/movel/dadosInclude" />
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${movelInstance?.id}">
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
