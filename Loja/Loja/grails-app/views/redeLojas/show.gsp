
<%@ page import="loja.RedeLojas" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'redeLojas.label', default: 'RedeLojas')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Rede de Lojas
	        </g:if>
	        <g:else>
	        	Ver Rede de Lojas
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Rede de Lojas
	        </g:if>
	        <g:else>
	        	Ver Rede de Lojas
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${redeLojasInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="redeLojas.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: redeLojasInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="redeLojas.lojaFilial.label" default="Loja Filial" /></label>
                         
                         <g:link controller="loja" action="show" id="${redeLojasInstance?.lojaFilial?.id}">${redeLojasInstance?.lojaFilial?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="redeLojas.lojaMatriz.label" default="Loja Matriz" /></label>
                         
                         <g:link controller="loja" action="show" id="${redeLojasInstance?.lojaMatriz?.id}">${redeLojasInstance?.lojaMatriz?.encodeAsHTML()}</g:link>
                         
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
