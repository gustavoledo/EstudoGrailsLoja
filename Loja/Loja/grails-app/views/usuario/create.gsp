

<%@ page import="loja.Usuario" %>
<%@ page import="loja.Perfil" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
        <title>
       		<g:if test="${usuarioInstance?.id}">
       			Editar Usuário 
   			</g:if>
   			<g:else>
       			Incluir Usuário 
   			</g:else>
		</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        
         <h1>
       		<g:if test="${usuarioInstance?.id}">
       			Editar Usuário 
   			</g:if>
   			<g:else>
       			Incluir Usuário 
   			</g:else>
         </h1>
         
         <g:if test="${flash.message}">
         	<div class="message">${flash.message}</div>
         </g:if>
         
		<g:render template="/layouts/flashErrorInclude" model="[modelInstance: usuarioInstance]"/>
         
         <div class="gedigblue">
	            
	           <g:form method="post" >
	       			<g:if test="${usuarioInstance?.id}">
	               		<g:hiddenField name="id" value="${usuarioInstance?.id}" />
	               	</g:if>
	               	<g:hiddenField name="version" value="${usuarioInstance?.version}" />
	               	
	                <fieldset>
	                	<legend>Dados</legend>
	                	
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="nome" class="obrigatorio"> 
										<g:message code="usuario.nome.label" default="Nome" />	                                 
									  </label>
	                                  <g:textField name="nome" maxlength="80" value="${usuarioInstance?.nome}" />
	                               </li>
	                           </ol>
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="login" class="obrigatorio"> 
										<g:message code="usuario.login.label" default="Login" />	                                 
									  </label>
	                                  <g:textField name="login" maxlength="10" value="${usuarioInstance?.login}" />
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
	                       
	                               
			        			<ol>
			                	   <li>
	                                 <label for="perfil" class="obrigatorio"> 
										<g:message code="usuario.perfil.label" default="Perfil" />	                                 
									  </label>
									  <g:if test="${session.usuario.perfil == Perfil.MASTER}">
	                                  	<g:select name="perfil" from="${loja.Perfil?.values()}" value="${usuarioInstance?.perfil}"  />
									  </g:if>
									  <g:if test="${session.usuario.perfil == Perfil.ADMINISTRADOR}">
	                                  	<g:select name="perfil" from="${[Perfil.ADMINISTRADOR, Perfil.GERENTE, Perfil.VENDEDOR]}" value="${usuarioInstance?.perfil}"  />
									  </g:if>
									  <g:if test="${session.usuario.perfil == Perfil.GERENTE}">
	                                  	<g:select name="perfil" from="${[Perfil.VENDEDOR]}" value="${usuarioInstance?.perfil}"  />
									  </g:if>
	                               </li>
	                           </ol>
	                           
							   <g:if test="${session.usuario.perfil == Perfil.MASTER || session.usuario.hasFilial}">
		                           <ol>
		                           	  <li>
		                                 <label for="loja" class="obrigatorio"> 
											<g:message code="loja.label" default="Loja" />	                                 
										  </label>
		                                  <g:select name="loja.id" from="${lojas}" optionKey="id" value="${usuarioInstance?.loja?.id}"  />
		                               </li>
		                            </ol>
                                </g:if>
                                <g:else>
                                	 <g:hiddenField name="loja.id" value="${session.usuario.lojaId}" />
                                </g:else>
	                           
			        			<ol>
			                	   <li>
	                                 <label for="descontoMaximo" class="obrigatorio"> 
										<g:message code="usuario.descontoMaximo.label" default="Desconto Máximo" />	                                 
									  </label>
			                    	  <g:numberTextField name="descontoMaximo" precision="2" size="10" maxlength="10" value="${usuarioInstance?.descontoMaximo}" />%
	                               </li>
	                           </ol>

	                       
	                </fieldset>
	                
	                <div class="botoes-envio">
                       <span class="button"><input type="button" value="Voltar" onclick="javascript: history.back()" ></input>  </span>
                       <g:if test="${usuarioInstance?.id}">
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
