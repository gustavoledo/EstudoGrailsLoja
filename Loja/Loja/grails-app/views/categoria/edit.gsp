

<%@ page import="loja.Categoria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'categoria.label', default: 'Categoria')}" />
        <title>
       		<g:if test="${categoriaInstance?.id}">
       			Editar Categoria 
   			</g:if>
   			<g:else>
       			Cadastrar Categoria 
   			</g:else>
		</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${categoriaInstance?.id}">
       			Editar Categoria 
   			</g:if>
   			<g:else>
       			Cadastrar Categoria 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
         <g:hasErrors bean="${categoriaInstance}">
	         <div class="errors">
	         	<g:renderErrors bean="${categoriaInstance}" as="list" />
	         </div>
         </g:hasErrors>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${categoriaInstance?.id}">
	               		<g:hiddenField name="id" value="${categoriaInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${categoriaInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="sigla" class="obrigatorio"> 
										<g:message code="categoria.sigla.label" default="Sigla" />	                                 
									  </label>
	                                  <g:textField name="sigla" maxlength="6" value="${categoriaInstance?.sigla}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="categoria.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${categoriaInstance?.nome}" />
	                               </li>
	                           </ol>
	                           
	                           <ol>
	                           	  <li>
	                                 <label for="loja" class="obrigatorio"> 
										<g:message code="loja.label" default="Loja" />	                                 
									  </label>
	                                 <g:select name="loja.id" from="${loja.Loja.findAllByMatriz(true)}" optionKey="id" value="${usuarioInstance?.loja?.id}"  />
	                               </li>
	                            </ol>
	                           
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${categoriaInstance?.id}">
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
