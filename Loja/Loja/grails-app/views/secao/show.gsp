
<%@ page import="loja.Secao" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'secao.label', default: 'Secao')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Seção
	        </g:if>
	        <g:else>
	        	Ver Seção
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Seção
	        </g:if>
	        <g:else>
	        	Ver Seção
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${secaoInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="secao.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: secaoInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="secao.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: secaoInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="secao.descricao.label" default="Descrição" /></label>
                         
                         ${fieldValue(bean: secaoInstance, field: "descricao")}
                         
                    </li>
                 </ol>
                 
	            <g:if test="${session.usuario.hasCategoriaVidro()}">
	       			<ol>
	               	   <li>
	               	   		<label><g:message code="secao.percentualLucro.label" default="Percentual de Lucro" /></label>
	                         
                            <g:formatNumber value="${secaoInstance.percentualLucro}" />
	                         
	                    </li>
	                 </ol>
	                 
	       			<ol>
	               	   <li>
	               	   		<label><g:message code="secao.maoObra.label" default="Mão de Obra" /></label>
	                         
                            <g:formatNumber value="${secaoInstance.maoObra}" />
	                         
	                    </li>
	                 </ol>
	                 
	            </g:if>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="secao.categoria.label" default="Categoria" /></label>
                         
                         <g:link controller="categoria" action="show" id="${secaoInstance?.categoria?.id}">${secaoInstance?.categoria?.encodeAsHTML()}</g:link>
                         
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
