
<%@ page import="loja.movel.Linha" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'linha.label', default: 'Linha')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir ${entityName}
	        </g:if>
	        <g:else>
	        	Ver ${entityName}
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir ${entityName}
	        </g:if>
	        <g:else>
	        	Ver ${entityName}
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${linhaInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="linha.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: linhaInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="linha.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: linhaInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="linha.fabricante.label" default="Fabricante" /></label>
                         
                         <g:link controller="fabricante" action="show" id="${linhaInstance?.fabricante?.id}">${linhaInstance?.fabricante?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="linha.coresLinha.label" default="Cores Linha" /></label>
                       	<% 
                       		def coresLinha = linhaInstance.coresLinha.collect{it.cor.nome}.join(',') 
                       	%>
                       	${coresLinha}
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
