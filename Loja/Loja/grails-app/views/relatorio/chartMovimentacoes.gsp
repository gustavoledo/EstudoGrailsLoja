
<%@ page import="loja.Usuario" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movel.label', default: 'Movel')}" />
        <title>Gráfico de Compras</title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Gráfico de Compras</h1>
            
            <g:if test="${flash.message}">
            	<div class="message">${flash.message}</div>
            </g:if>
            
            <div class="gedigblue">
            	<g:form action="chartMovimentacoes">
            		<fieldset>
						<legend>Filtro</legend>
					 
					 	<ol>
					 		<li>
					 			<label>Usuário</label>
	                        	<g:select name="usuarioId" from="${Usuario.findAllByLoja(session?.usuario?.loja)}"
	                             	noSelection="${['':'--Todos--']}" 
	                                optionKey="id" value="${params.usuarioId}"  
	                        	/>
					 		</li>
					 	</ol>
					 	
					 	<ol>
					 		<li>
					 			<label>Período</label>
					 			<div style="display:inline;">
						 			<g:datePicker name="dataInicio" precision="day" value="${params.dataInicio}" />&nbsp;&nbsp;a&nbsp;&nbsp;  
						 			<g:datePicker name="dataFim" precision="day" value="${params.dataFim}" />
					 			</div>
					 		</li>
					 	</ol>

					 </fieldset>

		            <div class="botoes-envio">
                    	<g:submitButton name="btnOK" value="OK" />
		            </div>					 	
					 
					<g:if test="${xml}">
						<g:form>
			            	<legend>Gráfico</legend>
							
			               		<g:fusionChart flashFile="Column2D.swf" dataXML="${xml}" 
			               			width="100%" height="300" chartWidth="540" chartHeight="300" />
						
							</legend>
			            </g:form>
					</g:if>
					 
	             </g:form>
            </div>

        </div>
    </body>
</html>
