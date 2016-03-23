

<%@ page import="loja.Usuario" %>
<%@ page import="loja.Perfil" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuário')}" />
        <title>
        	Alterar Senha
		</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
        	Alterar Senha
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: usuarioInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	                <g:hiddenField name="id" value="${usuarioInstance?.id}" />
	               	<g:hiddenField name="version" value="${usuarioInstance?.version}" />
	                <g:hiddenField name="login" value="${usuarioInstance?.login}" />
	                <g:hiddenField name="loja.id" value="${usuarioInstance?.loja?.id}" />
	                <g:hiddenField name="origemSenha" value="S" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
				       			<ol>
				               	   <li>
				               	   		<label><g:message code="usuario.nome.label" default="Nome" /></label>
				                         
				                         ${fieldValue(bean: usuarioInstance, field: "nome")}
				                         
				                    </li>
				                 </ol>
				                 
				       			<ol>
				               	   <li>
				               	   		<label><g:message code="usuario.login.label" default="Login" /></label>
				                         
				                         ${fieldValue(bean: usuarioInstance, field: "login")}
				                         
				                    </li>
				                 </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="senha" class="obrigatorio"> 
										<g:message code="usuario.senha.label" default="Senha" />	                                 
									  </label>
	                                  <g:passwordField name="senha" maxlength="10" value="${usuarioInstance?.senha}" />
	                               </li>
	                           </ol>
	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:actionSubmit id="btnSalvar" action="update" value="Salvar" />
	               </div>
           </g:form>
         </div>
    </body>
</html>
