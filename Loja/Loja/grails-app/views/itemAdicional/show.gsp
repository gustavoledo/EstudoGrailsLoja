
<%@ page import="loja.vidracaria.ItemAdicional" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'itemAdicional.label', default: 'ItemAdicional')}" />
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
             <g:hiddenField name="id" value="${itemAdicionalInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="itemAdicional.secao.label" default="Seção" /></label>
                         
                         <g:link controller="secao" action="show" id="${itemAdicionalInstance?.secao?.id}">${itemAdicionalInstance?.secao?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="itemAdicional.codigo.label" default="Código" /></label>
                         
                         ${fieldValue(bean: itemAdicionalInstance, field: "codigo")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="itemAdicional.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: itemAdicionalInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="itemAdicional.precoUnitario.label" default="Preço Unitário" /></label>
                         
                         <g:formatNumber value="${itemAdicionalInstance?.precoUnitario}" />
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="itemAdicional.precoUnitarioCompra.label" default="Preço Unitário de Compra" /></label>
                         
                         <g:formatNumber value="${itemAdicionalInstance?.precoUnitarioCompra}" />
                         
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
