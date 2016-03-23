
<%@ page import="loja.ProdutoDemo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produtoDemo.label', default: 'ProdutoDemo')}" />
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
             <g:hiddenField name="id" value="${produtoDemoInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.codigo.label" default="Codigo" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "codigo")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.nome.label" default="Nome" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "nome")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.descricao.label" default="Descricao" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "descricao")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.precoUnitario.label" default="Preco Unitario" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "precoUnitario")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.precoUnitarioCompra.label" default="Preco Unitario Compra" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "precoUnitarioCompra")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.foto.label" default="Foto" /></label>
                         
                         ${fieldValue(bean: produtoDemoInstance, field: "foto")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.fabricante.label" default="Fabricante" /></label>
                         
                         <g:link controller="fabricante" action="show" id="${produtoDemoInstance?.fabricante?.id}">${produtoDemoInstance?.fabricante?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="produtoDemo.secao.label" default="Secao" /></label>
                         
                         <g:link controller="secao" action="show" id="${produtoDemoInstance?.secao?.id}">${produtoDemoInstance?.secao?.encodeAsHTML()}</g:link>
                         
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
