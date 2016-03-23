
<%@ page import="loja.Estoque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Transferir Estoque</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Transferir Estoque</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: produtoInstance]"/>
            
            <div class="gedigblue">
				<g:form action="save">
	               <g:hiddenField name="id" value="${params.id}" />
	            	<fieldset>
                          <ol>
                          	  <li>
                                <label for="loja" class="obrigatorio"> 
									<g:message code="loja.label" default="Loja Origem" />	                                 
							  	</label>
                              	<g:select name="lojaOrigemId" from="${lojas}" optionKey="id" value="${params.lojaOrigemId}"  />
                              </li>
                          </ol>
                          <ol>
                          	  <li>
                                <label for="loja" class="obrigatorio"> 
									<g:message code="loja.label" default="Loja Destino" />	                                 
							  	</label>
                              	<g:select name="lojaDestinoId" from="${lojas}" optionKey="id" value="${params.lojaDestinoId}"  />
                              </li>
                          </ol>
                          <ol>
                          	  <li>
                                <label for="quantidade" class="obrigatorio"> 
									Quantidade	                                 
							  	</label>
								<g:numberTextField name="quantidade" precision="0" size="10" maxlength="10" value="${params.quantidade ? params.quantidade : 0}" />
                              </li>
                          </ol>
		            </fieldset>
		            
	                <div class="botoes-envio">
                    	<g:actionSubmit id="btnSalvar" action="save" value="Transferir" />
	               </div>
		            
			  </g:form>
            </div>

        </div>
    </body>
</html>
