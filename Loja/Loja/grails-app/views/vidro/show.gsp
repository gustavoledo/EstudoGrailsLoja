
<%@ page import="loja.vidracaria.Vidro" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vidro.label', default: 'Vidro')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Vidro/Alum.
	        </g:if>
	        <g:else>
	        	Ver Vidro/Alum.
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Vidro/Alum.
	        </g:if>
	        <g:else>
	        	Ver Vidro/Alum.
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${vidroInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.secao.label" default="Seção" /></label>
                         
                         <g:link controller="secao" action="show" id="${vidroInstance?.secao?.id}">${vidroInstance?.secao?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.fabricante.label" default="Fabricante" /></label>
                         
                         <g:link controller="fabricante" action="show" id="${vidroInstance?.fabricante?.id}">${vidroInstance?.fabricante?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.codigo.label" default="Código" /></label>
                         
                         ${fieldValue(bean: vidroInstance, field: "codigo")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: vidroInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.espessura.label" default="Espessura" /></label>
                         
                         ${fieldValue(bean: vidroInstance, field: "espessura")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.cor.label" default="Cor" /></label>
                         
                         <g:link controller="cor" action="show" id="${vidroInstance?.cor?.id}">${vidroInstance?.cor?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.precoUnitario.label" default="Preco Unitário" /></label>
                         
                         <g:formatNumber value="${vidroInstance?.precoUnitario}" />
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="vidro.precoUnitarioCompra.label" default="Preco Unitário de Compra" /></label>
                         
                         <g:formatNumber value="${vidroInstance?.precoUnitarioCompra}" />
                         
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
