<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'loja.css')}" />
        <title>Selecionar Loja</title>
    </head>
    <body class="tundra">
         
        <div style="width: 60%">
        
	         <g:if test="${flash.message}">
	         	<div class="errors"><ul><li>${flash.message}</li></ul></div>
	         </g:if>
	         
			<g:render template="/layouts/flashErrorInclude" model="[modelInstance: usuarioInstance]"/>
        
	        <div class="gedigblue">
	            <h1>Selecionar Loja</h1>

	            <g:form controller="controleAcesso" action="selectLoja" method="post" >
	                        
	               <fieldset>
	        			<ol>
	                	   <li>
                                <label for="loja" class="obrigatorio"> 
									<g:message code="loja.selected.label" default="Selecione uma Loja" />	                                 
							  	</label>
                                <g:select name="id" from="${lojasInstanceList}" optionKey="id" value="${params.id}"  />
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
