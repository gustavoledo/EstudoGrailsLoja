<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'loja.css')}" />
        <title>Loja - Login</title>
    </head>
    <body class="tundra">
         
        <div style="width: 60%">
        
	         <g:if test="${flash.message}">
	         	<div class="errors"><ul><li>${flash.message}</li></ul></div>
	         </g:if>
	         
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: usuarioInstance]"/>
        
	        <div class="gedigblue">
	            <h1>Loja - Login</h1>

	            <g:form controller="controleAcesso" action="logon" method="post" >
	                        
	               <fieldset>
			        	<ol>
			                <li>
	                             <label for="login">Login</label>
	                             <g:textField name="login" maxlength="10" value="${params.login}" />
			                </li>
			            </ol>
	
			        	<ol>
			                <li>
	                             <label for="senha">Senha</label>
	                             <g:passwordField name="senha" maxlength="10" value="" />
			                </li>
			            </ol>

			        </fieldset>
	                        
	                <div class="botoes-envio">
	                    <g:submitButton name="ok" value="OK" />
	                </div>
	                
	            </g:form>
	        </div>
        </div>
    </body>
</html>
