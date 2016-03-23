
<%@ page import="loja.Usuario" %>
<%@ page import="loja.Perfil" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
        <title>Gerenciar Usuario</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create">Incluir Usuário</g:link></span>
        </div>
        <div class="body">
            <h1>Gerenciar Usuário</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
                <table>
                    <thead>
                        <tr>
                        
                        	<th>Nome</th>
                        
                        	<th>Login</th>
                        
                        	<th>Perfil</th>
                        
                        	<th>Loja</th>
                        	
                        	<th>Desconto Máximo</th>

                        	<th>Inativo</th>
                        	
	                 		<th width="5%">Ver</th>
	                 		<th width="5%">Editar</th>
	                 		<th width="5%">Excluir</th>
                        </tr>
                        
                    </thead>
                    <tbody>
                    <g:each in="${usuarioInstanceList}" status="i" var="usuarioInstance">
                    	<g:if test="${session.usuario.perfil == Perfil.MASTER || usuarioInstance.login != 'usermaster'}">
	                        <tr class="${(i % 2) == 0 ? 'zebra' : ' '}">
	                        
	                            <td>${fieldValue(bean: usuarioInstance, field: "nome")}</td>
	                        
	                            <td>${fieldValue(bean: usuarioInstance, field: "login")}</td>
	                        
	                            <td>${fieldValue(bean: usuarioInstance, field: "perfil")}</td>

	                            <td>${fieldValue(bean: usuarioInstance, field: "loja")}</td>
	                        
	                            <td>${fieldValue(bean: usuarioInstance, field: "descontoMaximo")}</td>

	                            <td>${usuarioInstance.inativo ? "Sim" : "Não"}</td>
	                        
								<td>
									<g:link action="show" id="${usuarioInstance.id}">
										<img border="0" src="${resource(dir:'images',file:'view.png')}" />
									</g:link>
								</td>
								
                    			<g:if test="${session.usuario.perfil == Perfil.MASTER || session.usuario.perfil == Perfil.ADMINISTRADOR 
										|| session.usuario.perfil == Perfil.GERENTE || usuarioInstance.perfil == Perfil.VENDEDOR}">
									<td>
										<g:link action="edit" id="${usuarioInstance.id}">
											<img border="0" src="${resource(dir:'images',file:'edit.png')}" />
										</g:link>
									</td>															                        	
									<td>
										<g:link action="show" id="${usuarioInstance.id}" params="['delete': true]">
											<img border="0" src="${resource(dir:'images',file:'delete16.png')}" />
										</g:link>
									</td>
								</g:if>
								<g:else>
									<td></td>
									<td></td>
								</g:else>																								                        	
	                        
	                        </tr>
                    	
                    	</g:if>
                    </g:each>
                    </tbody>
                </table>
            </div>

			<g:if test="${usuarioInstanceTotal > 2}">
	            <div class="paginateButtons">
	            	<g:paginate total="${usuarioInstanceTotal}" />
	            </div>
			</g:if>            
        </div>
    </body>
</html>
