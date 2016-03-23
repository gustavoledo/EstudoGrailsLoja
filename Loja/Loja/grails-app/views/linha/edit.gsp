

<%@ page import="loja.movel.Linha" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
   		<g:javascript src="jquery-1.4.2.min.js" />
   		<g:javascript src="jquery.format.1.05.js" />
   		<g:javascript src="jquery.maskedinput-1.2.2.js" />
        <g:set var="entityName" value="${message(code: 'linha.label', default: 'Linha')}" />
        <title>
       		<g:if test="${linhaInstance?.id}">
       			Editar ${entityName} 
   			</g:if>
   			<g:else>
       			Cadastrar ${entityName} 
   			</g:else>
		</title>
		
		<style type="text/css">
			.gedigblue input[type="checkbox"] {			    
				margin-left: 8px;
				margin-top: 4px;
			}
		</style>
		
		
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
       		<g:if test="${linhaInstance?.id}">
       			Editar ${entityName} 
   			</g:if>
   			<g:else>
       			Cadastrar ${entityName} 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: linhaInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${linhaInstance?.id}">
	               		<g:hiddenField name="id" value="${linhaInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${linhaInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="linha.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${linhaInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="coresLinha" class=""> 
										<g:message code="linha.coresLinha.label" default="Cores" />	                                 
									  </label>
									  <g:checkBoxList name="coresLinhaIds" from="${loja.Cor.findAllByLoja(loja)}" value="${linhaInstance?.coresLinha?.collect{it.cor.id}}" optionKey="id"/>
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="fabricante" class="obrigatorio"> 
										<g:message code="linha.fabricante.label" default="Fabricante" />	                                 
									  </label>
	                                  <g:select name="fabricante.id" from="${loja.Fabricante.findAllByLoja(loja)}" optionKey="id" value="${linhaInstance?.fabricante?.id}"  />
	                               </li>
	                           </ol>
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${linhaInstance?.id}">
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
