
<%@ page import="loja.movimentacao.MovimentacaoEstoque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'movimentacaoEstoque.label', default: 'MovimentacaoEstoque')}" />
        <title>
	        <g:if test="${params.delete}">
	        	Excluir Movimentação de estoque
	        </g:if>
	        <g:else>
	        	Ver Movimentação de estoque
	        </g:else>
        </title>
    </head>
    <body class="tundra">
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    
        <h1>
	        <g:if test="${params.delete}">
	        	Excluir Movimentação de estoque
	        </g:if>
	        <g:else>
	        	Ver Movimentação de estoque
	        </g:else>
		</h1>
		
        <g:if test="${flash.message}">
        	<div class="message">${flash.message}</div>
        </g:if>
        
        <div class="gedigblue">

           <g:form>
             <g:hiddenField name="id" value="${movimentacaoEstoqueInstance?.id}" />

             <fieldset>
             	<legend>Dados</legend>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movimentacaoEstoque.id.label" default="Id" /></label>
                         
                         ${fieldValue(bean: movimentacaoEstoqueInstance, field: "id")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movimentacaoEstoque.produto.label" default="Produto" /></label>
                         
                         <g:link controller="produto" action="show" id="${movimentacaoEstoqueInstance?.produto?.id}">${movimentacaoEstoqueInstance?.produto?.encodeAsHTML()}</g:link>
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movimentacaoEstoque.quantidade.label" default="Quantidade" /></label>
                         
                         ${fieldValue(bean: movimentacaoEstoqueInstance, field: "quantidade")}
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movimentacaoEstoque.data.label" default="Data" /></label>
                         
                         <g:formatDate date="${movimentacaoEstoqueInstance?.data}" />
                         
                    </li>
                 </ol>
                 
       			<ol>
               	   <li>
               	   		<label><g:message code="movimentacaoEstoque.operacao.label" default="Operacao" /></label>
                         
                         ${fieldValue(bean: movimentacaoEstoqueInstance, field: "operacao")}
                         
                    </li>
                 </ol>

       			<ol>
               	   <li>
               	   		<label><g:message code="movimentacaoEstoque.observacao.label" default="Observação" /></label>
                         
                         ${fieldValue(bean: movimentacaoEstoqueInstance, field: "observacao")}
                         
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
