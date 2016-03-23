
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Usuário
	        </g:if>
	        <g:else>
	        	Ver Usuário
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Usuário
	        </g:if>
	        <g:else>
	        	Ver Usuário
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${usuarioInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="usuario.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: usuarioInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
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
               	   		<label><g:message code="usuario.perfil.label" default="Perfil" /></label>
                         
                         ${usuarioInstance?.perfil?.encodeAsHTML()}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="usuario.loja.label" default="Loja" /></label>
                         
                         ${usuarioInstance?.loja}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="usuario.descontoMaximo.label" default="Desconto Máximo" /></label>
                         
                         ${fieldValue(bean: usuarioInstance, field: "descontoMaximo")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="usuario.inativo.label" default="Inativo" /></label>
                         
                         ${usuarioInstance.inativo ? "Sim" : "Não"}
                         
                    </li>
                 </ol>

                 
          	</fieldset>
            <div class="botoes-envio">
                <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                <g:if test="${params.delete}">
                	<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Tem certeza que deseja excluir o registro?')}');" /></span>
                </g:if>
            </div>
          </g:form>
        </div>
    </body>
</html>
